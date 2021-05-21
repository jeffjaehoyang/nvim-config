lspconfig = require'lspconfig'

lspconfig.pyls.setup{
    settings = {
        pyls = {
            plugins = {
                pycodestyle = {
                    enabled = false,
                    ignore = {
                        "E501"
                    }
                }
            }
        }
    }
}

lspconfig.tsserver.setup{}
lspconfig.rust_analyzer.setup{}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- Enable underline, use default values
    underline = true,
    -- Enable virtual text, override spacing to 4
    virtual_text = {
      spacing = 4,
      prefix = '● ',
    },
    update_in_insert = false,
  }
)

-- cosmetics
vim.fn.sign_define("LspDiagnosticsSignError",
    {text = "✘", texthl = "GruvboxRed"})
vim.fn.sign_define("LspDiagnosticsSignWarning",
    {text = "⚠", texthl = "GruvboxYellow"})
vim.fn.sign_define("LspDiagnosticsSignInformation",
    {text = "♫", texthl = "GruvboxBlue"})
vim.fn.sign_define("LspDiagnosticsSignHint",
    {text = "☀", texthl = "GruvboxAqua"})
