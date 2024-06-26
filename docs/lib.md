<!-- Generated with Stardoc: http://skydoc.bazel.build -->



# lib

```starlark
load("@bzlparty_tools//lib:defs.bzl", "...")
```



<a id="jql_test"></a>

## jql_test

<pre>
jql_test(<a href="#jql_test-name">name</a>, <a href="#jql_test-srcs">srcs</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="jql_test-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="jql_test-srcs"></a>srcs |  -   | <a href="https://bazel.build/concepts/labels">List of labels</a> | required |  |


<a id="platform_binary"></a>

## platform_binary

<pre>
platform_binary(<a href="#platform_binary-name">name</a>, <a href="#platform_binary-algo">algo</a>, <a href="#platform_binary-binary">binary</a>, <a href="#platform_binary-platform">platform</a>, <a href="#platform_binary-url">url</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="platform_binary-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="platform_binary-algo"></a>algo |  -   | String | optional | <code>"384"</code> |
| <a id="platform_binary-binary"></a>binary |  -   | String | optional | <code>""</code> |
| <a id="platform_binary-platform"></a>platform |  -   | String | optional | <code>""</code> |
| <a id="platform_binary-url"></a>url |  -   | String | optional | <code>""</code> |


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


<a id="shellcheck_test"></a>

## shellcheck_test

<pre>
shellcheck_test(<a href="#shellcheck_test-name">name</a>, <a href="#shellcheck_test-format">format</a>, <a href="#shellcheck_test-srcs">srcs</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="shellcheck_test-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="shellcheck_test-format"></a>format |  -   | String | optional | <code>""</code> |
| <a id="shellcheck_test-srcs"></a>srcs |  -   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional | <code>[]</code> |


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


<a id="topiary"></a>

## topiary

<pre>
topiary(<a href="#topiary-name">name</a>, <a href="#topiary-exclude">exclude</a>, <a href="#topiary-extensions">extensions</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="topiary-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="topiary-exclude"></a>exclude |  -   | List of strings | optional | <code>[]</code> |
| <a id="topiary-extensions"></a>extensions |  -   | List of strings | optional | <code>["sh", "bash"]</code> |


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


<a id="platform_binaries"></a>

## platform_binaries

<pre>
platform_binaries(<a href="#platform_binaries-name">name</a>, <a href="#platform_binaries-url">url</a>, <a href="#platform_binaries-platforms">platforms</a>, <a href="#platform_binaries-darwin_ext">darwin_ext</a>, <a href="#platform_binaries-windows_ext">windows_ext</a>, <a href="#platform_binaries-linux_ext">linux_ext</a>, <a href="#platform_binaries-binary">binary</a>, <a href="#platform_binaries-prefix">prefix</a>,
                  <a href="#platform_binaries-platforms_map">platforms_map</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="platform_binaries-name"></a>name |  <p align="center"> - </p>   |  none |
| <a id="platform_binaries-url"></a>url |  <p align="center"> - </p>   |  none |
| <a id="platform_binaries-platforms"></a>platforms |  <p align="center"> - </p>   |  none |
| <a id="platform_binaries-darwin_ext"></a>darwin_ext |  <p align="center"> - </p>   |  <code>"tar.gz"</code> |
| <a id="platform_binaries-windows_ext"></a>windows_ext |  <p align="center"> - </p>   |  <code>"zip"</code> |
| <a id="platform_binaries-linux_ext"></a>linux_ext |  <p align="center"> - </p>   |  <code>"tar.gz"</code> |
| <a id="platform_binaries-binary"></a>binary |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="platform_binaries-prefix"></a>prefix |  <p align="center"> - </p>   |  <code>""</code> |
| <a id="platform_binaries-platforms_map"></a>platforms_map |  <p align="center"> - </p>   |  <code>{}</code> |


<a id="typos_test"></a>

## typos_test

<pre>
typos_test(<a href="#typos_test-kwargs">kwargs</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="typos_test-kwargs"></a>kwargs |  <p align="center"> - </p>   |  none |


