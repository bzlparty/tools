"Extensions"

load(
    "//lib/private/toolchains:repositories.bzl",
    "register_platform_toolchains",
)
load("//vendor/aspect_bazel_lib:extension_utils.bzl", "extension_utils")

def _impl(ctx, tools):
    for name, assets in tools.items():
        extension_utils.toolchain_repos_bfs(
            mctx = ctx,
            get_version_fn = lambda _: "0.0.0",
            get_tag_fn = lambda tags: getattr(tags, name),
            toolchain_name = name,
            toolchain_repos_fn = lambda name, version: register_platform_toolchains(name = name, assets = assets, toolchain_type = "@bzlparty_tools//toolchains:%s_toolchain_type" % name),
        )

def _impl_factory(tools):
    return lambda ctx: _impl(ctx, tools)

tools_ext = struct(
    impl = _impl_factory,
)
