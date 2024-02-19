# buildifier: disable=module-docstring
load("@bzlparty_tools//rules:github.bzl", "github_archive", "github_binary")
load("@bzlparty_tools//rules:http.bzl", "http_binary")

def _impl(_):
    http_binary(
        name = "http_binary_file",
        url = "https://github.com/bzlparty/rules_html/releases/download/v0.1.0/bundler-linux-amd64",
        integrity = "sha384-Qs8NlecZXhKCspFgUbUFngP2Fp2XfpuqRkyC/oA4RskSyneO2GctN83BVxYKHPAt",
    )

    http_binary(
        name = "http_binary_output",
        output = "linux",
        url = "https://github.com/bzlparty/rules_html/releases/download/v0.1.0/bundler-linux-amd64",
        integrity = "sha384-Qs8NlecZXhKCspFgUbUFngP2Fp2XfpuqRkyC/oA4RskSyneO2GctN83BVxYKHPAt",
    )

    http_binary(
        name = "http_binary_custom",
        output = "linux",
        url = "https://github.com/bzlparty/rules_html/releases/download/v0.1.0/bundler-linux-amd64",
        integrity = "sha384-Qs8NlecZXhKCspFgUbUFngP2Fp2XfpuqRkyC/oA4RskSyneO2GctN83BVxYKHPAt",
        build_file_content = """\
alias(
    name = "bin",
    actual = "@http_binary_custom//linux:bin",
    visibility = ["//visibility:public"],
)
""",
    )

    http_binary(
        name = "http_binary_custom_2",
        output = "linux",
        url = "https://github.com/bzlparty/rules_html/releases/download/v0.1.0/bundler-linux-amd64",
        integrity = "sha384-Qs8NlecZXhKCspFgUbUFngP2Fp2XfpuqRkyC/oA4RskSyneO2GctN83BVxYKHPAt",
        build_file = "//:BUILD.custom.bazel",
    )

    github_binary(
        name = "github_binary_file",
        path = "bzlparty/rules_html",
        version = "v0.1.0",
        asset = "bundler-linux-amd64",
        integrity = "sha384-Qs8NlecZXhKCspFgUbUFngP2Fp2XfpuqRkyC/oA4RskSyneO2GctN83BVxYKHPAt",
    )

    github_archive(
        name = "github_archive",
        path = "bzlparty/rules_html",
        version = "v0.1.0",
        asset = "rules_html-v0.1.0.tar.gz",
        strip_prefix = "rules_html-0.1.0",
        integrity = "sha384-GiKRr6dHGEuGdJMXmskNTvHbZrc0g4a8GVxtinRtC3ME5/PgVU4Hz8RWz87xx1qX",
        build_file_content = """
exports_files(["LICENSE"])
        """,
    )

ext = module_extension(_impl)
