"# Toolchain Repositories"

load("@bazel_skylib//lib:types.bzl", "types")
load(
    "//lib/private:platforms.bzl",
    "HOST_CONSTRAINTS",
    "HOST_PLATFORM",
    "PLATFORMS",
)
load(
    ":constants.bzl",
    "EXTENSIONS",
    "TOOLCHAINS_BUILD_FILE_BEGIN",
    "TOOLCHAINS_BUILD_FILE_PARTIAL",
    "TOOLCHAIN_BUILD_FILE",
)

def _binary_toolchain_impl(ctx):
    binary = ctx.file.binary
    files = ctx.files.files
    default_info = DefaultInfo(
        files = depset([binary] + files),
        runfiles = ctx.runfiles(files = [binary] + files),
    )
    binary_info = BinaryToolchainInfo(
        binary = binary,
        files = files,
    )
    env = dict([("%s_BIN" % ctx.attr.prefix.upper(), binary.path)])
    variable_info = platform_common.TemplateVariableInfo(env)
    toolchain_info = platform_common.ToolchainInfo(
        binary_info = binary_info,
        template_variables = variable_info,
        default = default_info,
    )

    return [default_info, toolchain_info]

BinaryToolchainInfo = provider(
    doc = "Binary Toolchain Provider",
    fields = {
        "binary": "Path to binary",
        "files": "Paths to library files",
    },
)

binary_toolchain = rule(
    _binary_toolchain_impl,
    attrs = {
        "binary": attr.label(mandatory = True, allow_single_file = True),
        "prefix": attr.string(mandatory = True),
        "files": attr.label_list(allow_files = True, default = []),
    },
)

def _is_archive(url):
    for e in EXTENSIONS:
        if url.endswith(e):
            return True
    return False

def _create_repository_from_remote(ctx):
    if _is_archive(ctx.attr.url):
        ctx.download_and_extract(
            url = ctx.attr.url,
            integrity = ctx.attr.integrity,
        )
    else:
        ctx.download(
            url = ctx.attr.url,
            output = ctx.attr.binary,
            integrity = ctx.attr.integrity,
            executable = True,
        )

def _platform_toolchain_impl(ctx):
    if ctx.attr.url != "":
        _create_repository_from_remote(ctx)

    ctx.file("BUILD.bazel", TOOLCHAIN_BUILD_FILE.format(
        binary = ctx.attr.binary if ctx.attr.binary.startswith("@") else ":%s" % ctx.attr.binary,
        prefix = ctx.attr.prefix,
        files = "glob([\"" + "\", \"".join(ctx.attr.files) + "\"])" if len(ctx.attr.files) > 0 else "[]",
    ))

platform_toolchain = repository_rule(
    _platform_toolchain_impl,
    attrs = {
        "url": attr.string(default = ""),
        "binary": attr.string(),
        "prefix": attr.string(),
        "integrity": attr.string(),
        "files": attr.string_list(),
    },
)

# buildifier: disable=function-docstring
def register_platform_toolchains(name, assets, toolchain_type):
    toolchains_build_file = TOOLCHAINS_BUILD_FILE_BEGIN.format(name = name)
    if types.is_dict(assets):
        for (platform, config) in assets.items():
            _platform = HOST_PLATFORM if platform == "host" else platform
            _name = "%s_%s" % (name, _platform)
            platform_toolchain(
                name = _name,
                prefix = name,
                url = config.url,
                integrity = config.integrity,
                binary = config.binary,
                files = config.files if hasattr(config, "files") else [],
            )
            toolchains_build_file += TOOLCHAINS_BUILD_FILE_PARTIAL.format(
                name = name,
                platform = _platform,
                toolchain_type = toolchain_type,
                compatible_with = HOST_CONSTRAINTS if platform == "host" else PLATFORMS[platform],
            )
    elif types.is_string(assets):
        _name = "%s_%s" % (name, HOST_PLATFORM)
        platform_toolchain(
            name = _name,
            prefix = name,
            binary = assets,
        )
        toolchains_build_file += TOOLCHAINS_BUILD_FILE_PARTIAL.format(
            name = name,
            platform = HOST_PLATFORM,
            toolchain_type = toolchain_type,
            compatible_with = HOST_CONSTRAINTS,
        )
    else:
        fail("Cannot process assets: {}".format(assets))

    platform_toolchains(name = name, build_file = toolchains_build_file)

platform_toolchains = repository_rule(
    implementation = lambda ctx: ctx.file("BUILD.bazel", ctx.attr.build_file),
    attrs = {
        "build_file": attr.string(mandatory = True),
    },
)
