"cmd assets"

load("//lib/private:helpers.bzl", "is_windows")
load(":assets_bundle.bzl", "assets_bundle")
load(":platform_asset.bzl", "platform_asset")

# buildifier: disable=function-docstring
def cmd_assets(name, binary, integrity_map, **kwargs):
    assets = []
    for target, platform in integrity_map.items():
        _name = "%s_%s" % (name, platform)
        _ext = ".exe" if is_windows(platform) else ""
        platform_asset(
            name = _name,
            binary = "{}_{}{}".format(binary, platform, _ext),
            platform = platform,
            integrity = target,
            **kwargs
        )
        assets.append(_name)

    assets_bundle(
        name = name,
        srcs = assets,
        write_file = False,
    )
