# buildifier: disable=module-docstring
load("//lib:toolchains.bzl", "platform_toolchains")
load("//toolchains:toolchains.bzl", "TOOLS")

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
                platform_toolchains(name = name, assets = assets)

tools = module_extension(
    _impl,
    tag_classes = TAG_CLASSES,
)
