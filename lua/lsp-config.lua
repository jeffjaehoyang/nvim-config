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
