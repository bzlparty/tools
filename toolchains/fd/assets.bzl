"Assets"

ASSETS = {
    "darwin_amd64": struct(
        url = "https://github.com/sharkdp/fd/releases/download/v10.2.0/fd-v10.2.0-x86_64-apple-darwin.tar.gz",
        binary = "fd-v10.2.0-x86_64-apple-darwin/fd",
        integrity = "sha384-s/7+5oRL4hQVGReZHPG+BO6KlmRWliY/bgs8qZBbAtgnWajqElHqXCjje5vXyPZi",
    ),
    "darwin_arm64": struct(
        url = "https://github.com/sharkdp/fd/releases/download/v10.2.0/fd-v10.2.0-aarch64-apple-darwin.tar.gz",
        binary = "fd-v10.2.0-aarch64-apple-darwin/fd",
        integrity = "sha384-BLcE6wIFIkYJ1QhHolPA4nSOB27A6vbjQm0VRrSQfdeZTBmtKqlWkv7qc5H3HNTm",
    ),
    "linux_amd64": struct(
        url = "https://github.com/sharkdp/fd/releases/download/v10.2.0/fd-v10.2.0-x86_64-unknown-linux-musl.tar.gz",
        binary = "fd-v10.2.0-x86_64-unknown-linux-musl/fd",
        integrity = "sha384-aKl2cXU55Ue5R0gFdzqT0HTEDfw0+7lBGILgR1HAi9CkDSsAjOFsH5NYZfU1L/6H",
    ),
    "linux_arm64": struct(
        url = "https://github.com/sharkdp/fd/releases/download/v10.2.0/fd-v10.2.0-aarch64-unknown-linux-musl.tar.gz",
        binary = "fd-v10.2.0-aarch64-unknown-linux-musl/fd",
        integrity = "sha384-srvSu/1G6VtCWJ95FSwcM5LoY6q1SBmW+HuGB24cQ0udLZGtRc+jo9tpk/3c/A+b",
    ),
    "windows_amd64": struct(
        url = "https://github.com/sharkdp/fd/releases/download/v10.2.0/fd-v10.2.0-x86_64-pc-windows-msvc.zip",
        binary = "fd-v10.2.0-x86_64-pc-windows-msvc/fd.exe",
        integrity = "sha384-CQZAh7+Bmjne0Qv9T2DiGvNvhsQD4vXHQooHuzQ/Vo6nkKxtyBrfD3mC94Jyyf9w",
    ),
}
