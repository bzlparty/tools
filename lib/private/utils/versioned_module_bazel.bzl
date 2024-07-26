"Create a `MODULE.bazel` for release"

load("//lib/private:helpers.bzl", "declare_launcher_file")
load(
    "//toolchains:external.bzl",
    "BUILDIFIER_TOOLCHAIN_TYPE",
    "COREUTILS_TOOLCHAIN_TYPE",
)

def _versioned_module_bazel_impl(ctx):
    coreutils = ctx.toolchains[COREUTILS_TOOLCHAIN_TYPE].coreutils_info.bin
    buildifier = ctx.toolchains[BUILDIFIER_TOOLCHAIN_TYPE]._tool
    launcher = declare_launcher_file(ctx)
    ctx.actions.expand_template(
        output = launcher,
        template = ctx.file._launcher_template,
        substitutions = {
            "%COREUTILS%": coreutils,
            "%BUILDIFIER%": buildifier,
            "%SRC%": ctx.file.module_file.path,
            "%OUT%": ctx.outputs.out.path,
        },
        is_executable = True,
    )

    ctx.actions.run(
        inputs = [ctx.file.module_file],
        outputs = [ctx.outputs.out],
        executable = launcher,
        use_default_shell_env = True,
        tools = [ctx.file._dcomment],
    )

_ATTRS = {
    "out": attr.output(mandatory = True),
    "module_file": attr.label(
        mandatory = True,
        allow_single_file = True,
    ),
    "_launcher_template": attr.label(
        default = "@bzlparty_tools//lib/private/utils:versioned_module_bazel.sh",
        allow_single_file = True,
    ),
}

_versioned_module_bazel = rule(
    _versioned_module_bazel_impl,
    attrs = _ATTRS,
    toolchains = [
        BUILDIFIER_TOOLCHAIN_TYPE,
        COREUTILS_TOOLCHAIN_TYPE,
    ],
)

def versioned_module_bazel(name, **kwargs):
    _versioned_module_bazel(
        name = name,
        module_file = "//:MODULE.bazel",
        **kwargs
    )
