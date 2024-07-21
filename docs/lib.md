<!-- Generated with Stardoc: http://skydoc.bazel.build -->



# lib

```starlark
load("@bzlparty_tools//lib:defs.bzl", "...")
```



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


<a id="sha"></a>

## sha

<pre>
sha(<a href="#sha-name">name</a>, <a href="#sha-algo">algo</a>, <a href="#sha-out">out</a>, <a href="#sha-src">src</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="sha-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="sha-algo"></a>algo |  -   | String | optional | <code>"384"</code> |
| <a id="sha-out"></a>out |  -   | <a href="https://bazel.build/concepts/labels">Label</a> | optional |  |
| <a id="sha-src"></a>src |  -   | <a href="https://bazel.build/concepts/labels">Label</a> | optional | <code>None</code> |


<a id="shellspec_test"></a>

## shellspec_test

<pre>
shellspec_test(<a href="#shellspec_test-name">name</a>, <a href="#shellspec_test-config">config</a>, <a href="#shellspec_test-spec">spec</a>, <a href="#shellspec_test-srcs">srcs</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="shellspec_test-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="shellspec_test-config"></a>config |  -   | <a href="https://bazel.build/concepts/labels">Label</a> | optional | <code>None</code> |
| <a id="shellspec_test-spec"></a>spec |  -   | <a href="https://bazel.build/concepts/labels">Label</a> | optional | <code>None</code> |
| <a id="shellspec_test-srcs"></a>srcs |  -   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional | <code>[]</code> |


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


