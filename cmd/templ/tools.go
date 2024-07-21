package main

var ToolsTemplate = `"Tools"
{{range .}}
load("//toolchains/{{.}}:assets.bzl", {{. | ToUpper}}_ASSETS = "ASSETS")
{{end}}

TOOLS = {
{{range .}}
  "{{.}}": {{. | ToUpper}}_ASSETS,
{{end}}
}
`
