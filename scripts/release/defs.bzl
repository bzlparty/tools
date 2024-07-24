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

def root_build_file(name):
    write_file(
        name = "%s_bazel" % name.lower(),
        out = "%s.bazel" % name,
        content = [_ROOT_BUILD_FILE],
        tags = ["manual"],
    )

def toolchains_build_file(name):
    write_file(
        name = "%s_bazel" % name.lower(),
        out = "%s.bazel" % name,
        content = [
            """load(":toolchains.bzl", "bzlparty_toolchains")""",
            "bzlparty_toolchains()",
        ],
        tags = ["manual"],
    )
