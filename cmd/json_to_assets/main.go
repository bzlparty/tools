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
{{range .}}    "{{.Platform}}": struct(url = "{{.Url}}", binary = "{{.Binary}}", integrity = "sha{{.Algo}}-{{.Integrity}}"),
{{end}}}
`

func main() {
	var assets Assets

  check(json.NewDecoder(os.Stdin).Decode(&assets))

	tmpl, err := template.New("assets").Parse(AssetsTemplate)

  check(err)

  check(tmpl.Execute(os.Stdout, assets))
}

func check(err error) {
  if err != nil {
    log.Fatal(err)
  }
}
