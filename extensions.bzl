"bzlparty tools extensions"

load("//lib:extensions.bzl", "files_ext", "tools_ext")

files = module_extension(
    files_ext.impl,
    tag_classes = files_ext.tag_classes,
)

tools = module_extension(
    tools_ext.impl,
    tag_classes = tools_ext.tag_classes,
)
