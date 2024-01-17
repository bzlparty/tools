"github utils"

load(":utils.bzl", "is_extractable_archive")

_HOST = "https://github.com"

def _github_release_url(path, version, artifact):
    return "{host}/{path}/releases/download/{version}/{artifact}".format(
        host = _HOST,
        path = path,
        version = version,
        artifact = artifact,
    )

def _download_from_release(ctx, **kwargs):
    if is_extractable_archive(kwargs.get("url")):
        ctx.download_and_extract(**kwargs)
        return

    ctx.download(**kwargs)

def _github_url_config(orga, project):
    path = "{}/{}".format(orga, project)

    return struct(
        release = lambda v, a: _github_release_url(path, v, a),
    )

def github(ctx, project, orga = "bzlparty"):
    github_url = _github_url_config(orga, project)

    return struct(
        download_binary = lambda v, a, **kwargs: _download_from_release(
            ctx,
            url = github_url.release(v, a),
            output = a,
            executable = True,
            **kwargs
        ),
        download_archive = lambda v, a, **kwargs: _download_from_release(
            ctx,
            url = github_url.release(v, a),
            **kwargs
        ),
    )
