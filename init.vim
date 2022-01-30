" (N)Vim Configuration File
" vim  : place in $HOME/.vimrc
" nvim : place in $HOME/.config/nvim/init.vim
" $ ln -s $HOME/.config/nvim/init.vim $HOME/.vimrc
"
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

set path+=**
" Nice menu when typing `:find *.py`
set wildmode=longest,list,full
set wildmenu
" Ignore files
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*

call plug#begin('~/.vim/plugged')

" linting and formatting
" Plug 'dense-analysis/ale'
Plug 'sbdchd/neoformat'
Plug 'deoplete-plugins/deoplete-clang'
Plug 'psf/black', { 'branch': 'stable' }

" native LSP for neovim
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'

" completion
" Plug 'nvim-lua/completion-nvim'
Plug 'hrsh7th/nvim-compe'

" status bar
Plug 'itchyny/lightline.vim'

" colorschemes
Plug 'gruvbox-community/gruvbox'
Plug 'flazz/vim-colorschemes'

" fantastic fuzzy finder and dependencies
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'

" comment out stuff gcc
Plug 'tpope/vim-commentary'

" nerdtree yes
Plug 'preservim/nerdtree'

" auto pairing for brackets
Plug 'jiangmiao/auto-pairs'

" cool movement
Plug 'matze/vim-move'

" jsx syntax highlighting
"Plug 'maxmellon/vim-jsx-pretty'

" c/cpp syntax highlighting
"Plug 'bfrg/vim-cpp-modern'
"
" a ton of language syntax support loaded on-demand
Plug 'sheerun/vim-polyglot'


" git stuff
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" indent guides
" Plug 'yggdroot/indentLine'

" hacklang
Plug 'hhvm/vim-hack'

" tree-sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}


call plug#end()

" source vim files
source ~/.config/nvim/basics/sets.vim
" source ~/.config/nvim/plugins/colors.vim
" source ~/.config/nvim/plugins/ale.vim
source ~/.config/nvim/plugins/neoformat.vim
source ~/.config/nvim/plugins/git-gutter.vim
source ~/.config/nvim/plugins/lightline.vim
source ~/.config/nvim/plugins/lsp-config.vim
source ~/.config/nvim/plugins/nerdtree.vim
source ~/.config/nvim/plugins/telescope.vim
source ~/.config/nvim/plugins/vim-move.vim
source ~/.config/nvim/plugins/saga.vim

" source lua files
luafile ~/.config/nvim/lua/lsp-config.lua
luafile ~/.config/nvim/lua/compe-config.lua
