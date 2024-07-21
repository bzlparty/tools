"Create a `MODULE.bazel` for release"

load(":utils.bzl", "declare_launcher_file")

def _create_module_bazel_impl(ctx):
    launcher = declare_launcher_file(ctx)
    ctx.actions.expand_template(
        output = launcher,
        template = ctx.file._launcher_template,
        substitutions = {
            "%DCOMMENT_BIN%": ctx.file._dcomment.path,
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

create_module_bazel = rule(
    _create_module_bazel_impl,
    attrs = {
        "out": attr.output(mandatory = True),
        "module_file": attr.label(
            default = Label("//:MODULE.bazel"),
            allow_single_file = True,
        ),
        "_launcher_template": attr.label(
            default = "@bzlparty_tools//lib/private:create_module_bazel.sh",
            allow_single_file = True,
        ),
        "_dcomment": attr.label(
            default = "@bzlparty_tools//vendor/dcomment",
            allow_single_file = True,
        ),
    },
)
