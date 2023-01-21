vim.opt.background = 'dark'
vim.g.sonokai_style = 'andromeda'
vim.g.sonokai_better_performance = 1
vim.g.airline_theme = 'sonokai'
vim.cmd [[
try
    colorscheme sonokai
    syntax enable
catch /^Vim\%((\a\+)\)\=:E185/
    " Ignore it
endtry
]]
