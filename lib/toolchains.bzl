"""
# Toolchains

Rules to setup toolchains.

"""

load(
    "//lib/private:assets.bzl",
    _assets = "assets",
    _multi_platform_assets = "multi_platform_assets",
    _platform_asset = "platform_asset",
)
load(
    "//lib/private:toolchains.bzl",
    _BinaryToolchainInfo = "BinaryToolchainInfo",
    _binary_toolchain = "binary_toolchain",
    _register_platform_toolchains = "register_platform_toolchains",
    _resolved_toolchain_impl = "resolved_toolchain_impl",
)

# //lib/private:assets
platform_assets = _platform_asset
multi_platform_assets = _multi_platform_assets
assets = _assets

# //lib/private:toolchains
BinaryToolchainInfo = _BinaryToolchainInfo
binary_toolchain = _binary_toolchain
register_platform_toolchains = _register_platform_toolchains
resolved_toolchain_impl = _resolved_toolchain_impl
