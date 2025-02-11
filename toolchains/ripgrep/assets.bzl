"Assets"

ASSETS = {
    "darwin_amd64": struct(
        url = "https://github.com/BurntSushi/ripgrep/releases/download/14.1.1/ripgrep-14.1.1-x86_64-apple-darwin.tar.gz",
        binary = "ripgrep-14.1.1-x86_64-apple-darwin/rg",
        integrity = "sha384-7iYT5NrGGisCEm4E4rsxp1FXmoWNEVz7pvLdlHo9TfKI00WbIZvxBWrqldH3Vyfu",
    ),
    "darwin_arm64": struct(
        url = "https://github.com/BurntSushi/ripgrep/releases/download/14.1.1/ripgrep-14.1.1-aarch64-apple-darwin.tar.gz",
        binary = "ripgrep-14.1.1-aarch64-apple-darwin/rg",
        integrity = "sha384-2CEUR2QYg3SrHOXQCXXRL+0/hGa1OBuYPLlE1fAhXF0J5KiEfQGYzjVPafygXbm/",
    ),
    "linux_amd64": struct(
        url = "https://github.com/BurntSushi/ripgrep/releases/download/14.1.1/ripgrep-14.1.1-x86_64-unknown-linux-musl.tar.gz",
        binary = "ripgrep-14.1.1-x86_64-unknown-linux-musl/rg",
        integrity = "sha384-vsQwC2OFroDE+l6lJhXC/qs/jvogOVFfRcz4/xQ0mZwfmLNgX9UV9qjDlZpd9A3V",
    ),
    "windows_amd64": struct(
        url = "https://github.com/BurntSushi/ripgrep/releases/download/14.1.1/ripgrep-14.1.1-x86_64-pc-windows-gnu.zip",
        binary = "ripgrep-14.1.1-x86_64-pc-windows-gnu/rg.exe",
        integrity = "sha384-xqV9r8xc7MUdxkay3Kf4W9E5Nu/ajMF0Y7z8x7FP2vVVLdGb0ZdLEfzzcGh9YNoA",
    ),
}
