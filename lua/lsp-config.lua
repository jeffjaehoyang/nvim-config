local servers = {"pylsp", "sumneko_lua", "rust_analyzer", "tsserver", "gopls", "ccls"}
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local custom_attach = function()
    vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer = 0})
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer = 0})
    vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition, {buffer = 0})
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer = 0})
    vim.keymap.set("n", "gr", vim.lsp.buf.references, {buffer = 0})
    vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, {buffer = 0})
    vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, {buffer = 0})
    vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", {buffer = 0})
    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {buffer = 0})
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {buffer = 0})
end

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local sumneko_root_path = "/Users/jeffyang/.config/nvim/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"

for _, lsp in pairs(servers) do
    if lsp == "pylsp" then
        capabilities = capabilities
        require("lspconfig").pylsp.setup {
            settings = {
                pylsp = {
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
    elseif lsp == "sumneko_lua" then
        require "lspconfig".sumneko_lua.setup {
            capabilities = capabilities,
            cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
            settings = {
                Lua = {
                    runtime = {
                        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                        version = "LuaJIT",
                        -- Setup your lua path
                        path = runtime_path
                    },
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = {"vim"}
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        library = vim.api.nvim_get_runtime_file("", true)
                    },
                    -- Do not send telemetry data containing a randomized but unique identifier
                    telemetry = {
                        enable = false
                    }
                }
            }
        }
    else
        require("lspconfig")[lsp].setup {
            capabilities = capabilities,
            on_attach = custom_attach
        }
    end
end

local signs = {
    {name = "DiagnosticSignError", text = "⊘"},
    {name = "DiagnosticSignWarn", text = "⚠"},
    {name = "DiagnosticSignHint", text = " "},
    {name = "DiagnosticSignInfo", text = "ⓘ"}
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, {texthl = sign.name, text = sign.text, numhl = ""})
end

local diagnostics_config = {
    virtual_text = {
        spacing = 4,
        --prefix = "⬢ "
        source = true,
        prefix = "■ "
        --prefix = "⬣ ",
        --prefix = "» "
    },
    -- show signs
    signs = {
        active = signs
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
        focus = false,
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = ""
    }
}

vim.diagnostic.config(diagnostics_config)

vim.lsp.handlers["textDocument/hover"] =
    vim.lsp.with(
    vim.lsp.handlers.hover,
    {
        border = "rounded"
    }
)

vim.lsp.handlers["textDocument/signatureHelp"] =
    vim.lsp.with(
    vim.lsp.handlers.signature_help,
    {
        border = "rounded"
    }
)
