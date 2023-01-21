function map(mode, combo, mapping, opts)
  local options = {noremap = true}
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, combo, mapping, options)
end

-- Resize splits
map('n', 'vp', ':vertical resize +2<CR>', {noremap = true})
map('n', 'vm', ':vertical resize -2<CR>', {noremap = true})
map('n', 'hp', ':resize +2<CR>', {noremap = true})
map('n', 'hm', ':resize -2<CR>', {noremap = true})

-- Tab navigations
map('n', 'nt', ':tabn<CR>', {noremap = true})
map('n', 'pt', ':tabp<CR>', {noremap = true})
map('n', 't0', '1gt', {noremap = true})
map('n', 't9', ':tablast<CR>', {noremap = true})

-- FZF 
map('n', '<leader>s', ':Files<CR>', {silent = true})
map('n', '<leader>b', ':Buffers<CR>', {silent = true})
map('n', '<leader>y', ':History<CR>', {noremap = true})

-- SilverSearcher 
map('n', '<leader>S', ':Ag!', {noremap = true})

-- Format selections (not supported by Black)
map('n', '<leader>f', '<Plug>(coc-format-selected)')

-- Keep what you copied, despite deletion
map('n', 'p', 'pgvy')

