# buildifier: disable=module-docstring
load(":github.bzl", "github_archive")
load(":platforms.bzl", _PLATFORMS = "PLATFORMS")

ASSETS = {
    "darwin_amd64": ("goawk_v1.25.0_darwin_amd64.tar.gz", "Fg2rpDq5rbE4iDtsFaH6ZKc0UlQB97DT+eSRgSAjqmIPEGa5C3vyCzqNco4Krr9Z"),
    "darwin_arm64": ("goawk_v1.25.0_darwin_arm64.tar.gz", "ZCZANnwH9/CUugRbwUqehBx924D/+U7B3E9+VlilE/qUBj076pRaDF42DdJgSsNP"),
    "linux_amd64": ("goawk_v1.25.0_linux_amd64.tar.gz", "3Sp8kKJd7Ztxr8equTvSY0DYW/g2rsEdvJsxHnmCzPgEYhMKOYMSj+hbyCdsglJo"),
    "linux_arm64": ("goawk_v1.25.0_linux_arm64.tar.gz", "LSH+jvkMlnUOiaRUIo5WVZkXMVZtb3erw5S1r0IjkKc4+OmVbT1ubJDtq8K1H2l6"),
    "windows_amd64": ("goawk_v1.25.0_windows_amd64.zip", "EbPF8B9Lqf41zO3wq7Fa4bHBPx3X4d0W/cGS15bRE9yD3o/b3f5dyhgxgH9wO+Av"),
}

PLATFORMS = {
    p: _PLATFORMS[p]
    for p in ASSETS.keys()
}

def _impl(_):
    for (platform, meta) in ASSETS.items():
        (asset, integrity) = meta
        github_archive(
            name = "goawk_%s" % platform,
            path = "benhoyt/goawk",
            version = "v1.25.0",
            asset = asset,
            integrity = "sha384-%s" % integrity,
            build_file_content = """
load("@bzlparty_tools//:toolchains.bzl", "goawk_toolchain")
goawk_toolchain(
    name = "goawk_toolchain",
    executable = select({
        "@bazel_tools//src/conditions:host_windows": "goawk.exe",
        "//conditions:default": "goawk",
    }),
)
          """,
        )

    goawk_toolchains(
        name = "goawk",
        platforms = ASSETS.keys(),
    )

def _goawk_toolchains_impl(ctx):
    ctx.file("BUILD", """
load("@bzlparty_tools//:extensions.bzl", "PLATFORMS")
[
    toolchain(
        name = "goawk_%s_toolchain" % platform,
        toolchain = "@goawk_%s//:goawk_toolchain" % platform,
        exec_compatible_with = ecw,
        toolchain_type = "@bzlparty_tools//toolchains:goawk_toolchain_type",
        visibility = ["//visibility:public"],
    )
    for (platform, ecw) in PLATFORMS.items()
]
""")

goawk_toolchains = repository_rule(
    _goawk_toolchains_impl,
    attrs = {
        "platforms": attr.string_list(),
    },
)

ext = module_extension(_impl)
