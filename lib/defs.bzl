"""

# lib

```starlark
load("@bzlparty_tools//lib:defs.bzl", "...")
```

"""

load(":jql.bzl", _jql_test = "jql_test")
load(
    ":platform_asset.bzl",
    _multi_platform_assets = "multi_platform_assets",
    _platform_asset = "platform_asset",
)
load(
    ":platforms.bzl",
    _host_platform = "host_platform",
    _is_amd64 = "is_amd64",
    _is_darwin = "is_darwin",
    _is_freebsd = "is_freebsd",
    _is_netbsd = "is_netbsd",
    _is_windows = "is_windows",
)
load(":sha.bzl", _sha = "sha")
load(":shellcheck.bzl", _shellcheck_test = "shellcheck_test")
load(":shellspec.bzl", _shellspec_test = "shellspec_test")
load(":topiary.bzl", _topiary = "topiary")
load(":typos.bzl", _typos_test = "typos_test")

jql_test = _jql_test
platform_asset = _platform_asset
multi_platform_assets = _multi_platform_assets
host_platform = _host_platform
is_amd64 = _is_amd64
is_darwin = _is_darwin
is_freebsd = _is_freebsd
is_netbsd = _is_netbsd
is_windows = _is_windows
topiary = _topiary
typos_test = _typos_test
sha = _sha
shellspec_test = _shellspec_test
shellcheck_test = _shellcheck_test
