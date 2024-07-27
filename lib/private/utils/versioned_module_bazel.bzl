"Create a `MODULE.bazel` for release"

load("//lib/private:helpers.bzl", "ReleaseInfo", "declare_launcher_file")

def _versioned_module_bazel_impl(ctx):
    launcher = declare_launcher_file(ctx)
    version = ctx.attr.version[ReleaseInfo].value
    if version.startswith("v"):
        version = version[1:]
    ctx.actions.expand_template(
        output = launcher,
        template = ctx.file._launcher_template,
        substitutions = {
            "%SRC%": ctx.file.module_file.path,
            "%OUT%": ctx.outputs.out.path,
            "%VERSION%": version,
        },
        is_executable = True,
    )

    ctx.actions.run(
        inputs = [ctx.file.module_file],
        outputs = [ctx.outputs.out],
        executable = launcher,
        use_default_shell_env = True,
    )

_ATTRS = {
    "out": attr.output(mandatory = True),
    "module_file": attr.label(
        mandatory = True,
        allow_single_file = True,
    ),
    "version": attr.label(),
    "_launcher_template": attr.label(
        default = "@bzlparty_tools//lib/private/utils:versioned_module_bazel.sh",
        allow_single_file = True,
    ),
}

_versioned_module_bazel = rule(
    _versioned_module_bazel_impl,
    attrs = _ATTRS,
)

def versioned_module_bazel(name, **kwargs):
    _versioned_module_bazel(
        name = name,
        module_file = "//:MODULE.bazel",
        **kwargs
    )
