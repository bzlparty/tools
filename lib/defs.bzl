"""

# lib

```starlark
load("@bzlparty_tools//lib:defs.bzl", "...")
```

"""

load(
    ":formatter.bzl",
    _formatter = "formatter",
    _formatter_test = "formatter_test",
)
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
load(":shellspec.bzl", _shellspec_test = "shellspec_test")

formatter = _formatter
formatter_test = _formatter_test
host_platform = _host_platform
is_amd64 = _is_amd64
is_darwin = _is_darwin
is_freebsd = _is_freebsd
is_netbsd = _is_netbsd
is_windows = _is_windows
multi_platform_assets = _multi_platform_assets
platform_asset = _platform_asset
sha = _sha
shellspec_test = _shellspec_test
