lsp_opts = {
  biome = {
    cmd = {"npx", "biome", "lsp-proxy"},
  },
  clangd = {},
  gleam = {},
  gopls = {},
  nil_ls = {},
  pyright = {},
  ruff = {},
  svelte = {},
  tailwindcss = {},
  tinymist = {
    settings = {
      formatterMode = "typstyle",
    },
  },
}

capabilities = require('blink.cmp').get_lsp_capabilities()
for server, config in pairs(lsp_opts) do
  vim.lsp.config(
    server,
    vim.tbl_extend('keep', config, { capabilities = capabilities })
  )
  vim.lsp.enable(server)
end
