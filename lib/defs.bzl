"""

# lib

```starlark
load("@bzlparty_tools//lib:defs.bzl", "...")
```

"""

load(
    "//lib/private:helpers.bzl",
    _ReleaseInfo = "ReleaseInfo",
    _declare_launcher_file = "declare_launcher_file",
    _get_binary_from_toolchain = "get_binary_from_toolchain",
    _get_files_from_toolchain = "get_files_from_toolchain",
    _get_target_file = "get_target_file",
    _platform_from_constraints = "platform_from_constraints",
    _release_arg = "release_arg",
    _write_executable_launcher_file = "write_executable_launcher_file",
)
load(
    "//lib/private:platforms.bzl",
    _HOST_CONSTRAINTS = "HOST_CONSTRAINTS",
    _HOST_PLATFORM = "HOST_PLATFORM",
    _PLATFORMS = "PLATFORMS",
)
load(
    "//lib/private/toolchains:assets_bundle.bzl",
    _assets_bundle = "assets_bundle",
)
load(
    "//lib/private/toolchains:cmd_assets.bzl",
    _cmd_assets = "cmd_assets",
)
load(
    "//lib/private/toolchains:multi_platform_assets.bzl",
    _multi_platform_assets = "multi_platform_assets",
)
load(
    "//lib/private/toolchains:platform_asset.bzl",
    _platform_asset = "platform_asset",
)
load(
    "//lib/private/toolchains:repositories.bzl",
    _binary_toolchain = "binary_toolchain",
    _platform_toolchain = "platform_toolchain",
    _platform_toolchains = "platform_toolchains",
    _register_platform_toolchains = "register_platform_toolchains",
)
load(
    "//lib/private/utils:dcomment.bzl",
    _dcomment = "dcomment",
)
load(
    "//lib/private/utils:formatter.bzl",
    _formatter = "formatter",
    _formatter_test = "formatter_test",
)
load(
    "//lib/private/utils:git_archive.bzl",
    _git_archive = "git_archive",
)
load(
    "//lib/private/utils:release_notes.bzl",
    _release_notes = "release_notes",
)
load("//lib/private/utils:sha.bzl", _sha = "sha")
load("//lib/private/utils:shellspec.bzl", _shellspec_test = "shellspec_test")
load(
    "//lib/private/utils:versioned_module_bazel.bzl",
    _versioned_module_bazel = "versioned_module_bazel",
)
load(
    ":resolved_toolchains.bzl",
    _resolved_toolchain_impl = "resolved_toolchain_impl",
)

# //lib/private/toolchains:cmd_assets
cmd_assets = _cmd_assets

# //lib/private/toolchains:multi_platform_assets
multi_platform_assets = _multi_platform_assets

# //lib/private/toolchains:platform_asset
platform_asset = _platform_asset

# //lib/private/toolchains:assets_bundle
assets_bundle = _assets_bundle

# //lib/private/toolchains:repositories.bzl
binary_toolchain = _binary_toolchain
platform_toolchain = _platform_toolchain
platform_toolchains = _platform_toolchains
register_platform_toolchains = _register_platform_toolchains

# //lib/private/toolchains:resolved_toolchain.bzl
resolved_toolchain_impl = _resolved_toolchain_impl

# //lib/private/utils:sha
sha = _sha

# //lib/private/utils:shellspec
shellspec_test = _shellspec_test

# //lib/private/utils:versioned_module_bazel
versioned_module_bazel = _versioned_module_bazel

# //lib/private/utils:git_archive
git_archive = _git_archive

# //lib/private/utils:release_notes
release_notes = _release_notes

# //lib/private/utils:dcomment
dcomment = _dcomment

# //lib/private/utils:formatter
formatter = _formatter
formatter_test = _formatter_test

# //lib/private:helpers.bzl
ReleaseInfo = _ReleaseInfo
declare_launcher_file = _declare_launcher_file
get_binary_from_toolchain = _get_binary_from_toolchain
get_files_from_toolchain = _get_files_from_toolchain
get_target_file = _get_target_file
platform_from_constraints = _platform_from_constraints
write_executable_launcher_file = _write_executable_launcher_file
release_arg = _release_arg

# //lib/private:platforms.bzl
PLATFORMS = _PLATFORMS
HOST_PLATFORM = _HOST_PLATFORM
HOST_CONSTRAINTS = _HOST_CONSTRAINTS

GO_PLATFORMS = [
    p.split("_")
    for p in PLATFORMS.keys()
]
