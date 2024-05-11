# buildifier: disable=module-docstring
load("@aspect_bazel_lib//lib:lists.bzl", "map")

def _jql_test_impl(ctx):
    jql = ctx.toolchains["@bzlparty_tools//toolchains:jql_toolchain_type"].binary_info.binary
    test_launcher = ctx.actions.declare_file("%s_test.sh" % ctx.attr.name)
    ctx.actions.write(
        output = test_launcher,
        content = """\
#!/usr/bin/env bash

for file in {files}; do
  {binary} --validate < $file;
done;
""".format(
            binary = jql.path,
            files = " ".join(map(lambda file: file.path, ctx.files.srcs)),
            is_executable = True,
        ),
    )

    return [
        DefaultInfo(
            files = depset([test_launcher]),
            runfiles = ctx.runfiles(files = ctx.files.srcs + [jql]),
            executable = test_launcher,
        ),
    ]

jql_test = rule(
    _jql_test_impl,
    attrs = {
        "srcs": attr.label_list(allow_files = True, mandatory = True),
    },
    toolchains = ["@bzlparty_tools//toolchains:jql_toolchain_type"],
    test = True,
)
