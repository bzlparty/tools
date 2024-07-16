"bzlparty tools extensions"

load("//lib:extensions.bzl", "tools_ext")

tools = module_extension(
    tools_ext.impl,
    tag_classes = tools_ext.tag_classes,
)
