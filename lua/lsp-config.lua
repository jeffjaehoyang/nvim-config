local servers = {"rust_analyzer", "tsserver", "gopls"}
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local custom_attach = function(client, bufnr)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer = 0})
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer = 0})
    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {buffer = 0})
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer = 0})
    vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, {buffer = 0})
    vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, {buffer = 0})
    vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", {buffer = 0})
    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {buffer = 0})
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {buffer = 0})
end
for _, lsp in pairs(servers) do
    require("lspconfig")[lsp].setup {
        capabilities = capabilities,
        on_attach = custom_attach
    }
end

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

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local sumneko_root_path = "/Users/jeffyang/.config/nvim/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"

require "lspconfig".sumneko_lua.setup {
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

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        -- Enable underline, use default values
        underline = true,
        -- Enable virtual text, override spacing to 4
        virtual_text = {
            spacing = 4,
            prefix = "● "
        },
        update_in_insert = true
    }
)

local signs = {
    {name = "DiagnosticSignError", text = "✘"},
    {name = "DiagnosticSignWarn", text = "⚠"},
    {name = "DiagnosticSignHint", text = " "},
    {name = "DiagnosticSignInfo", text = "ⓘ"}
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, {texthl = sign.name, text = sign.text, numhl = ""})
end

local diagnostics_config = {
    virtual_text = true,
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
