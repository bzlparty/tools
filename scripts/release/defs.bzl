"Release helpers"

load("@bazel_skylib//rules:write_file.bzl", "write_file")
load("//lib:workspace.bzl", "create_module_bazel")

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

# buildifier: disable=function-docstring
def dist_files(name = "dist_files"):
    native.genrule(
        name = "create_sha_assets_bzl",
        srcs = ["//cmd/sha:shasums"],
        outs = ["toolchains_sha_assets.bzl"],
        cmd = "./$(location :create_assets) $(SRCS) > $(OUTS)",
        tags = ["manual"],
        tools = [":create_assets"],
    )

    native.genrule(
        name = "create_templ_assets_bzl",
        srcs = ["//cmd/templ:shasums"],
        outs = ["toolchains_templ_assets.bzl"],
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
        content = [_ROOT_BUILD_FILE],
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
