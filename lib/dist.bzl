# buildifier: disable=module-docstring
def dist(name, srcs, package = None):
    if package == None:
        package = native.module_name()

    native.genrule(
        name = name,
        outs = ["%s.tar.gz" % package],
        srcs = srcs,
        cmd = """
tar czf $(OUTS) --transform="s,\\.,{}," --dereference --exclude=bazel-out --exclude=external .
""".format(package),
    )
