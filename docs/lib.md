<!-- Generated with Stardoc: http://skydoc.bazel.build -->



# lib

```starlark
load("@bzlparty_tools//lib:defs.bzl", "...")
```



<a id="http_binary"></a>

## http_binary

<pre>
http_binary(<a href="#http_binary-name">name</a>, <a href="#http_binary-build_file">build_file</a>, <a href="#http_binary-build_file_content">build_file_content</a>, <a href="#http_binary-integrity">integrity</a>, <a href="#http_binary-output">output</a>, <a href="#http_binary-repo_mapping">repo_mapping</a>, <a href="#http_binary-sha256">sha256</a>, <a href="#http_binary-url">url</a>)
</pre>


This rule works like [`http_file`](https://bazel.build/rules/lib/repo/http#http_file), but for binaries.

```starlark
http_binary(
    name = "mylang",
    url = "https://mylang.org/download/mylang-linux",
    sha256 =  "f34999afc0dc3fdccba42b4adbdb9767ce32093c24be93c6dfcbb5edbb364787",
)
```

Use the binary target as `@mylang//mylang-linux`.
  

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="http_binary-name"></a>name |  A unique name for this repository.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="http_binary-build_file"></a>build_file |  Label to <code>BUILD</code> file   | <a href="https://bazel.build/concepts/labels">Label</a> | optional | <code>None</code> |
| <a id="http_binary-build_file_content"></a>build_file_content |  Content of <code>BUILD</code> file   | String | optional | <code>""</code> |
| <a id="http_binary-integrity"></a>integrity |  Integrity   | String | optional | <code>""</code> |
| <a id="http_binary-output"></a>output |  Name of the output target By default, the rule tries to guess the name of the file by stripping the <code>basename</code> from the URL.<br><br><pre><code>starlark http_binary(     name = "mylang",     output = "linux-bin",     url = "https://mylang.org/download/mylang-linux",     sha256 =  "f34999afc0dc3fdccba42b4adbdb9767ce32093c24be93c6dfcbb5edbb364787", ) </code></pre><br><br>Use target: <code>@mylang//linux-bin</code>   | String | optional | <code>""</code> |
| <a id="http_binary-repo_mapping"></a>repo_mapping |  A dictionary from local repository name to global repository name. This allows controls over workspace dependency resolution for dependencies of this repository.&lt;p&gt;For example, an entry <code>"@foo": "@bar"</code> declares that, for any time this repository depends on <code>@foo</code> (such as a dependency on <code>@foo//some:target</code>, it should actually resolve that dependency within globally-declared <code>@bar</code> (<code>@bar//some:target</code>).   | <a href="https://bazel.build/rules/lib/dict">Dictionary: String -> String</a> | required |  |
| <a id="http_binary-sha256"></a>sha256 |  SHA 256 hash   | String | optional | <code>""</code> |
| <a id="http_binary-url"></a>url |  Url to fetch binary from   | String | required |  |


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


<a id="diff"></a>

## diff

<pre>
diff(<a href="#diff-name">name</a>, <a href="#diff-source">source</a>, <a href="#diff-target">target</a>, <a href="#diff-input">input</a>)
</pre>

Create a patch file from `source` and `target` files.

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="diff-name"></a>name |  A unique name for the target.   |  none |
| <a id="diff-source"></a>source |  Source file to create the patch for.   |  none |
| <a id="diff-target"></a>target |  Target file to compare the <code>source</code> to.   |  none |
| <a id="diff-input"></a>input |  Input patch file, optional. Defaults to a file named like the rule with the <code>patch</code> extension, e.g. <code>module_bazel.patch</code>.   |  <code>None</code> |


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


