#
# Copyright:: Chef Software, Inc.
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

name "cacerts"

license "MPL-2.0"
license_file "https://www.mozilla.org/media/MPL/2.0/index.815ca599c9df.txt"
skip_transitive_dependency_licensing true

default_version "2022-07-19"

source url: "https://curl.se/ca/cacert-#{version}.pem"

# versions_list: https://curl.se/docs/caextract.html
version("2022-07-19") { source sha256: "6ed95025fba2aef0ce7b647607225745624497f876d74ef6ec22b26e73e9de77" }
version("2022-04-26") { source sha256: "08df40e8f528ed283b0e480ba4bcdbfdd2fdcf695a7ada1668243072d80f8b6f" }
version("2022-03-29") { source sha256: "1979e7fe618c51ed1c9df43bba92f977a0d3fe7497ffa2a5e80dfc559a1e5a29" }
version("2022-02-01") { source sha256: "1d9195b76d2ea25c2b5ae9bee52d05075244d78fcd9c58ee0b6fac47d395a5eb" }
version("2021-10-26") { source sha256: "ae31ecb3c6e9ff3154cb7a55f017090448f88482f0e94ac927c0c67a1f33b9cf" }
version("2021-09-30") { source sha256: "f524fc21859b776e18df01a87880efa198112214e13494275dbcbd9bcb71d976" }
version("2021-07-05") { source sha256: "a3b534269c6974631db35f952e8d7c7dbf3d81ab329a232df575c2661de1214a" }
version("2021-05-25") { source sha256: "3a32ad57e7f5556e36ede625b854057ac51f996d59e0952c207040077cbe48a9" }
version("2021-01-19") { source sha256: "e010c0c071a2c79a76aa3c289dc7e4ac4ed38492bfda06d766a80b707ebd2f29" }

relative_path "cacerts-#{version}"

build do
  mkdir "#{install_dir}/embedded/ssl/certs"

  copy "#{project_dir}/cacert*.pem", "#{install_dir}/embedded/ssl/certs/cacert.pem"
  copy "#{project_dir}/cacert*.pem", "#{install_dir}/embedded/ssl/cert.pem" if windows?

  # Windows does not support symlinks
  unless windows?
    link "certs/cacert.pem", "#{install_dir}/embedded/ssl/cert.pem", unchecked: true

    block { File.chmod(0644, "#{install_dir}/embedded/ssl/certs/cacert.pem") }
  end
end
