"# ripgrep"

load("@bazel_skylib//rules:write_file.bzl", "write_file")

# buildifier: disable=function-docstring
def ripgrep(name, out, file = None, pattern = None, **kwargs):
    args = []
    args.append("--color=never")
    if pattern:
        args.append("-e \"%s\"" % pattern)
    elif file:
        args.append("-f $(location %s)" % file)

    native.genrule(
        name = name,
        cmd = """
./$(RIPGREP_BIN) {args} $(SRCS) > $(OUTS)
""".format(
            args = " ".join(args),
        ),
        outs = [out],
        toolchains = ["@bzlparty_tools//toolchains:ripgrep"],
        **kwargs
    )

def ripgrep_binary(name, **kwargs):
    write_file(
        name = "%s_sh" % name,
        out = "%s.sh" % name,
        content = [
            "#!/usr/bin/env bash",
            "echo $1",
            "env",
        ],
    )
    native.sh_binary(
        name = name,
        srcs = ["%s_sh" % name],
        args = [
            "$(RIPGREP_BIN)",
            "$(rootpaths %s)" % " ".join(kwargs.get("data")),
        ],
        toolchains = ["@bzlparty_tools//toolchains:ripgrep"],
        **kwargs
    )
