#
# Copyright:: Copyright (c) Chef Software Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# expeditor/ignore: no version pinning

name "chef"
default_version "main"

license "Apache-2.0"
license_file "LICENSE"

# Grab accompanying notice file.
# So that Open4/deep_merge/diff-lcs disclaimers are present in Omnibus LICENSES tree.
license_file "NOTICE"

# For the specific super-special version "local_source", build the source from
# the local git checkout. This is what you'd want to occur by default if you
# just ran omnibus build locally.
version("local_source") do
  source path: "#{project.files_path}/../..",
         # Since we are using the local repo, we try to not copy any files
         # that are generated in the process of bundle installing omnibus.
         # If the install steps are well-behaved, this should not matter
         # since we only perform bundle and gem installs from the
         # omnibus cache source directory, but we do this regardless
         # to maintain consistency between what a local build sees and
         # what a github based build will see.
         options: { exclude: [ "omnibus/vendor" ] }
end

# For any version other than "local_source", fetch from github.
# This is the behavior the transitive omnibus software deps such as chef-dk
# expect.
if version != "local_source"
  source git: "https://github.com/chef/chef.git"
end

relative_path "chef"

dependency "ruby"
dependency "libarchive" # for archive resource

build do
  env = with_standard_compiler_flags(with_embedded_path)

  # The --without groups here MUST match groups in https://github.com/chef/chef/blob/main/Gemfile
  excluded_groups = %w{docgen chefstyle}
  excluded_groups << "ruby_prof" if aix?
  excluded_groups << "ruby_shadow" if aix?
  excluded_groups << "ed25519" if solaris2?

  # these are gems which are not shipped but which must be installed in the testers
  bundle_excludes = excluded_groups + %w{development test}

  bundle "install --without #{bundle_excludes.join(" ")}", env: env

  ruby "post-bundle-install.rb", env: env

  # use the rake install task to build/install chef-config/chef-utils
  command "rake install:local", env: env

  gemspec_name = if windows?
                   # Chef18 is built with ruby3.1 so platform name is changed.
                   RUBY_PLATFORM == "x64-mingw-ucrt" ? "chef-universal-mingw-ucrt.gemspec" : "chef-universal-mingw32.gemspec"
                 else
                   "chef.gemspec"
                 end

  # This step will build native components as needed - the event log dll is
  # generated as part of this step.  This is why we need devkit.
  gem "build #{gemspec_name}", env: env

  # ensure we put the gems in the right place to get picked up by the publish scripts
  delete "pkg"
  mkdir "pkg"
  copy "chef*.gem", "pkg"

  # Always deploy the powershell modules in the correct place.
  if windows?
    mkdir "#{install_dir}/modules/chef"
    copy "distro/powershell/chef/*", "#{install_dir}/modules/chef"
  end

  block do
    appbundle "chef", lockdir: project_dir, gem: "inspec-core-bin", without: excluded_groups, env: env
    appbundle "chef", lockdir: project_dir, gem: "chef-bin", without: excluded_groups, env: env
    appbundle "chef", lockdir: project_dir, gem: "chef", without: excluded_groups, env: env
    appbundle "chef", lockdir: project_dir, gem: "ohai", without: excluded_groups, env: env
  end

  # The rubyzip gem ships with some test fixture data compressed in a format Apple's notarization service
  # cannot understand. We need to delete that archive to pass notarization.
  block "Delete test folder of rubyzip gem so downstream projects pass notarization" do
    env["VISUAL"] = "echo"
    %w{rubyzip}.each do |gem|
      gem_install_dir = shellout!("#{install_dir}/embedded/bin/gem open #{gem}", env: env).stdout.chomp
      remove_directory "#{gem_install_dir}/test"
    end
  end
end
