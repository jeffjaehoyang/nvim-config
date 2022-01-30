" custom setting for prettier
let g:neoformat_try_node_exe = 1

" custom setting for clangformat
let g:neoformat_c_clangformat = {
    \ 'exe': 'clang-format',
    \ 'args': ['--style="{IndentWidth: 4}"']
\}
let g:neoformat_cpp_clangformat = {
    \ 'exe': 'clang-format',
    \ 'args': ['--style="{IndentWidth: 4}"']
\}
let g:neoformat_enabled_cpp = ['clangformat']
let g:neoformat_enabled_c = ['clangformat']

augroup fmt
  autocmd!
  autocmd BufWritePre *.lua,*.cpp,*.c,*.h,*.js,*.jsx,*.ts,*.tsx undojoin | Neoformat
augroup END
