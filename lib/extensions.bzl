# buildifier: disable=module-docstring
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
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

def load_files(**kwargs):
    build_file = """\
filegroup(
    name = "files",
    srcs = glob({files}),
    visibility = ["//visibility:public"],
)
""".format(files = kwargs.pop("files"))
    http_archive(
        build_file_content = build_file,
        **kwargs
    )

def _files_impl(ctx):
    for module in ctx.modules:
        if _has_tag(module, "topiary_queries"):
            load_files(
                name = "topiary_queries",
                url = "https://github.com/tweag/topiary/archive/refs/tags/v0.4.0.tar.gz",
                integrity = "sha384-nwKyTRwfVVWvIybcmGf+/jxGFETvr71qAqbANbT24h3jt+7VEBuT45Fe9gmwGyI7",
                strip_prefix = "topiary-0.4.0",
                files = ["topiary-queries/queries/*.scm"],
            )

files = module_extension(
    _files_impl,
    tag_classes = {
        "topiary_queries": tag_class(),
    },
)

tools = module_extension(
    _impl,
    tag_classes = TAG_CLASSES,
)
