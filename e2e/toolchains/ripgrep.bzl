"ripgrep"

def ripgrep(name, out, pattern, **kwargs):
    args = []
    args.append("--color=never")
    args.append("-e \"%s\"" % pattern)

    native.genrule(
        name = name,
        cmd = "./$(RIPGREP_BIN) {args} $(SRCS) > $(OUTS)".format(
            args = " ".join(args),
        ),
        outs = [out],
        toolchains = ["@bzlparty_tools//toolchains:ripgrep"],
        **kwargs
    )
