package main

type Asset struct {
	Name      string   `json:"name"`
	Binary    string   `json:"binary"`
	Algo      string   `json:"algo"`
	Platform  string   `json:"platform"`
	Url       string   `json:"url"`
	Integrity string   `json:"integrity"`
	Files     []string `json:"files"`
}

type Assets []Asset

var AssetsTemplate = `"Assets"

ASSETS = {
{{range .}}
  "{{.Platform}}": struct(
      url = "{{.Url}}",
      binary = "{{.Binary}}",
      integrity = "sha{{.Algo}}-{{.Integrity}}"
      {{$length := len .Files}}
        {{if gt $length 0}},
        files = [{{range $index, $element := .Files}}"{{.}}"{{if not (last $index $length)}}, {{end}}{{end}}]
        {{end}}
  ),
{{end}}}
`
