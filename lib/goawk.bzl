"# goawk"

def goawk(name, out, file, **kwargs):
    native.genrule(
        name = name,
        cmd = "./$(GOAWK_BIN) -f $(location %s) $(SRCS) > $(OUTS)" % file,
        outs = [out],
        tools = [file],
        toolchains = ["@bzlparty_tools//toolchains:goawk"],
        **kwargs
    )
