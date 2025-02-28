#
# Copyright 2019 Chef Software, Inc.
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

name "go"
default_version "1.19"
license "BSD-3-Clause"
license_file "https://raw.githubusercontent.com/golang/go/master/LICENSE"

# Defaults
platform = "linux"
arch = "amd64"
ext = "tar.gz"

if windows?
  platform = "windows"
  ext = "zip"

  # version_list: url=https://golang.org/dl/ filter=*.windows-amd64.zip
  version("1.19")    { source sha256: "bcaaf966f91980d35ae93c37a8fe890e4ddfca19448c0d9f66c027d287e2823a" }
  version("1.18.5")  { source sha256: "73753620602d4b4469770040c53db55e5dd6af2ad07ecc18f71f164c3224eaad" }
  version("1.18.3")  { source sha256: "9c46023f3ad0300fcfd1e62f2b6c2dfd9667b1f2f5c7a720b14b792af831f071" }
  version("1.18.2")  { source sha256: "41fc44109c39a98e0c3672989ac5ad205cbb5768067e099dc4fb2b75cba922cf" }
  version("1.17.7")  { source sha256: "1b648165d62a2f5399f3c42c7e59de9f4aa457212c4ea763e1b650546fac72e2" }
  version("1.17.6")  { source sha256: "5bf8f87aec7edfc08e6bc845f1c30dba6de32b863f89ae46553ff4bbcc1d4954" }
  version("1.17.5")  { source sha256: "671faf99cd5d81cd7e40936c0a94363c64d654faa0148d2af4bbc262555620b9" }
  version("1.17.2")  { source sha256: "fa6da0b829a66f5fab7e4e312fd6aa1b2d8f045c7ecee83b3d00f6fe5306759a" }
  version("1.17")    { source sha256: "2a18bd65583e221be8b9b7c2fbe3696c40f6e27c2df689bbdcc939d49651d151" }
  version("1.16.3")  { source sha256: "a4400345135b36cb7942e52bbaf978b66814738b855eeff8de879a09fd99de7f" }

elsif mac_os_x?
  platform = "darwin"

  # version_list: url=https://golang.org/dl/ filter=*.darwin-amd64.tar.gz
  version("1.19")    { source sha256: "df6509885f65f0d7a4eaf3dfbe7dda327569787e8a0a31cbf99ae3a6e23e9ea8" }
  version("1.18.5")  { source sha256: "828eeca8b5abea3e56921df8fa4b1101380a5ebcfee10acbc8ffe7ec0bf5876b" }
  version("1.18.3")  { source sha256: "d9dcf8fc35da54c6f259be41954783a9f4984945a855d03a003a7fd6ea4c5ca1" }
  version("1.18.2")  { source sha256: "1f5f539ce0baa8b65f196ee219abf73a7d9cf558ba9128cc0fe4833da18b04f2" }
  version("1.18")    { source sha256: "70bb4a066997535e346c8bfa3e0dfe250d61100b17ccc5676274642447834969" }
  version("1.17.7")  { source sha256: "7c3d9cc70ee592515d92a44385c0cba5503fd0a9950f78d76a4587916c67a84d" }
  version("1.17.6")  { source sha256: "874bc6f95e07697380069a394a21e05576a18d60f4ba178646e1ebed8f8b1f89" }
  version("1.17.5")  { source sha256: "2db6a5d25815b56072465a2cacc8ed426c18f1d5fc26c1fc8c4f5a7188658264" }
  version("1.17.2")  { source sha256: "7914497a302a132a465d33f5ee044ce05568bacdb390ab805cb75a3435a23f94" }
  version("1.17")    { source sha256: "355bd544ce08d7d484d9d7de05a71b5c6f5bc10aa4b316688c2192aeb3dacfd1" }
  version("1.16.3")  { source sha256: "6bb1cf421f8abc2a9a4e39140b7397cdae6aca3e8d36dcff39a1a77f4f1170ac" }

elsif armhf?
  platform = "armv6l"
  # version_list: url=https://golang.org/dl/ filter=*.linux-armv6l.tar.gz
  version("1.19")    { source sha256: "25197c7d70c6bf2b34d7d7c29a2ff92ba1c393f0fb395218f1147aac2948fb93" }
  version("1.18.5")  { source sha256: "d5ac34ac5f060a5274319aa04b7b11e41b123bd7887d64efb5f44ead236957af" }
  version("1.18.3")  { source sha256: "b8f0b5db24114388d5dcba7ca0698510ea05228b0402fcbeb0881f74ae9cb83b" }
  version("1.18.2")  { source sha256: "570dc8df875b274981eaeabe228d0774985de42e533ffc8c7ff0c9a55174f697" }
  version("1.17.7")  { source sha256: "874774f078b182fa21ffcb3878467eb5cb7e78bbffa6343ea5f0fbe47983433b" }
  version("1.17.6")  { source sha256: "9ac723e6b41cb7c3651099a09332a8a778b69aa63a5e6baaa47caf0d818e2d6d" }
  version("1.17.5")  { source sha256: "aa1fb6c53b4fe72f159333362a10aca37ae938bde8adc9c6eaf2a8e87d1e47de" }
  version("1.17.2")  { source sha256: "04d16105008230a9763005be05606f7eb1c683a3dbf0fbfed4034b23889cb7f2" }
  version("1.17")    { source sha256: "ae89d33f4e4acc222bdb04331933d5ece4ae71039812f6ccd7493cb3e8ddfb4e" }
  version("1.16.3")  { source sha256: "0dae30385e3564a557dac7f12a63eedc73543e6da0f6017990e214ce8cc8797c" }
