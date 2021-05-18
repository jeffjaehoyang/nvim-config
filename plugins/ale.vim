" configurations for ale (syntax checker and linter)
" https://github.com/dense-analysis/ale

" I don't use ale for linting (native LSP for that stuff)
let g:ale_linters = {
\   'javascript': [],
\   'python': [],
\   'go': []
\}

" these are for formatting
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['black', 'isort'],
\   'javascript': ['prettier'],
\   'css': ['prettier'],
\}

nmap <silent> <leader>a <Plug>(ale_next_wrap)

" Disabling highlighting
let g:ale_set_highlights = 0
" autocompletion is done with nvim-compe
let g:ale_completion_enabled = 0

" Only run linting when saving the file
let g:ale_lint_on_text_changed = 'never'

let g:ale_lint_on_enter = 0
let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1

let g:ale_javascript_prettier_options = '--single-quote --trailing-comma none --tab-width 2'
