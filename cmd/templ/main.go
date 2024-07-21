package main

import (
	"encoding/json"
	"log"
	"os"
	"text/template"
)

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
{{range .}}    "{{.Platform}}": struct(url = "{{.Url}}", binary = "{{.Binary}}", integrity = "sha{{.Algo}}-{{.Integrity}}"{{$length := len .Files}}{{if gt $length 0}}, files = [{{range $index, $element := .Files}}"{{.}}"{{if not (last $index $length)}}, {{end}}{{end}}]{{end}}),
{{end}}}
`

func main() {
	var assets Assets
	var funcMap = template.FuncMap{
		"last": func(index int, length int) bool {
			if index == (length - 1) {
				return true
			}
			return false
		},
	}

	check(json.NewDecoder(os.Stdin).Decode(&assets))

	tmpl, err := template.New("assets").Funcs(funcMap).Parse(AssetsTemplate)

	check(err)

	check(tmpl.Execute(os.Stdout, assets))
}

func check(err error) {
	if err != nil {
		log.Fatal(err)
	}
}
