"Tools"

load("//toolchains/biome:assets.bzl", BIOME_ASSETS = "ASSETS")
load("//toolchains/fd:assets.bzl", FD_ASSETS = "ASSETS")
load("//toolchains/goawk:assets.bzl", GOAWK_ASSETS = "ASSETS")
load("//toolchains/json_bash:assets.bzl", JSON_BASH_ASSETS = "ASSETS")
load("//toolchains/ripgrep:assets.bzl", RIPGREP_ASSETS = "ASSETS")
load("//toolchains/sha:assets.bzl", SHA_ASSETS = "ASSETS")
load("//toolchains/shellcheck:assets.bzl", SHELLCHECK_ASSETS = "ASSETS")
load("//toolchains/shellspec:assets.bzl", SHELLSPEC_ASSETS = "ASSETS")
load("//toolchains/templ:assets.bzl", TEMPL_ASSETS = "ASSETS")
load("//toolchains/typos:assets.bzl", TYPOS_ASSETS = "ASSETS")

TOOLS = {
    "biome": BIOME_ASSETS,
    "fd": FD_ASSETS,
    "goawk": GOAWK_ASSETS,
    "json_bash": JSON_BASH_ASSETS,
    "ripgrep": RIPGREP_ASSETS,
    "sha": SHA_ASSETS,
    "shellcheck": SHELLCHECK_ASSETS,
    "shellspec": SHELLSPEC_ASSETS,
    "templ": TEMPL_ASSETS,
    "typos": TYPOS_ASSETS,
}
