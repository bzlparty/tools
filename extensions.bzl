"bzlparty tools extensions"

load("//lib:extensions.bzl", "tools_ext")
load("//toolchains:tools.bzl", "TOOLS")

TAG_CLASSES = {
    t: tag_class(attrs = {"name": attr.string(default = t)})
    for t in TOOLS.keys()
}

tools = module_extension(
    tools_ext.impl(TOOLS),
    tag_classes = TAG_CLASSES,
)
