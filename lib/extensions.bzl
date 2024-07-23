# buildifier: disable=module-docstring
load(
    "//lib/private/toolchains:repositories.bzl",
    "register_platform_toolchains",
)
load("//toolchains:tools.bzl", "TOOLS")

TAG_CLASSES = {
    t: tag_class(attrs = {"name": attr.string(default = t)})
    for t in TOOLS.keys()
}

def _has_tag(module, tag):
    return hasattr(module.tags, tag) and len(getattr(module.tags, tag)) > 0

def _impl(ctx):
    for module in ctx.modules:
        for name, assets in TOOLS.items():
            if _has_tag(module, name):
                toolchain_type = "@bzlparty_tools//toolchains:%s_toolchain_type" % name
                register_platform_toolchains(
                    name = name,
                    assets = assets,
                    toolchain_type = toolchain_type,
                )

tools_ext = struct(
    impl = _impl,
    tag_classes = TAG_CLASSES,
)
