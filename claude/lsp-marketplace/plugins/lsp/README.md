# lsp

Local LSP plugin for Claude Code, providing code intelligence (diagnostics,
definitions, formatting) for the languages used in daily infra/dev work.

All server definitions live inline in `../../.claude-plugin/marketplace.json`
(`strict: false`), so this directory only needs to exist as the plugin `source`.

## Servers & file types

| Server | Files | Install |
|---|---|---|
| `gopls` | `.go` | `go install golang.org/x/tools/gopls@latest` |
| `pyright-langserver` | `.py`, `.pyi` | `npm i -g pyright` |
| `bash-language-server` | `.sh`, `.bash` | `npm i -g bash-language-server` |
| `terraform-ls` | `.tf`, `.tfvars`, `.hcl` (terragrunt) | `brew install terraform-ls` |
| `yaml-language-server` | `.yaml`, `.yml` (ansible + k8s + helm values) | `npm i -g yaml-language-server` |
| `helm_ls` | `.tpl` (helm template helpers) | `brew install helm-ls` |
| `jinja-lsp` | `.j2`, `.jinja`, `.jinja2` | prebuilt from [uros-5/jinja-lsp releases](https://github.com/uros-5/jinja-lsp/releases) |

## Notes

- **YAML ownership**: `yaml-language-server` owns `.yaml`/`.yml` (broad: Ansible,
  Kubernetes, Helm `values.yaml`). `helm_ls` only owns `.tpl` to avoid two
  servers fighting over the same extension.
- **Terragrunt**: no dedicated LSP exists; `.hcl` is pointed at `terraform-ls`
  for basic HCL intelligence.
- **Jinja**: `jinja-lsp` is young/experimental — included on request.
