call plug#begin('~/.config/nvim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-surround'
Plug 'nanotech/jellybeans.vim', { 'tag': 'v1.7' }
Plug 'airblade/vim-gitgutter'
Plug 'preservim/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ryanoasis/vim-devicons'

call plug#end()

" Tips for usage/installations
" ----------------------------
" ----------------------------
"
" Commenting/uncommenting bulk code
" ---------------------------------
" <Leader>cc to comment selected lines
" <Leader>cu to uncomment selected lines
"
" Using CoC for C++
" -----------------
"  Run cmake with the flag: -DCMAKE_EXPORT_COMPILE_COMMANDS=1 and
"  ln -s ~/myproject/cmake-build/compile_commands.json ~/myproject/
"

" General
let mapleader=","           
set encoding=utf-8                  " set encoding to utf-8
set nocompatible                    " disable compatibility to old-time vi
set showmatch                       " show the matching closing bracket
set hidden                          " hide current unsaved file instead of closing it when opening a new file
set showcmd                         " show partial command you type in the last line of the screen
set wildmenu                        " enable auto completion menu after pressing TAB
set wildmode=list:longest,list:full " allow for completions similar to Bash
set lazyredraw                      " the screen will not be redrawn while executing macros
set backupdir=~/.cache/nvim/backups " directory to store backup files.


set ignorecase                      " case insensitive
set hlsearch                        " highlight search
set incsearch                       " incremental search
set smartcase                       " override the 'ignorecase' option if the search pattern contains upper case characters
set tabstop=4                       " number of columns occupied by a tab
set softtabstop=4                   " see multiple spaces as tabstops 
set expandtab                       " converts tabs to white space
set shiftwidth=4                    " width for autoindents
set autoindent                      " indent a new line the same amount as the line just typed
set number                          " display current line number
set relativenumber                  " display relative line numbers
set ruler                           " display a visual ruler to see line width
set cc=144                          " set a 144 column border for good coding style
set textwidth=144                   " text width; move to start of file and fire gqG to re-format
filetype plugin indent on           " allow auto-indenting depending on file type
syntax on                           " syntax highlighting
set mouse=a                         " enable mouse click
set clipboard=unnamedplus           " using system clipboard
set cursorline                      " highlight current cursorline
set ttyfast                         " speed up scrolling in Vim
set noswapfile                      " disable creating swap file
set mousemodel=popup                " right mouse opens a popup menu like Windows
set backspace=indent,eol,start      " allow backspace over indent, eol and start (of insert)
set shell=$SHELL                    " name of shell to use for ! and :! commands
set updatetime=300                  " millisecs vim waits after you stop typing before it triggers plugins like git-gutter
set shortmess+=c                    " don't give ins-completion-menu messages.  
set signcolumn=yes                  " show the column where signs like git-gutter ones show up
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite,*.o,*.obj,*~,.git,*.pyc

" Coloscheme
silent! colorscheme jellybeans
let g:airline_theme = 'jellybeans'
set bg=dark

" Keep what you copied, despite deletion
xnoremap p pgvy

" Hide insert status  
autocmd VimEnter * set nosc

" NerdTree classic setup
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-n> :NERDTreeFind<CR>

let g:NERDTreeChDirMode=2
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeWinSize = 50
let g:NERDTreeMinimalUI = 1
let NERDTreeShowLineNumbers = 1
let g:NERDTreeGitStatusConcealBrackets = 1
let NERDTreeMapOpenVSplit='v'
let NERDTreeMapOpenSplit='s'
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }

" CoC settings
let g:coc_node_path = '/usr/bin/node'
let g:coc_npm_path = '/usr/bin/npm'
let g:coc_global_extensions = [
     \'coc-clang-format-style-options',
     \'coc-clangd',
     \'coc-json',
     \'coc-cmake',
     \'coc-jedi']

" remap <cr> to make it confirms completion
 inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" Suggestions colouring (ref: https://vi.stackexchange.com/questions/12664/is-there-any-way-to-change-the-popup-menu-color)
 :highlight PmenuSel ctermbg=gray guibg=gray

 " Show docs of function/class
nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" CoC shortcuts
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Switch between .cpp and .h files
nnoremap <silent> gx :CocCommand clangd.switchSourceHeader<CR>

" Format selections (not supported by Black)
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Terminal while editing
nmap tt :tabe term://zsh<CR>
nmap ht :split term://zsh<CR>
nmap vt :vsplit term://zsh<CR>
au TermOpen * tnoremap <Esc> <c-\><c-n>

" Resize splits
nmap vp :vertical resize +2<CR>
nmap vm :vertical resize -2<CR>
nmap hp :resize +2<CR>
nmap hm :resize -2<CR>

" Tab navigations
nmap nt :tabn<CR>
nmap pt :tabp<CR>
noremap t0 1gt
noremap t9 :tablast<CR>

" FZF 
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
let $FZF_DEFAULT_COMMAND = "fdfind --exclude={.git,target,node_modules,build,tmp} --type f"
au FileType fzf tunmap <Esc>

" Silver Searcher 
nnoremap <silent> <leader>F :Ag!<CR>

"" Recovery commands from history through FZF
nmap <leader>y :History:<CR>
