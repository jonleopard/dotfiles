" tern
autocmd FileType javascript nnoremap <silent> <buffer> gb :TernDef<CR>
let g:UltiSnipsExpandTrigger="<C-j>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" utilsnips trigger
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"


" Use ; for commands.
nnoremap ; :
" Use Q to execute default register.
nnoremap Q @q

" ack_or_silver_searcher
let g:ackprg = 'ag --vimgrep'

" Fuzzy Search
nnoremap <C-p> :FZF<CR>

" neomake
nmap <Leader><Space>o :lopen<CR>      " open location window
nmap <Leader><Space>c :lclose<CR>     " close location window
nmap <Leader><Space>, :ll<CR>         " go to current error/warning
nmap <Leader><Space>n :lnext<CR>      " next error/warning
nmap <Leader><Space>p :lprev<CR>      " previous error/warning

