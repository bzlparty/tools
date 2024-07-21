"""

# lib

```starlark
load("@bzlparty_tools//lib:defs.bzl", "...")
```

"""

load(
    "//lib/private:assets.bzl",
    _assets = "assets",
    _multi_platform_assets = "multi_platform_assets",
    _platform_asset = "platform_asset",
)
load("//lib/private:sha.bzl", _sha = "sha")
load("//lib/private:shellspec.bzl", _shellspec_test = "shellspec_test")

# //lib/private:assets
platform_assets = _platform_asset
multi_platform_assets = _multi_platform_assets
assets = _assets

# //lib/private:sha
sha = _sha

# //lib/private:shellspec
shellspec_test = _shellspec_test
