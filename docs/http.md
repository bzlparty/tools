<!-- Generated with Stardoc: http://skydoc.bazel.build -->

# Http Utils

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


