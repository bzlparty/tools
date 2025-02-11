"Assets"

ASSETS = {
    "darwin_amd64": struct(
        url = "https://github.com/cargo-prebuilt/index/releases/download/typos-cli-1.29.5/x86_64-apple-darwin.tar.gz",
        binary = "typos",
        integrity = "sha384-/kk579JYiYaykVY/UCfl/n7n7H8rGiu2Ox2uqb302/aPV5a/GoZydzq2mqg8CpFn",
    ),
    "darwin_arm64": struct(
        url = "https://github.com/cargo-prebuilt/index/releases/download/typos-cli-1.29.5/aarch64-apple-darwin.tar.gz",
        binary = "typos",
        integrity = "sha384-L72AWnndof+vMTrzDVT2fUELlIa6ukqYJ3rvj2Xl9V/nKZ8fwllJZ/kyDcEDVxH1",
    ),
    "linux_amd64": struct(
        url = "https://github.com/cargo-prebuilt/index/releases/download/typos-cli-1.29.5/x86_64-unknown-linux-musl.tar.gz",
        binary = "typos",
        integrity = "sha384-5v6KsK7xqxicGpIeYFRshMW4q2/s8Ih1Bm3Oim8N3kgzayjVnCwYOZgOfhcHkzXV",
    ),
    "linux_arm64": struct(
        url = "https://github.com/cargo-prebuilt/index/releases/download/typos-cli-1.29.5/aarch64-unknown-linux-musl.tar.gz",
        binary = "typos",
        integrity = "sha384-Mta30Tt4LpDJYJ0Bz+FGrKsn/1tFRNEP28SJsZPzSThnRVWraEBOjNnQvarhwqZm",
    ),
    "windows_amd64": struct(
        url = "https://github.com/cargo-prebuilt/index/releases/download/typos-cli-1.29.5/x86_64-pc-windows-msvc.tar.gz",
        binary = "typos.exe",
        integrity = "sha384-DzNbs/4PBLT9BiPzp3/dD12x0weaDPW/0oJeVTjaF8PCB2Y1tpxEDwCeDGIf6kdd",
    ),
    "windows_arm64": struct(
        url = "https://github.com/cargo-prebuilt/index/releases/download/typos-cli-1.29.5/aarch64-pc-windows-msvc.tar.gz",
        binary = "typos.exe",
        integrity = "sha384-cLaV8P0932EZNCQE4KwWUVzhEtMtE45IhvFighrVMaAhvvRuk11DOydNdV/cSaNu",
    ),
}
