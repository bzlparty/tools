"# Http Utils"

def _basename(path):
    return path.split("/").pop()

_HTTP_BINARY_BUILD_FILE = """\
package(default_visibility = ["//visibility:public"])
"""

_HTTP_BINARY_BUILD_ALIAS = """
alias(
    name = "{}",
    actual = ":bin",
    visibility = ["//visibility:public"],
)
"""

def _http_binary_impl(ctx):
    output = ctx.attr.output or _basename(ctx.attr.url)
    ctx.download(
        ctx.attr.url,
        "{}/bin".format(output),
        sha256 = ctx.attr.sha256,
        integrity = ctx.attr.integrity,
        executable = True,
    )
    root_build_file = ctx.attr.build_file_content or _HTTP_BINARY_BUILD_FILE
    bin_build_file = _HTTP_BINARY_BUILD_FILE
    if output != "bin":
        bin_build_file += _HTTP_BINARY_BUILD_ALIAS.format(output)
    if ctx.attr.build_file:
        root_build_file = ctx.read(ctx.attr.build_file)
    ctx.file("BUILD", root_build_file)
    ctx.file("{}/BUILD".format(output), bin_build_file)

http_binary = repository_rule(
    _http_binary_impl,
    doc = """
This rule works like [`http_file`](https://bazel.build/rules/lib/repo/http#http_file), but for binaries.

```starlark
http_binary(
    name = "mylang",
    url = "https://mylang.org/download/mylang-linux",
    sha256 =  "f34999afc0dc3fdccba42b4adbdb9767ce32093c24be93c6dfcbb5edbb364787",
)
```

Use the binary target as `@mylang//mylang-linux`.
  """,
    attrs = {
        "output": attr.string(
            mandatory = False,
            doc = """Name of the output target
By default, the rule tries to guess the name of the file by stripping the
`basename` from the URL.

```starlark
http_binary(
    name = "mylang",
    output = "linux-bin",
    url = "https://mylang.org/download/mylang-linux",
    sha256 =  "f34999afc0dc3fdccba42b4adbdb9767ce32093c24be93c6dfcbb5edbb364787",
)
```

Use target: `@mylang//linux-bin`
      """,
        ),
        "sha256": attr.string(
            mandatory = False,
            doc = "SHA 256 hash",
        ),
        "integrity": attr.string(
            mandatory = False,
            doc = "Integrity",
        ),
        "url": attr.string(
            mandatory = True,
            doc = "Url to fetch binary from",
        ),
        "build_file": attr.label(
            mandatory = False,
            doc = "Label to `BUILD` file",
        ),
        "build_file_content": attr.string(
            mandatory = False,
            doc = "Content of `BUILD` file",
        ),
    },
)
