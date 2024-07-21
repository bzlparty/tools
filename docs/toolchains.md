<!-- Generated with Stardoc: http://skydoc.bazel.build -->


# Toolchains

Rules to setup toolchains.



<a id="binary_toolchain"></a>

## binary_toolchain

<pre>
binary_toolchain(<a href="#binary_toolchain-name">name</a>, <a href="#binary_toolchain-binary">binary</a>, <a href="#binary_toolchain-files">files</a>, <a href="#binary_toolchain-prefix">prefix</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="binary_toolchain-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="binary_toolchain-binary"></a>binary |  -   | <a href="https://bazel.build/concepts/labels">Label</a> | required |  |
| <a id="binary_toolchain-files"></a>files |  -   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional | <code>[]</code> |
| <a id="binary_toolchain-prefix"></a>prefix |  -   | String | required |  |


<a id="platform_assets"></a>

## platform_assets

<pre>
platform_assets(<a href="#platform_assets-name">name</a>, <a href="#platform_assets-algo">algo</a>, <a href="#platform_assets-binary">binary</a>, <a href="#platform_assets-files">files</a>, <a href="#platform_assets-platform">platform</a>, <a href="#platform_assets-url">url</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="platform_assets-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="platform_assets-algo"></a>algo |  -   | String | optional | <code>"384"</code> |
| <a id="platform_assets-binary"></a>binary |  -   | String | optional | <code>""</code> |
| <a id="platform_assets-files"></a>files |  -   | List of strings | optional | <code>[]</code> |
| <a id="platform_assets-platform"></a>platform |  -   | String | optional | <code>""</code> |
| <a id="platform_assets-url"></a>url |  -   | String | optional | <code>""</code> |


<a id="BinaryToolchainInfo"></a>

## BinaryToolchainInfo

<pre>
BinaryToolchainInfo(<a href="#BinaryToolchainInfo-binary">binary</a>, <a href="#BinaryToolchainInfo-files">files</a>)
</pre>

Binary Toolchain Provider

**FIELDS**


| Name  | Description |
| :------------- | :------------- |
| <a id="BinaryToolchainInfo-binary"></a>binary |  Path to binary    |
| <a id="BinaryToolchainInfo-files"></a>files |  Paths to library files    |


<a id="assets"></a>

## assets

<pre>
assets(<a href="#assets-name">name</a>, <a href="#assets-out_file">out_file</a>, <a href="#assets-kwargs">kwargs</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="assets-name"></a>name |  <p align="center"> - </p>   |  <code>"assets"</code> |
| <a id="assets-out_file"></a>out_file |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="assets-kwargs"></a>kwargs |  <p align="center"> - </p>   |  none |


<a id="multi_platform_assets"></a>

## multi_platform_assets

<pre>
multi_platform_assets(<a href="#multi_platform_assets-name">name</a>, <a href="#multi_platform_assets-url">url</a>, <a href="#multi_platform_assets-platforms">platforms</a>, <a href="#multi_platform_assets-assets_file">assets_file</a>, <a href="#multi_platform_assets-darwin_ext">darwin_ext</a>, <a href="#multi_platform_assets-windows_ext">windows_ext</a>,
                      <a href="#multi_platform_assets-set_windows_binary_ext">set_windows_binary_ext</a>, <a href="#multi_platform_assets-linux_ext">linux_ext</a>, <a href="#multi_platform_assets-binary">binary</a>, <a href="#multi_platform_assets-prefix">prefix</a>, <a href="#multi_platform_assets-files">files</a>, <a href="#multi_platform_assets-platforms_map">platforms_map</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="multi_platform_assets-name"></a>name |  <p align="center"> - </p>   |  none |
| <a id="multi_platform_assets-url"></a>url |  <p align="center"> - </p>   |  none |
| <a id="multi_platform_assets-platforms"></a>platforms |  <p align="center"> - </p>   |  none |
| <a id="multi_platform_assets-assets_file"></a>assets_file |  <p align="center"> - </p>   |  <code>"assets.bzl"</code> |
| <a id="multi_platform_assets-darwin_ext"></a>darwin_ext |  <p align="center"> - </p>   |  <code>"tar.gz"</code> |
| <a id="multi_platform_assets-windows_ext"></a>windows_ext |  <p align="center"> - </p>   |  <code>"zip"</code> |
| <a id="multi_platform_assets-set_windows_binary_ext"></a>set_windows_binary_ext |  <p align="center"> - </p>   |  <code>True</code> |
| <a id="multi_platform_assets-linux_ext"></a>linux_ext |  <p align="center"> - </p>   |  <code>"tar.gz"</code> |
| <a id="multi_platform_assets-binary"></a>binary |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="multi_platform_assets-prefix"></a>prefix |  <p align="center"> - </p>   |  <code>""</code> |
| <a id="multi_platform_assets-files"></a>files |  <p align="center"> - </p>   |  <code>[]</code> |
| <a id="multi_platform_assets-platforms_map"></a>platforms_map |  <p align="center"> - </p>   |  <code>{}</code> |


<a id="register_platform_toolchains"></a>

## register_platform_toolchains

<pre>
register_platform_toolchains(<a href="#register_platform_toolchains-name">name</a>, <a href="#register_platform_toolchains-assets">assets</a>, <a href="#register_platform_toolchains-toolchain_type">toolchain_type</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="register_platform_toolchains-name"></a>name |  <p align="center"> - </p>   |  none |
| <a id="register_platform_toolchains-assets"></a>assets |  <p align="center"> - </p>   |  none |
| <a id="register_platform_toolchains-toolchain_type"></a>toolchain_type |  <p align="center"> - </p>   |  none |


<a id="resolved_toolchain_impl"></a>

## resolved_toolchain_impl

<pre>
resolved_toolchain_impl(<a href="#resolved_toolchain_impl-toolchain">toolchain</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="resolved_toolchain_impl-toolchain"></a>toolchain |  <p align="center"> - </p>   |  none |


