"# ripgrep"

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
