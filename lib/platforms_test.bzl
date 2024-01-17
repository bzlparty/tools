"Platforms Tests"

load("@bazel_skylib//lib:unittest.bzl", "asserts", "unittest")
load(":platforms.bzl", "PLATFORMS", "host_platform")

def _host_platform_test_impl(ctx):
    env = unittest.begin(ctx)

    asserts.true(env, host_platform in PLATFORMS.keys())

    return unittest.end(env)

host_platform_test = unittest.make(_host_platform_test_impl)

def platforms_test_suite(name):
    unittest.suite(
        name,
        host_platform_test,
    )
