"""
# Github Repository Rules

These rules let you create a repository from a Github asset.
"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load(":http.bzl", "http_binary")

_HOST = "https://github.com"

def _github_release_url(path, version, asset):
    return "{host}/{path}/releases/download/{version}/{asset}".format(
        host = _HOST,
        path = path,
        version = version,
        asset = asset,
    )

def github_archive(path, version, asset, **kwargs):
    """Repository rule to download and extract an archive from a github release.

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

    Args:
      path: Github project path (owner/project).
      version: Version of the release.
      asset: Name of the asset to download.
      **kwargs: All other args of [`http_archive`](https://bazel.build/rules/lib/repo/http#http_archive)
    """
    http_archive(
        url = _github_release_url(path, version, asset),
        **kwargs
    )

def github_binary(path, version, asset, **kwargs):
    """Repository rule to download binary from a github release.

    This is a simple wrapper around [`http_binary`](/docs/http.md#http_binary),
    that constructs an url form a project path, version and asset name.

    Args:
      path: Github project path (owner/project).
      version: Version of the release.
      asset: Name of the asset to download.
      **kwargs: All other args of [`http_binary`](/docs/http.md#http_binary)
    """
    http_binary(
        url = _github_release_url(path, version, asset),
        **kwargs
    )
