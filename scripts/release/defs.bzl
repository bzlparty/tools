"Release helpers"

load("@bazel_skylib//rules:write_file.bzl", "write_file")

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

_TOOLCHAINS_BUILD_FILE = """\
load("@bazel_skylib//:bzl_library.bzl", "bzl_library")
load(":toolchains.bzl", "bzlparty_toolchains")

package(default_visibility = ["//visibility:public"])

bzlparty_toolchains()

bzl_library(
    name = "external",
    srcs = ["external.bzl"],
)

bzl_library(
    name = "toolchains",
    srcs = ["toolchains.bzl"],
    deps = [
        "//lib:resolved_toolchains",
    ],
)
"""

def _write_build_file(name, prefix, content):
    write_file(
        name = name,
        out = "%s_BUILD.bazel" % prefix,
        content = content,
    )

def root_build_file(name):
    _write_build_file(
        name = name,
        prefix = "root",
        content = [_ROOT_BUILD_FILE],
    )

def toolchains_build_file(name):
    _write_build_file(
        name = name,
        prefix = "toolchains",
        content = [_TOOLCHAINS_BUILD_FILE],
    )
