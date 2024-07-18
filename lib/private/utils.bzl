"Utils for rules"

def declare_launcher_file(ctx):
    return ctx.actions.declare_file("{}_/{}".format(ctx.label.name, ctx.label.name))

def get_binary_from_toolchain(ctx, toolchain):
    if toolchain not in ctx.toolchains:
        fail("%s is not included in toolchains")
    return ctx.toolchains[toolchain].binary_info.binary

def write_executable_launcher_file(ctx, content):
    launcher = declare_launcher_file(ctx)
    ctx.actions.write(
        output = launcher,
        content = content,
        is_executable = True,
    )
    return launcher

def platform_from_constraints(constraints):
    """Get platform from constraints

    Args:
      constraints: list of platform constraints, e.g. `["@platforms//os:linux", "@platforms//cpu:x86_64"]`.

    Returns:
      platform string, e.g. `linux_amd64`.
    """

    os = ""
    arch = ""

    if "@platforms//os:freebsd" in constraints:
        os = "freebsd"
    elif "@platforms//os:linux" in constraints:
        os = "linux"
    elif "@platforms//os:netbsd" in constraints:
        os = "netbsd"
    elif "@platforms//os:osx" in constraints or "@platforms//os:macos" in constraints:
        os = "darwin"
    elif "@platforms//os:windows" in constraints:
        os = "windows"
    else:
        fail("OS unknown")

    if "@platforms//cpu:x86_64" in constraints or "@platforms//os:amd64" in constraints:
        arch = "amd64"
    elif "@platforms//cpu:aarch64" in constraints:
        arch = "arm64"
    else:
        fail("ARCH unknown")

    return "%s_%s" % (os, arch)
