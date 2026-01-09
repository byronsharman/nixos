vim.opt.hlsearch = false

-- spell-checking
vim.opt.spell = true
vim.opt.spelllang = "en_us"

vim.diagnostic.config({
  signs=false, -- disable annoying diagnostics gutter
  virtual_lines=true,
})

-- highlight yanked text for 200ms
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', {}),
  callback = function()
    vim.hl.on_yank{ higroup="IncSearch", timeout=200 }
  end,
})
