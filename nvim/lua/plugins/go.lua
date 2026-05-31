local gobin = (vim.env.GOPATH or (vim.env.HOME .. "/go")) .. "/bin"
if not vim.env.PATH:find(gobin, 1, true) then
  vim.env.PATH = gobin .. ":" .. vim.env.PATH
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "go", "gomod", "gosum", "gowork", "gotmpl" })
    end,
  },

  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "gopls", "delve" })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              gofumpt = true,
              staticcheck = true,
              usePlaceholders = true,
              completeUnimported = true,
              semanticTokens = true,
              codelenses = {
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              analyses = {
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-node_modules" },
            },
          },
        },
      },
    },
  },

  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "go", "gomod", "gowork", "gotmpl" },
    event = { "CmdlineEnter" },
    build = ':lua require("go.install").update_all_sync()',
    opts = {
      lsp_cfg = false,
      lsp_keymaps = false,
      lsp_inlay_hints = { enable = true },
      lsp_codelens = true,
      diagnostic = { hdlr = false },
      goimports = "gopls",
      gofmt = "gofumpt",
      max_line_len = 120,
      trouble = true,
      luasnip = true,
    },
    config = function(_, opts)
      require("go").setup(opts)

      local grp = vim.api.nvim_create_augroup("GoFormat", { clear = true })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = grp,
        pattern = "*.go",
        callback = function()
          require("go.format").goimports()
        end,
      })
    end,
    keys = {
      { "<leader>cgt", "<cmd>GoTest<cr>", desc = "Go test" },
      { "<leader>cgf", "<cmd>GoTestFunc<cr>", desc = "Go test func" },
      { "<leader>cga", "<cmd>GoTestFile<cr>", desc = "Go test file" },
      { "<leader>cgA", "<cmd>GoAddTest<cr>", desc = "Go add test for func" },
      { "<leader>cgs", "<cmd>GoFillStruct<cr>", desc = "Go fill struct" },
      { "<leader>cgi", "<cmd>GoImpl<cr>", desc = "Go impl interface" },
      { "<leader>cgC", "<cmd>GoCoverage<cr>", desc = "Go coverage" },
      { "<leader>cgT", "<cmd>GoModTidy<cr>", desc = "Go mod tidy" },
      { "<leader>cgv", "<cmd>GoVulnCheck<cr>", desc = "govulncheck" },
      {
        "<leader>cgr",
        function()
          vim.cmd("botright 15split | terminal go run .")
        end,
        desc = "Go run (split terminal)",
      },
    },
  },

  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = { "mfussenegger/nvim-dap" },
    opts = {},
  },
}
