"Release helpers"

load("@bazel_skylib//rules:write_file.bzl", "write_file")
load("//lib:create_module_bazel.bzl", "create_module_bazel")
load("//toolchains:toolchains.bzl", "TOOLS")

_ROOT_BUILD_FILE = """\
load("@rules_license//rules:license.bzl", "license")

package(
    default_applicable_licenses = [":license"],
    default_visibility = ["//visibility:public"],
)

license(
    name = "license",
    license_kinds = [
        "@rules_license//licenses/spdx:LGPL-3.0-or-later",
    ],
    license_text = "LICENSE",
)

exports_files([
    "LICENSE",
    "MODULE.bazel",
    "extensions.bzl",
])
"""

_TOOLCHAIN_ALIAS = """\
alias(
  name = "{name}",
  actual = "@bzlparty_tools//toolchains:{name}",
)

alias(
  name = "{name}_toolchain_type",
  actual = "@bzlparty_tools//toolchains:{name}_toolchain_type",
)
"""

def dist_files(name = "dist_files"):
    native.genrule(
        name = "create_assets_bzl",
        srcs = ["//cmd/sha:shasums"],
        outs = ["toolchains_sha_assets.bzl"],
        cmd = "./$(location :create_assets) $(SRCS) > $(OUTS)",
        tags = ["manual"],
        tools = [":create_assets"],
    )

    create_module_bazel(
        name = "root_module_bazel",
        out = "root_MODULE.bazel",
        tags = ["manual"],
    )

    write_file(
        name = "root_build_bazel",
        out = "root_BUILD.bazel",
        content = [_ROOT_BUILD_FILE] + [
            _TOOLCHAIN_ALIAS.format(name = name)
            for name in TOOLS.keys()
        ],
        tags = ["manual"],
    )

    write_file(
        name = "toolchains_build_bazel",
        out = "toolchains_BUILD.bazel",
        content = [
            """load(":toolchains.bzl", "bzlparty_toolchains")""",
            "bzlparty_toolchains()",
        ],
        tags = ["manual"],
    )
