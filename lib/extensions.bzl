# buildifier: disable=module-docstring
load("//lib:toolchains.bzl", "platform_toolchains")
load("//toolchains/goawk:assets.bzl", GOAWK_ASSETS = "ASSETS")
load("//toolchains/ripgrep:assets.bzl", RIPGREP_ASSETS = "ASSETS")

def _impl(ctx):
    for module in ctx.modules:
        if len(module.tags.goawk) > 0:
            platform_toolchains(name = "goawk", assets = GOAWK_ASSETS)
        if len(module.tags.ripgrep) > 0:
            platform_toolchains(name = "ripgrep", assets = RIPGREP_ASSETS)

ext = module_extension(
    _impl,
    tag_classes = {
        "goawk": tag_class(
            attrs = {
                "name": attr.string(default = "goawk"),
            },
        ),
        "ripgrep": tag_class(
            attrs = {
                "name": attr.string(default = "ripgrep"),
            },
        ),
    },
)
