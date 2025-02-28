#
# Copyright 2015 Chef Software, Inc.
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

name "bash"
default_version "5.1.16"

dependency "libiconv"
dependency "ncurses"

# version_list: url=https://ftp.gnu.org/gnu/bash/ filter=*.tar.gz

version("5.0")    { source sha256: "b4a80f2ac66170b2913efbfb9f2594f1f76c7b1afd11f799e22035d63077fb4d" }
version("5.1")    { source sha256: "cc012bc860406dcf42f64431bcd3d2fa7560c02915a601aba9cd597a39329baa" }
version("5.1.8")  { source sha256: "0cfb5c9bb1a29f800a97bd242d19511c997a1013815b805e0fdd32214113d6be" }
version("5.1.16") { source sha256: "5bac17218d3911834520dad13cd1f85ab944e1c09ae1aba55906be1f8192f558" }

license "GPL-3.0"
license_file "COPYING"

source url: "https://ftp.gnu.org/gnu/bash/bash-#{version}.tar.gz"

# bash builds bash as libraries into a special directory. We need to include
# that directory in lib_dirs so omnibus can sign them during macOS deep signing.
lib_dirs lib_dirs.concat ["#{install_dir}/embedded/lib/bash"]

relative_path "bash-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  # FreeBSD can build bash with this patch but it doesn't work properly
  # Things like command substitution will throw syntax errors even though the syntax is correct
  unless freebsd?
    # Fix bash race condition
    # https://lists.gnu.org/archive/html/bug-bash/2020-12/msg00051.html
    patch source: "race-condition.patch", plevel: 1, env: env
  end

  configure_command = ["./configure",
                       "--prefix=#{install_dir}/embedded"]

  if freebsd?
    # On freebsd, you have to force static linking, otherwise the executable
    # will link against the system ncurses instead of ours.
    configure_command << "--enable-static-link"

    # FreeBSD 12 system files come with mktime but for some reason running "configure"
    # doesn't detect this which results in a build failure. Setting this environment variable
    # corrects that.
    env["ac_cv_func_working_mktime"] = "yes"
  end

  command configure_command.join(" "), env: env
  make "-j #{workers}", env: env
  make "-j #{workers} install", env: env

  # We do not install bashbug in macos as it fails Notarization
  delete "#{install_dir}/embedded/bin/bashbug"
end
