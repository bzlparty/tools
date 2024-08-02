package main

var ToolsTemplate = `"Tools Assets"
{{range .}}
load("//toolchains/{{.}}:assets.bzl", {{. | ToUpper}}_ASSETS = "ASSETS")
{{end}}

TOOLS_ASSETS = {
{{range .}}
  "{{.}}": {{. | ToUpper}}_ASSETS,
{{end}}
}
`
