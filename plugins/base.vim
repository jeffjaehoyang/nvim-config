let mapleader = ","
nmap <leader>w :w!<cr>

syntax on
filetype plugin on
filetype indent on
syntax enable

set number relativenumber
set nu rnu
set colorcolumn=80
set scrolloff=8
set cmdheight=1
set backspace=eol,start,indent
set nowrap
set noswapfile
set nobackup
set nowb
set hidden
set incsearch
set lazyredraw
set showmatch
set mat=2
set noerrorbells
set novisualbell
set t_vb=
set tm=500
set foldcolumn=1
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
set encoding=utf8
set ffs=unix,dos,mac
set expandtab
set smarttab
" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
" Linebreak on 500 characters
set lbr
set tw=500
set ai "Auto indent
set si "Smart indent
" set splitbelow
set splitright
" set guicursor=i:block
set updatetime=50
set shortmess+=c
set tabline=

try
  colorscheme gruvbox
catch
endtry

try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

let g:gruvbox_contrast_dark = 'hard'

if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

let g:gruvbox_invert_selection='0'
set background=dark

" if you want to do stuff like setting background images
hi Normal ctermbg=NONE

" lsp diagnostics error text color
hi DiagnosticError guifg=Red

if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" highlight in grey
hi Visual cterm=none ctermbg=darkgrey

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <Tab>j <C-W>j
map <Tab>k <C-W>k
map <Tab>h <C-W>h
map <Tab>l <C-W>l

" Change 2 split windows from vert to horiz or horiz to vert
map <leader>tk <C-w>t<C-w>H
map <leader>th <C-w>t<C-w>K

" Make adjusing split sizes a bit more friendly
noremap <silent> <S-Left> :vertical resize +3<CR>
noremap <silent> <S-Right> :vertical resize -3<CR>
noremap <silent> <S-Up> :resize +3<CR>
noremap <silent> <S-Down> :resize -3<CR>

" Greatest buffer remaps evuhhh
nnoremap gb :ls<CR>:b<Space>
nnoremap <leader>vs :ls<cr>:vsp<space>\|<space>b<space>
nnoremap <leader>s :ls<cr>:sp<space>\|<space>b<space>
nnoremap <leader>bd :bd<cr>

nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>

" map <leader>ba :bufdo bd<cr>
" map <leader>tn :tabnew<cr>
" map <leader>to :tabonly<cr>
" map <leader>tc :tabclose<cr>
" map <leader>tm :tabmove
" map <leader>t<leader> :tabnext

" Remap VIM 0 to first non-blank character
map 0 ^

autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
autocmd FileType javascriptreact setlocal shiftwidth=2 tabstop=2
autocmd FileType typescript setlocal shiftwidth=2 tabstop=2
autocmd FileType typescriptreact setlocal shiftwidth=2 tabstop=2
autocmd FileType html       setlocal shiftwidth=2 tabstop=2
autocmd FileType python     setlocal shiftwidth=4 softtabstop=4 expandtab
autocmd FileType hack       setlocal shiftwidth=2 tabstop=2
autocmd FileType c          setlocal shiftwidth=4 tabstop=4
autocmd FileType cpp        setlocal shiftwidth=4 tabstop=4

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

if has("mac") || has("macunix")
  nmap <D-k> <M-k>
  nmap <D-j> <M-j>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" => Fast editing and reloading of vimrc configs
autocmd! bufwritepost ~/.vimrc source ~/.vimrc

let g:python3_host_prog='/usr/local/bin/python3'
" Add the virtualenv's site-packages to vim path
if has('python')
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF
endif

