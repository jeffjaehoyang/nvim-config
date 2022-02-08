set termguicolors

nnoremap <silent>gt    :BufferNext<CR>
nnoremap <silent>gT    :BufferPrevious<CR>

nnoremap <leader>1 :BufferGoto 1<CR>
nnoremap <leader>2 :BufferGoto 2<CR>
nnoremap <leader>3 :BufferGoto 3<CR>
nnoremap <leader>4 :BufferGoto 4<CR>
nnoremap <leader>5 :BufferGoto 5<CR>
nnoremap <leader>6 :BufferGoto 6<CR>
nnoremap <leader>7 :BufferGoto 7<CR>
nnoremap <leader>8 :BufferGoto 8<CR>
nnoremap <leader>9 :BufferGoto 9<CR>

nnoremap <leader>bd :BufferClose<CR>

let bufferline = get(g:, 'bufferline', {})

let bufferline.maximum_padding = 1
let bufferline.clickable = v:false
let bufferline.closable = v:false
let bufferline.animation = v:false
let bufferline.icons = v:true

