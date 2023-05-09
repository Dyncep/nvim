local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

local servers = {
  "cssls",
  "html",
  "tsserver",
  "jsonls",
  "yamlls",
  "clangd",
  "intelephense",
  "jedi_language_server",
  "rust_analyzer",
  "eslint"
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    update_in_insert = false,
    virtual_text = { spacing = 4, prefix = "●" },
    severity_sort = true,
  }
)

lsp_installer.setup()

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }

  if server == "sumneko_lua" then
    local sumneko_opts = require "user.lsp.settings.sumneko_lua"
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
  end

  if server == "pyright" then
    local pyright_opts = require "user.lsp.settings.pyright"
    opts = vim.tbl_deep_extend("force", pyright_opts, opts)
  end

  if server == "eslint" then
    local eslint_opts = {
      on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "EslintFixAll",
        })
        on_attach(client, bufnr)
        enable_format_on_save(client, bufnr)
      end,
    }
    opts = vim.tbl_deep_extend("force", eslint_opts, opts)
  end

  lspconfig[server].setup(opts)
end
