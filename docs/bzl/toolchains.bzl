"""

# Toolchains

Rules and helpers to create platform-specific toolchains and use them in module extensions.

"""

load(
    "//lib:defs.bzl",
    _assets = "assets",
    _binary_toolchain = "binary_toolchain",
    _multi_platform_assets = "multi_platform_assets",
    _platform_asset = "platform_asset",
    _platform_toolchain = "platform_toolchain",
    _platform_toolchains = "platform_toolchains",
    _register_platform_toolchains = "register_platform_toolchains",
    _resolved_toolchain_impl = "resolved_toolchain_impl",
)

assets = _assets
multi_platform_assets = _multi_platform_assets
platform_assets = _platform_asset

binary_toolchain = _binary_toolchain
platform_toolchain = _platform_toolchain
platform_toolchains = _platform_toolchains
register_platform_toolchains = _register_platform_toolchains

resolved_toolchain_impl = _resolved_toolchain_impl
