-- NerdTree
map('n', '<C-t>', ':NERDTreeToggle<CR>')
map('n', '<C-n>', ':NERDTreeFind<CR>')

vim.g.NERDTreeChDirMode = 2
vim.g.NERDTreeShowBookmarks = 1
vim.g.nerdtree_tabs_focus_on_files = 1
vim.g.NERDTreeWinSize = 50
vim.g.NERDTreeMinimalUI = 1
vim.g.NERDTreeShowLineNumbers = 1
vim.g.NERDTreeGitStatusConcealBrackets = 1
vim.g.NERDTreeMapOpenVSplit = 'v'
vim.g.NERDTreeMapOpenSplit = 's'

vim.g.NERDTreeGitStatusIndicatorMapCustom = {
                 Modified  = '✹',
                 Staged    = '✚',
                 Untracked = '✭',
                 Renamed   = '➜',
                 Unmerged  = '═',
                 Deleted   = '✖',
                 Dirty     = '✗',
                 Ignored   = '☒',
                 Clean     = '✔︎',
                 Unknown   = '?'}
