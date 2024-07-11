<!-- Generated with Stardoc: http://skydoc.bazel.build -->



# lib

```starlark
load("@bzlparty_tools//lib:defs.bzl", "...")
```



<a id="formatter"></a>

## formatter

<pre>
formatter(<a href="#formatter-name">name</a>, <a href="#formatter-config">config</a>, <a href="#formatter-exclude">exclude</a>, <a href="#formatter-mode">mode</a>, <a href="#formatter-tools">tools</a>, <a href="#formatter-workspace">workspace</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="formatter-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="formatter-config"></a>config |  -   | <a href="https://bazel.build/concepts/labels">Label</a> | required |  |
| <a id="formatter-exclude"></a>exclude |  -   | List of strings | optional | <code>[]</code> |
| <a id="formatter-mode"></a>mode |  -   | String | optional | <code>"check"</code> |
| <a id="formatter-tools"></a>tools |  -   | <a href="https://bazel.build/rules/lib/dict">Dictionary: Label -> String</a> | required |  |
| <a id="formatter-workspace"></a>workspace |  -   | <a href="https://bazel.build/concepts/labels">Label</a> | optional | <code>@@//:MODULE.bazel</code> |


<a id="formatter_test"></a>

## formatter_test

<pre>
formatter_test(<a href="#formatter_test-name">name</a>, <a href="#formatter_test-config">config</a>, <a href="#formatter_test-exclude">exclude</a>, <a href="#formatter_test-mode">mode</a>, <a href="#formatter_test-tools">tools</a>, <a href="#formatter_test-workspace">workspace</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="formatter_test-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="formatter_test-config"></a>config |  -   | <a href="https://bazel.build/concepts/labels">Label</a> | required |  |
| <a id="formatter_test-exclude"></a>exclude |  -   | List of strings | optional | <code>[]</code> |
| <a id="formatter_test-mode"></a>mode |  -   | String | optional | <code>"check"</code> |
| <a id="formatter_test-tools"></a>tools |  -   | <a href="https://bazel.build/rules/lib/dict">Dictionary: Label -> String</a> | required |  |
| <a id="formatter_test-workspace"></a>workspace |  -   | <a href="https://bazel.build/concepts/labels">Label</a> | optional | <code>@@//:MODULE.bazel</code> |


<a id="platform_asset"></a>

## platform_asset

<pre>
platform_asset(<a href="#platform_asset-name">name</a>, <a href="#platform_asset-algo">algo</a>, <a href="#platform_asset-binary">binary</a>, <a href="#platform_asset-platform">platform</a>, <a href="#platform_asset-url">url</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="platform_asset-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="platform_asset-algo"></a>algo |  -   | String | optional | <code>"384"</code> |
| <a id="platform_asset-binary"></a>binary |  -   | String | optional | <code>""</code> |
| <a id="platform_asset-platform"></a>platform |  -   | String | optional | <code>""</code> |
| <a id="platform_asset-url"></a>url |  -   | String | optional | <code>""</code> |


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


<a id="host_platform"></a>

## host_platform

<pre>
host_platform(<a href="#host_platform-ctx">ctx</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="host_platform-ctx"></a>ctx |  <p align="center"> - </p>   |  none |


<a id="is_amd64"></a>

## is_amd64

<pre>
is_amd64(<a href="#is_amd64-platform">platform</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="is_amd64-platform"></a>platform |  <p align="center"> - </p>   |  none |


<a id="is_darwin"></a>

## is_darwin

<pre>
is_darwin(<a href="#is_darwin-platform">platform</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="is_darwin-platform"></a>platform |  <p align="center"> - </p>   |  none |


<a id="is_freebsd"></a>

## is_freebsd

<pre>
is_freebsd(<a href="#is_freebsd-platform">platform</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="is_freebsd-platform"></a>platform |  <p align="center"> - </p>   |  none |


<a id="is_netbsd"></a>

## is_netbsd

<pre>
is_netbsd(<a href="#is_netbsd-platform">platform</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="is_netbsd-platform"></a>platform |  <p align="center"> - </p>   |  none |


<a id="is_windows"></a>

## is_windows

<pre>
is_windows(<a href="#is_windows-platform">platform</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="is_windows-platform"></a>platform |  <p align="center"> - </p>   |  none |


<a id="multi_platform_assets"></a>

## multi_platform_assets

<pre>
multi_platform_assets(<a href="#multi_platform_assets-name">name</a>, <a href="#multi_platform_assets-url">url</a>, <a href="#multi_platform_assets-platforms">platforms</a>, <a href="#multi_platform_assets-darwin_ext">darwin_ext</a>, <a href="#multi_platform_assets-windows_ext">windows_ext</a>, <a href="#multi_platform_assets-linux_ext">linux_ext</a>, <a href="#multi_platform_assets-binary">binary</a>, <a href="#multi_platform_assets-prefix">prefix</a>,
                      <a href="#multi_platform_assets-platforms_map">platforms_map</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="multi_platform_assets-name"></a>name |  <p align="center"> - </p>   |  none |
| <a id="multi_platform_assets-url"></a>url |  <p align="center"> - </p>   |  none |
| <a id="multi_platform_assets-platforms"></a>platforms |  <p align="center"> - </p>   |  none |
| <a id="multi_platform_assets-darwin_ext"></a>darwin_ext |  <p align="center"> - </p>   |  <code>"tar.gz"</code> |
| <a id="multi_platform_assets-windows_ext"></a>windows_ext |  <p align="center"> - </p>   |  <code>"zip"</code> |
| <a id="multi_platform_assets-linux_ext"></a>linux_ext |  <p align="center"> - </p>   |  <code>"tar.gz"</code> |
| <a id="multi_platform_assets-binary"></a>binary |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="multi_platform_assets-prefix"></a>prefix |  <p align="center"> - </p>   |  <code>""</code> |
| <a id="multi_platform_assets-platforms_map"></a>platforms_map |  <p align="center"> - </p>   |  <code>{}</code> |


