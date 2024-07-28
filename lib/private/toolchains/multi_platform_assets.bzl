"multi platform assets"

load("//lib/private:helpers.bzl", "is_windows")
load("//lib/private/utils:sha.bzl", "sha")
load(":assets_bundle.bzl", "assets_bundle")
load(":platform_asset.bzl", "platform_asset")

def _os(platform):
    return platform.split("_")[0]

def _switch(val, arms, default = None):
    for k, v in arms.items():
        if k == val:
            return v
    return default

# buildifier: disable=function-docstring
def multi_platform_assets(
        name,
        url,
        platforms,
        assets_file = "assets.bzl",
        darwin_ext = "tar.gz",
        windows_ext = "zip",
        set_windows_binary_ext = True,
        linux_ext = "tar.gz",
        binary = None,
        prefix = "",
        files = [],
        platforms_map = {}):
    assets = []
    for platform in platforms:
        _name = "%s_%s" % (name, platform)
        _platform = platforms_map.get(platform, platform)
        ext = _switch(_os(platform), {
            "darwin": darwin_ext,
            "linux": linux_ext,
            "windows": windows_ext,
        }, "tar.gz")
        sha(
            name = "%s_sha" % _name,
            url = url.format(
                platform = _platform,
                ext = ext,
            ),
        )
        platform_asset(
            name = _name,
            platform = platform,
            files = files,
            integrity = ":%s_sha" % _name,
            binary = prefix.format(platform = _platform) +
                     (binary or name) +
                     (".exe" if set_windows_binary_ext and is_windows(platform) else ""),
            url = url.format(
                platform = _platform,
                ext = ext,
            ),
        )
        assets.append(_name)

    assets_bundle(
        name = "%s_assets" % name,
        out_file = assets_file,
        srcs = assets,
    )