elsif arm?
  platform = "arm64"
  # version_list: url=https://golang.org/dl/ filter=*.linux-arm64.tar.gz
  version("1.19") { source sha256: "efa97fac9574fc6ef6c9ff3e3758fb85f1439b046573bf434cccb5e012bd00c8" }
  version("1.18.5")  { source sha256: "006f6622718212363fa1ff004a6ab4d87bbbe772ec5631bab7cac10be346e4f1" }
  version("1.18.3")  { source sha256: "beacbe1441bee4d7978b900136d1d6a71d150f0a9bb77e9d50c822065623a35a" }
  version("1.18.2")  { source sha256: "fc4ad28d0501eaa9c9d6190de3888c9d44d8b5fb02183ce4ae93713f67b8a35b" }
  version("1.17.7")  { source sha256: "a5aa1ed17d45ee1d58b4a4099b12f8942acbd1dd09b2e9a6abb1c4898043c5f5" }
  version("1.17.6")  { source sha256: "82c1a033cce9bc1b47073fd6285233133040f0378439f3c4659fe77cc534622a" }
  version("1.17.5")  { source sha256: "6f95ce3da40d9ce1355e48f31f4eb6508382415ca4d7413b1e7a3314e6430e7e" }
  version("1.17.2")  { source sha256: "a5a43c9cdabdb9f371d56951b14290eba8ce2f9b0db48fb5fc657943984fd4fc" }
  version("1.17")    { source sha256: "01a9af009ada22122d3fcb9816049c1d21842524b38ef5d5a0e2ee4b26d7c3e7" }
  version("1.16.3")  { source sha256: "566b1d6f17d2bc4ad5f81486f0df44f3088c3ed47a3bec4099d8ed9939e90d5d" }
else
  # version_list: url=https://golang.org/dl/ filter=*.linux-amd64.tar.gz
  version("1.19") { source sha256: "464b6b66591f6cf055bc5df90a9750bf5fbc9d038722bb84a9d56a2bea974be6" }
  version("1.18.5")  { source sha256: "9e5de37f9c49942c601b191ac5fba404b868bfc21d446d6960acc12283d6e5f2" }
  version("1.18.3")  { source sha256: "956f8507b302ab0bb747613695cdae10af99bbd39a90cae522b7c0302cc27245" }
  version("1.18.2")  { source sha256: "e54bec97a1a5d230fc2f9ad0880fcbabb5888f30ed9666eca4a91c5a32e86cbc" }
  version("1.18")    { source sha256: "e85278e98f57cdb150fe8409e6e5df5343ecb13cebf03a5d5ff12bd55a80264f" }
  version("1.17.7")  { source sha256: "02b111284bedbfa35a7e5b74a06082d18632eff824fd144312f6063943d49259" }
  version("1.17.6")  { source sha256: "231654bbf2dab3d86c1619ce799e77b03d96f9b50770297c8f4dff8836fc8ca2" }
  version("1.17.5")  { source sha256: "bd78114b0d441b029c8fe0341f4910370925a4d270a6a590668840675b0c653e" }
  version("1.17.2")  { source sha256: "f242a9db6a0ad1846de7b6d94d507915d14062660616a61ef7c808a76e4f1676" }
  version("1.17")    { source sha256: "6bf89fc4f5ad763871cf7eac80a2d594492de7a818303283f1366a7f6a30372d" }
  version("1.16.3")  { source sha256: "951a3c7c6ce4e56ad883f97d9db74d3d6d80d5fec77455c6ada6c1f7ac4776d2" }
end

source url: "https://dl.google.com/go/go#{version}.%{platform}-%{arch}.%{ext}" % { platform: platform, arch: arch, ext: ext }

build do
  # We do not use 'sync' since we've found multiple errors with other software definitions
  mkdir "#{install_dir}/embedded/go"
  copy "#{project_dir}/go/*", "#{install_dir}/embedded/go"

  mkdir "#{install_dir}/embedded/bin"
  %w{go gofmt}.each do |bin|
    link "#{install_dir}/embedded/go/bin/#{bin}", "#{install_dir}/embedded/bin/#{bin}"
  end
end
