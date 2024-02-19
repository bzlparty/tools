<!-- Generated with Stardoc: http://skydoc.bazel.build -->


# Github Repository Rules

These rules let you create a repository from a Github asset.


<a id="github_archive"></a>

## github_archive

<pre>
github_archive(<a href="#github_archive-path">path</a>, <a href="#github_archive-version">version</a>, <a href="#github_archive-asset">asset</a>, <a href="#github_archive-kwargs">kwargs</a>)
</pre>

Repository rule to download and extract an archive from a github release.

This is a simple wrapper around [`http_archive`](https://bazel.build/rules/lib/repo/http#http_archive),
that constructs an url form a project path, version and asset name.

```starlark
load("@bzlparty_tools//lib:github.bzl", "github_archive")

github_archive(
    name = "mylang",
    path = "myname/mylang",
    version = "0.1.0",
    asset = "mylang.tar.gz",
)
```


**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="github_archive-path"></a>path |  Github project path (owner/project).   |  none |
| <a id="github_archive-version"></a>version |  Version of the release.   |  none |
| <a id="github_archive-asset"></a>asset |  Name of the asset to download.   |  none |
| <a id="github_archive-kwargs"></a>kwargs |  All other args of [<code>http_archive</code>](https://bazel.build/rules/lib/repo/http#http_archive)   |  none |


<a id="github_binary"></a>

## github_binary

<pre>
github_binary(<a href="#github_binary-path">path</a>, <a href="#github_binary-version">version</a>, <a href="#github_binary-asset">asset</a>, <a href="#github_binary-kwargs">kwargs</a>)
</pre>

Repository rule to download binary from a github release.

This is a simple wrapper around [`http_binary`](/docs/http.md#http_binary),
that constructs an url form a project path, version and asset name.


**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="github_binary-path"></a>path |  Github project path (owner/project).   |  none |
| <a id="github_binary-version"></a>version |  Version of the release.   |  none |
| <a id="github_binary-asset"></a>asset |  Name of the asset to download.   |  none |
| <a id="github_binary-kwargs"></a>kwargs |  All other args of [<code>http_binary</code>](/docs/http.md#http_binary)   |  none |


