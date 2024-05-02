# buildifier: disable=module-docstring
load("//lib:toolchains.bzl", "platform_toolchains")
load("//toolchains/goawk:assets.bzl", GOAWK_ASSETS = "ASSETS")
load("//toolchains/ripgrep:assets.bzl", RIPGREP_ASSETS = "ASSETS")
load("//toolchains/typos:assets.bzl", TYPOS_ASSETS = "ASSETS")
load("//toolchains/xsv:assets.bzl", XSV_ASSETS = "ASSETS")

TOOLS = {
    "goawk": GOAWK_ASSETS,
    "ripgrep": RIPGREP_ASSETS,
    "typos": TYPOS_ASSETS,
    "xsv": XSV_ASSETS,
}

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
