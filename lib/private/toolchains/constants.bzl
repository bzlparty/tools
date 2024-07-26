"Constants"

EXTENSIONS = [
    "zip",
    "jar",
    "war",
    "aar",
    "tar",
    "tar.gz",
    "tgz",
    "tar.xz",
    "txz",
    ".tar.zst",
    ".tzst",
    "tar.bz2",
    ".tbz",
    ".ar",
    ".deb",
]

TOOLCHAIN_BUILD_FILE = """\
load("@bzlparty_tools//lib:defs.bzl", "binary_toolchain")
binary_toolchain(
    name = "{prefix}_binary_toolchain",
    prefix = "{prefix}",
    binary = "{binary}",
    files = {files},
)

alias(
  name = "bin",
  actual = "{binary}",
  visibility = ["//visibility:public"],
)
"""

TOOLCHAINS_BUILD_FILE_BEGIN = """\
load("@bzlparty_tools//lib:defs.bzl", "HOST_PLATFORM")

alias(
    name = "{name}",
    actual = "@{name}_%s//:bin" % HOST_PLATFORM,
    visibility = ["//visibility:public"],
)
"""

TOOLCHAINS_BUILD_FILE_PARTIAL = """\
toolchain(
    name = "{name}_{platform}_toolchain",
    toolchain = "@{name}_{platform}//:{name}_binary_toolchain",
    exec_compatible_with = {compatible_with},
    toolchain_type = "{toolchain_type}",
    visibility = ["//visibility:public"],
)
"""
