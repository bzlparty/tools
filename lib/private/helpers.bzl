"Utils for rules"

ReleaseInfo = provider(doc = "", fields = ["value"])

def declare_launcher_file(ctx):
    return ctx.actions.declare_file("{}_/{}".format(ctx.label.name, ctx.label.name))

def get_target_file(target):
    if DefaultInfo in target:
        return target[DefaultInfo].files.to_list().pop()
    fail("Cannot get file path")

def _get_binary_info_from_toolchain(ctx, toolchain):
    if toolchain in ctx.toolchains and hasattr(ctx.toolchains[toolchain], "binary_info"):
        return ctx.toolchains[toolchain].binary_info
    fail("%s is not included in toolchains" % toolchain)

def get_binary_from_toolchain(ctx, toolchain):
    return _get_binary_info_from_toolchain(ctx, toolchain).binary

def get_files_from_toolchain(ctx, toolchain):
    return _get_binary_info_from_toolchain(ctx, toolchain).files

def is_windows(platform):
    return platform.startswith("windows")

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

def _release_arg_impl(ctx):
    return ReleaseInfo(value = ctx.build_setting_value)

release_arg = rule(
    _release_arg_impl,
    build_setting = config.string(flag = True),
)
