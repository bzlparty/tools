"Assets"

ASSETS = {
    "darwin_amd64": struct(
        url = "https://github.com/cargo-prebuilt/index/releases/download/typos-cli-1.23.6/x86_64-apple-darwin.tar.gz",
        binary = "typos",
        integrity = "sha384-7dR2k+WrgfrzuuJu0504uk0Cwv9xVcGxbZjWMYAT+ls1v2aIVxyiKIKeaWwYyszi",
    ),
    "darwin_arm64": struct(
        url = "https://github.com/cargo-prebuilt/index/releases/download/typos-cli-1.23.6/aarch64-apple-darwin.tar.gz",
        binary = "typos",
        integrity = "sha384-wYIXbHeqzS6krPZ9bTmW96klqYlepofoO84Ys6BLSzINL7vIJVhhkZFa48F48fwH",
    ),
    "linux_amd64": struct(
        url = "https://github.com/cargo-prebuilt/index/releases/download/typos-cli-1.23.6/x86_64-unknown-linux-musl.tar.gz",
        binary = "typos",
        integrity = "sha384-nUFWvQ+myyz5wTU+d8AUU5BuC40cRqSyLcCrMSzTSgepjiXle4w3Hvltiewlb2Tx",
    ),
    "linux_arm64": struct(
        url = "https://github.com/cargo-prebuilt/index/releases/download/typos-cli-1.23.6/aarch64-unknown-linux-musl.tar.gz",
        binary = "typos",
        integrity = "sha384-Liqok0zd0WI4TEKMM+DrlWPnGaXiUxIxHWUfF4N/N9tS2vLxXHANS7cXH32YdwUT",
    ),
    "windows_amd64": struct(
        url = "https://github.com/cargo-prebuilt/index/releases/download/typos-cli-1.23.6/x86_64-pc-windows-msvc.tar.gz",
        binary = "typos.exe",
        integrity = "sha384-FFX21vdwcqxsXc9rHdPgA3dVwFIVhbGexdykRXt2PYNDTDQgotDDHZco14aUFFwq",
    ),
    "windows_arm64": struct(
        url = "https://github.com/cargo-prebuilt/index/releases/download/typos-cli-1.23.6/aarch64-pc-windows-msvc.tar.gz",
        binary = "typos.exe",
        integrity = "sha384-gAC9bM1g43fwCG4geC20FCnAHsVOpybHdyMEK/cQpndbwRX4UISGdTuTnMhNnmXJ",
    ),
}
