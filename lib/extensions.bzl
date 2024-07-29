# buildifier: disable=module-docstring
load(
    "//lib/private/toolchains:repositories.bzl",
    "register_platform_toolchains",
)
load("//toolchains:tools.bzl", "TOOLS")
load("//vendor/aspect_bazel_lib:extension_utils.bzl", "extension_utils")

TAG_CLASSES = {
    t: tag_class(attrs = {"name": attr.string(default = t)})
    for t in TOOLS.keys()
}

def _impl(ctx):
    for name, assets in TOOLS.items():
        extension_utils.toolchain_repos_bfs(
            mctx = ctx,
            get_version_fn = lambda _: "0.0.0",
            get_tag_fn = lambda tags: getattr(tags, name),
            toolchain_name = name,
            toolchain_repos_fn = lambda name, version: register_platform_toolchains(name = name, assets = assets, toolchain_type = "@bzlparty_tools//toolchains:%s_toolchain_type" % name),
        )

tools_ext = struct(
    impl = _impl,
    tag_classes = TAG_CLASSES,
)
