"Assets"

ASSETS = {
    "darwin_amd64": struct(
        url = "https://github.com/BurntSushi/ripgrep/releases/download/14.1.0/ripgrep-14.1.0-x86_64-apple-darwin.tar.gz",
        binary = "ripgrep-14.1.0-x86_64-apple-darwin/rg",
        integrity = "sha384-/nwSPTMJbz97PxOy5BD/yl30x5oNQ/MIhBeux9VQMwPlLOzOYcQo0+RdZnKWkEFp",
    ),
    "darwin_arm64": struct(
        url = "https://github.com/BurntSushi/ripgrep/releases/download/14.1.0/ripgrep-14.1.0-aarch64-apple-darwin.tar.gz",
        binary = "ripgrep-14.1.0-aarch64-apple-darwin/rg",
        integrity = "sha384-3Ah7zo307VFV8plovAg8ex4hDy0P04YU5yz7Fwzs6mR5B4gwDeEJb7A6ggVFHyIL",
    ),
    "linux_amd64": struct(
        url = "https://github.com/BurntSushi/ripgrep/releases/download/14.1.0/ripgrep-14.1.0-x86_64-unknown-linux-musl.tar.gz",
        binary = "ripgrep-14.1.0-x86_64-unknown-linux-musl/rg",
        integrity = "sha384-9C2Ethl4TaPzvRR2SDqlSb4bGuBP9NyE9PVUalTLA9fJA1Jd4OTgFKvBgdpGh3vb",
    ),
    "windows_amd64": struct(
        url = "https://github.com/BurntSushi/ripgrep/releases/download/14.1.0/ripgrep-14.1.0-x86_64-pc-windows-gnu.zip",
        binary = "ripgrep-14.1.0-x86_64-pc-windows-gnu/rg.exe",
        integrity = "sha384-gBz6YsKFpFzkZy6hjiEp2XKiJAkxKpaJQSlDKCj8+qkHHuUhQbWbxAxbXSxNjvij",
    ),
}
