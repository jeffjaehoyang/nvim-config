" configurations for ale (syntax checker and linter)
" https://github.com/dense-analysis/ale

" I don't use ale for linting (native LSP for that stuff)
let g:ale_linters = {
\   'javascript': [],
\   'python': [],
\   'go': [],
\   'hack': ['hack']
\}

" these are for formatting
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['black'],
\   'javascript': ['prettier'],
\   'javascriptreact': ['prettier'],
\   'typescript': ['prettier'],
\   'typescriptreact': ['prettier'],
\   'css': ['prettier'],
\}

nmap <silent> <leader>a <Plug>(ale_next_wrap)

" Disabling highlighting
let g:ale_set_highlights = 0
" autocompletion is done with nvim-compe
let g:ale_completion_enabled = 0

" Only run linting when saving the file
" let g:ale_lint_on_text_changed = 'never'
"
" Custom icons in gutter
" let g:ale_sign_column_always = 1
" let g:ale_sign_error = "✘"
" let g:ale_sign_warning = "?"
" let g:ale_sign_info = "ⓘ"

" Show error info for line when cursor is on that line
" let g:ale_virtualtext_cursor = 1
" let g:ale_virtualtext_prefix = "● "

let g:ale_lint_on_enter = 0
let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1

let g:ale_javascript_prettier_options = '--single-quote --trailing-comma none --tab-width 2'

" python stuff
let g:ale_python_flake8_options = '--ignore=E501'
