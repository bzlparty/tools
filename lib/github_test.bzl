"gitub test suite"

load("@bazel_skylib//lib:unittest.bzl", "asserts", "unittest")
load(":github.bzl", "github")

def _download_assertions(env, **kwargs):
    asserts.true(env, kwargs.get("executable"))
    asserts.equals(env, kwargs.get("output"), "foo.tar.gz")
    asserts.equals(env, kwargs.get("url"), "https://github.com/bzlparty/foo/releases/download/v0.0.0/foo.tar.gz")

def _download_binary_test_impl(ctx):
    env = unittest.begin(ctx)

    fake_ctx = struct(
        download = lambda **kwargs: _download_assertions(env, **kwargs),
        download_and_extract = lambda: unittest.fail(env, "This function must not be called"),
    )

    gh = github(fake_ctx, "foo")
    gh.download_binary("0.0.0", "foo.tar.gz")

    return unittest.end(env)

download_binary_test = unittest.make(_download_binary_test_impl)

def _download_and_extract_assertions(env, **kwargs):
    asserts.equals(env, kwargs.get("executable"), None)
    asserts.equals(env, kwargs.get("url"), "https://github.com/bzlparty/foo/releases/download/v0.0.0/foo.tar.gz")
    asserts.equals(env, kwargs.get("output"), "foo_out")

def _download_archive_test_impl(ctx):
    env = unittest.begin(ctx)

    fake_ctx = struct(
        download = lambda: unittest.fail(env, "This function must not be called"),
        download_and_extract = lambda **kwargs: _download_and_extract_assertions(env, **kwargs),
    )

    gh = github(fake_ctx, "foo")
    gh.download_archive("0.0.0", "foo.tar.gz", output = "foo_out")

    return unittest.end(env)

download_archive_test = unittest.make(_download_archive_test_impl)

def github_test_suite(name):
    unittest.suite(
        name,
        download_binary_test,
        download_archive_test,
    )
