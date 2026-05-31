-- Terragrunt filetype detection. `terragrunt.hcl` and `root.hcl` are always
-- terragrunt; other `.hcl` files only count as terragrunt when a sibling
-- `terragrunt.hcl` exists, so Packer/Consul HCL stays as plain `hcl`.
vim.filetype.add({
  filename = {
    ["terragrunt.hcl"] = "terragrunt",
    ["root.hcl"] = "terragrunt",
  },
  pattern = {
    [".*%.hcl"] = function(path)
      local dir = vim.fs.dirname(path)
      if dir and (vim.uv or vim.loop).fs_stat(dir .. "/terragrunt.hcl") then
        return "terragrunt"
      end
    end,
  },
})

-- Reuse the hcl tree-sitter parser for the new terragrunt filetype so we get
-- highlighting/indent/folds without shipping a separate grammar.
vim.treesitter.language.register("hcl", "terragrunt")

-- Buffer-local workflow keymaps. Mirrors the `<leader>cg…` pattern in go.lua:
-- lowercase `ct…` for terraform, uppercase `cT…` for terragrunt.
local function term(cmd)
  return function()
    vim.cmd("botright 15split | terminal " .. cmd)
  end
end

local grp = vim.api.nvim_create_augroup("TerraformKeys", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = grp,
  pattern = { "terraform", "terraform-vars" },
  callback = function(args)
    local function map(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = args.buf, desc = desc, silent = true })
    end
    map("<leader>cti", term("terraform init"), "Terraform init")
    map("<leader>ctp", term("terraform plan"), "Terraform plan")
    map("<leader>cta", term("terraform apply"), "Terraform apply")
    map("<leader>ctv", term("terraform validate"), "Terraform validate")
    map("<leader>ctf", term("terraform fmt -recursive"), "Terraform fmt (recursive)")
    map("<leader>ctd", function()
      if vim.fn.confirm("Run terraform destroy?", "&Yes\n&No", 2) == 1 then
        vim.cmd("botright 15split | terminal terraform destroy")
      end
    end, "Terraform destroy")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = grp,
  pattern = "terragrunt",
  callback = function(args)
    local function map(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = args.buf, desc = desc, silent = true })
    end
    map("<leader>cTi", term("terragrunt init"), "Terragrunt init")
    map("<leader>cTp", term("terragrunt plan"), "Terragrunt plan")
    map("<leader>cTa", term("terragrunt apply"), "Terragrunt apply")
    map("<leader>cTv", term("terragrunt validate-inputs"), "Terragrunt validate-inputs")
    map("<leader>cTh", term("terragrunt hcl fmt"), "Terragrunt hcl fmt")
    map("<leader>cTr", term("terragrunt run-all plan"), "Terragrunt run-all plan")
  end,
})

return {
  -- Tree-sitter parsers (already pulled by the LazyVim terraform extra; listed
  -- explicitly so this file is self-documenting).
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "terraform", "hcl" })
    end,
  },

  -- Mason tools.
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "terraform-ls", "tflint" })
    end,
  },

  -- Tune terraform-ls on top of the LazyVim extra defaults.
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        terraformls = {
          settings = {
            terraform = {
              experimentalFeatures = {
                prefillRequiredFields = true,
                validateOnSave = true,
              },
              validation = {
                enableEnhancedValidation = true,
              },
            },
          },
        },
      },
    },
  },

  -- Official Terragrunt language server. The plugin ships its own setup helper.
  -- The `terragrunt-ls` binary isn't in Mason yet, so we install it via `go install`
  -- on `:Lazy sync` — your go.lua already adds $GOPATH/bin to PATH.
  {
    "gruntwork-io/terragrunt-ls",
    ft = "terragrunt",
    build = function()
      vim.fn.system({ "go", "install", "github.com/gruntwork-io/terragrunt-ls@latest" })
    end,
    config = function()
      local tg = require("terragrunt-ls")
      tg.setup({})
      if tg.client then
        local function attach()
          vim.lsp.buf_attach_client(0, tg.client)
        end
        vim.api.nvim_create_autocmd("FileType", {
          pattern = "terragrunt",
          callback = attach,
        })
        if vim.bo.filetype == "terragrunt" then
          attach()
        end
      end
    end,
  },

  -- Conform: add the terragrunt mapping and override the built-in formatter's
  -- condition (which otherwise skips files literally named `terragrunt.hcl`).
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.terragrunt = { "terragrunt_hclfmt" }

      opts.formatters = opts.formatters or {}
      opts.formatters.terragrunt_hclfmt = {
        inherit = true,
        condition = function()
          return true
        end,
      }
    end,
  },
}
