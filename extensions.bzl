"bzlparty tools extensions"

load("//lib:extensions.bzl", "tools_ext")
load("//toolchains:tools_assets.bzl", "TOOLS_ASSETS")

TAG_CLASSES = {
    t: tag_class(attrs = {"name": attr.string(default = t)})
    for t in TOOLS_ASSETS.keys()
}

tools = module_extension(
    tools_ext.impl(TOOLS_ASSETS),
    tag_classes = TAG_CLASSES,
)
