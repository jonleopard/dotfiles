" vim: set foldmethod=marker foldlevel=0 nomodeline:
" ============================================================================
" Jon Leopard's .vimrc {{{
" ============================================================================

" }}}
" ============================================================================
" BASIC SETTINGS {{{
" ============================================================================
let mapleader      = ' '
let maplocalleader = ' '

augroup vimrc
    autocmd!
augroup END


if !exists("g:syntax_on")
  syntax enable
endif

set nu
syntax on
set undofile
set autoindent
set autowrite
set smartindent
set lazyredraw
set laststatus=2
set showcmd
set noshowmode
set visualbell
set backspace=indent,eol,start
set timeoutlen=500
set whichwrap=b,s
set shortmess=aIT
set hlsearch " CTRL-L / CTRL-R W
set incsearch
set hidden
set ignorecase smartcase
set signcolumn=yes
set wildmenu
set wildmode=full
set tabstop=2
set shiftwidth=2
set expandtab smarttab
set scrolloff=5
set encoding=utf-8
set list
set listchars=tab:\|\ ,
set virtualedit=block
set nojoinspaces
set diffopt=filler,vertical
set autoread
set clipboard=unnamed
set foldlevelstart=99
set grepformat=%f:%l:%c:%m,%f:%l:%m
set completeopt=menuone,preview
set omnifunc=syntaxcomplete#Complete
set nocursorline
set nrformats=hex
set title
set showtabline=2
set cmdheight=2
silent! set cryptmethod=blowfish2

" 80 chars/line
set textwidth=0
if exists('&colorcolumn')
  set colorcolumn=80
endif

set synmaxcol=1000

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" set complete=.,w,b,u,t
set complete-=i

" mouse
silent! set ttymouse=xterm2
set mouse=a

" yank to clipboard
if has("clipboard")
  set clipboard=unnamed " copy to the system clipboard
  if has("unnamedplus") " X11 support
    set clipboard+=unnamedplus
  endif
endif
" }}}
" ============================================================================
" MAPPINGS {{{
" ============================================================================

" ----------------------------------------------------------------------------
" Basic mappings
" ----------------------------------------------------------------------------

" qq to record, Q to replay
nnoremap Q @q

" Disable CTRL-A on tmux or on screen
if $TERM =~ 'screen'
  nnoremap <C-a> <nop>
  nnoremap <Leader><C-a> <C-a>
endif

" Save
inoremap <C-s>     <C-O>:update<cr>
nnoremap <C-s>     :update<cr>
nnoremap <leader>s :update<cr>
nnoremap <leader>w :update<cr>

" Quit
inoremap <C-Q>     <esc>:q<cr>
nnoremap <C-Q>     :q<cr>
vnoremap <C-Q>     <esc>
nnoremap <Leader>q :q<cr>
nnoremap <Leader>Q :qa!<cr>

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright


" Quicker window movement
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Movement in insert mode
inoremap <C-h> <C-o>h
inoremap <C-l> <C-o>a
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-^> <C-o><C-^>

" Navigating tabs easier
map <D-S-{> :tabprevious
map <D-S-}> :tabprevious

" ----------------------------------------------------------------------------
" tmux
" ----------------------------------------------------------------------------
function! s:tmux_send(content, dest) range
  let dest = empty(a:dest) ? input('To which pane? ') : a:dest
  let tempfile = tempname()
  call writefile(split(a:content, "\n", 1), tempfile, 'b')
  call system(printf('tmux load-buffer -b vim-tmux %s \; paste-buffer -d -b vim-tmux -t %s',
        \ shellescape(tempfile), shellescape(dest)))
  call delete(tempfile)
endfunction

function! s:tmux_map(key, dest)
  execute printf('nnoremap <silent> %s "tyy:call <SID>tmux_send(@t, "%s")<cr>', a:key, a:dest)
  execute printf('xnoremap <silent> %s "ty:call <SID>tmux_send(@t, "%s")<cr>gv', a:key, a:dest)
endfunction

call s:tmux_map('<leader>tt', '')
call s:tmux_map('<leader>th', '.left')
call s:tmux_map('<leader>tj', '.bottom')
call s:tmux_map('<leader>tk', '.top')
call s:tmux_map('<leader>tl', '.right')
call s:tmux_map('<leader>ty', '.top-left')
call s:tmux_map('<leader>to', '.top-right')
call s:tmux_map('<leader>tn', '.bottom-left')
call s:tmux_map('<leader>t.', '.bottom-right')

" }}}
" ============================================================================
" VIM-PLUG BLOCK {{{
" ============================================================================

call plug#begin('~/.config/nvim/plugged')

" ----------------------------------------------------------------------------
" Javascript
" ----------------------------------------------------------------------------
Plug 'othree/jspc.vim',               { 'for': ['javascript', 'javascript.jsx'] }
Plug 'digitaltoad/vim-pug'
Plug 'elzr/vim-json'
Plug 'alexlafroscia/deoplete-flow',   { 'branch': 'pass-filename-to-autocomplete' }


" ----------------------------------------------------------------------------
" Go
" ----------------------------------------------------------------------------
Plug 'fatih/vim-go',                  { 'do': ':GoUpdateBinaries' }
Plug 'zchee/deoplete-go',             { 'do': 'make'}

" ----------------------------------------------------------------------------
" Rust
" ----------------------------------------------------------------------------
Plug 'racer-rust/vim-racer'
Plug 'sebastianmarkow/deoplete-rust'

" ----------------------------------------------------------------------------
" Colorscheme & Syntax Highlighting & Linting
" ----------------------------------------------------------------------------
Plug 'Yggdroot/indentLine', { 'on': 'IndentLinesEnable' }
Plug 'chriskempson/base16-vim'
Plug 'sheerun/vim-polyglot'
Plug 'hail2u/vim-css3-syntax'
Plug 'ap/vim-css-color'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'jparise/vim-graphql'
Plug 'elzr/vim-json'
Plug 'w0rp/ale'
Plug 'RRethy/vim-illuminate'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }


" ----------------------------------------------------------------------------
" Git
" ----------------------------------------------------------------------------
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'

" ----------------------------------------------------------------------------
" Tmux
" ----------------------------------------------------------------------------
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux'
Plug 'tmux-plugins/vim-tmux-focus-events'

"----------------------------------------------------------------------------
" Autocompletion & Snippets
" ----------------------------------------------------------------------------
Plug 'Shougo/deoplete.nvim',         { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neco-vim'
Plug 'Shougo/echodoc.vim'

" ----------------------------------------------------------------------------
" Editing
" ----------------------------------------------------------------------------
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-commentary',         { 'on': '<Plug>Commentary' }
Plug 'junegunn/vim-easy-align',      { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'plasticboy/vim-markdown'
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'
Plug 'mattn/emmet-vim'

" ----------------------------------------------------------------------------
" Searching/Navigation
" ----------------------------------------------------------------------------
Plug 'junegunn/fzf',                  { 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-dirvish'
Plug 'majutsushi/tagbar',             { 'on': 'TagbarToggle' }
Plug 'justinmk/vim-gtfo'

" ----------------------------------------------------------------------------
" Utils
" ----------------------------------------------------------------------------
Plug 'machakann/vim-highlightedyank'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-obsession'
Plug 'mbbill/undotree',               { 'on': 'UndotreeToggle' }
Plug 'roman/golden-ratio'

Plug 'itchyny/lightline.vim'
Plug 'jonleopard/base16-vim-lightline'
Plug 'maximbaz/lightline-ale'
Plug 'maximbaz/lightline-trailing-whitespace'
Plug 'mengelbrecht/lightline-bufferline'

Plug 'mhinz/vim-startify'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/vim-emoji'
Plug 'metakirby5/codi.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'sgur/vim-editorconfig'
Plug 'iamcco/markdown-preview.vim'

call plug#end()
" }}}
" ============================================================================
" COLOR SETTINGS {{{
" ============================================================================
if has('termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif


" base16-vim will match whatever you have set your shell color scheme as
if filereadable(expand("~/.vimrc_background"))
  source ~/.vimrc_background
endif

" }}}
" ============================================================================
" PLUGIN SETTINGS{{{
" ============================================================================


" ----------------------------------------------------------------------------
" Tagbar
" ----------------------------------------------------------------------------
let g:tagbar_sort = 0

" Tags
nnoremap <C-]> g<C-]>
nnoremap g[ :pop<cr>

" ctags
set tags=./tags;/

" ----------------------------------------------------------------------------
" undotree
" ----------------------------------------------------------------------------
let g:undotree_WindowLayout = 2
nnoremap U :UndotreeToggle<CR>

if has("persistent_undo")
  set undodir=~/.config/nvim/undodir
  set undofile
endif



" ----------------------------------------------------------------------------
" AutoSave
" ----------------------------------------------------------------------------
function! s:autosave(enable)
  augroup autosave
    autocmd!
    if a:enable
      autocmd TextChanged,InsertLeave <buffer>
            \  if empty(&buftype) && !empty(bufname(''))
            \|   silent! update
            \| endif
    endif
  augroup END
endfunction

command! -bang AutoSave call s:autosave(<bang>1)



" ----------------------------------------------------------------------------
" LSP
" ----------------------------------------------------------------------------

let g:LanguageClient_windowLogMessageLevel = 'Error'
let g:LanguageClient_autoStart = 1
let g:LanguageClient_waitOutputTimeout = 30
let g:LanguageClient_hoverPreview = 'Always' 
let flowreadable = filereadable('./.flowconfig')

" let g:LanguageClient_serverCommands = {
"     \ 'javascript': ['javascript-typescript-stdio'],
"     \ 'javascript.jsx': ['javascript-typescript-stdio'],
"     \ }

let g:LanguageClient_serverCommands = {
      \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
      \ 'javascript': flowreadable ? ['flow-language-server', '--stdio', '--try-flow-bin'] : ['javascript-typescript-stdio', ],
      \ 'javascript.jsx': flowreadable ? ['flow-language-server', '--stdio', '--try-flow-bin'] : ['javascript-typescript-stdio', ],
      \  'go': ['go-langserver'],
      \ }



autocmd FileType javascript setlocal omnifunc=LanguageClient#complete

augroup LanguageClientConfig
  autocmd!
  " <leader>ld to go to definition
  autocmd FileType javascript,python,typescript,json,css,less,html,reason nnoremap <buffer> <leader>ld :call LanguageClient_textDocument_definition()<cr>
  " <leader>lf to autoformat document
  autocmd FileType javascript,python,typescript,json,css,less,html,reason nnoremap <buffer> <leader>lf :call LanguageClient_textDocument_formatting()<cr>
  " <leader>lh for type info under cursor
  autocmd FileType javascript,python,typescript,json,css,less,html,reason nnoremap <buffer> <leader>lh :call LanguageClient_textDocument_hover()<cr>
  " <leader>lr to rename variable under cursor
  autocmd FileType javascript,python,typescript,json,css,less,html,reason nnoremap <buffer> <leader>lr :call LanguageClient_textDocument_rename()<cr>
  " <leader>lc to switch omnifunc to LanguageClient
  autocmd FileType javascript,python,typescript,json,css,less,html,reason nnoremap <buffer> <leader>lc :setlocal omnifunc=LanguageClient#complete<cr>
  " <leader>ls to fuzzy find the symbols in the current document
  autocmd FileType javascript,python,typescript,json,css,less,html,reason nnoremap <buffer> <leader>ls :call LanguageClient_textDocument_documentSymbol()<cr>

  " Use as omnifunc by default
  autocmd FileType javascript,python,typescript,json,css,less,html,reason setlocal omnifunc=LanguageClient#complete
augroup END





" ----------------------------------------------------------------------------
" vim-go
" ----------------------------------------------------------------------------
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "goimports"
let g:go_fmt_options = {
  \ 'goimports': '-local do/',
  \ }


if exists('g:loaded_polyglot')
    let g:polyglot_disabled = ['go']
endif

augroup go
  autocmd!
    autocmd FileType go nmap <leader>b  <Plug>(go-build)
    autocmd FileType go nmap <leader>r  <Plug>(go-run)
augroup END
" ----------------------------------------------------------------------------
" startify
" ----------------------------------------------------------------------------

nnoremap <leader>st :Startify<cr>
let g:startify_lists = [
      \ { 'header': ['   MRU'],            'type': 'files' },
      \ { 'header': ['   MRU '. getcwd()], 'type': 'dir' },
      \ { 'header': ['   Sessions'],       'type': 'sessions' },
      \ ]

let g:startify_custom_header       = 'map(startify#fortune#boxed(), "\"   \".v:val")'
let g:startify_fortune_use_unicode = 1



" ----------------------------------------------------------------------------
" vim-dirvish (file explorer)
" ----------------------------------------------------------------------------
" Relative line numbers in a Dirvish buffer
autocmd! FileType dirvish setlocal relativenumber


" ----------------------------------------------------------------------------
" Lightline (statusbar)
" ----------------------------------------------------------------------------

let g:lightline = {
      \   'colorscheme': 'base16_snazzy',
      \   'active': {
      \     'left': [ [ 'mode' ], [ 'gitbranch' ], [ 'pwd' ] ],
      \     'right': [ [ 'linter_ok', 'linter_checking', 'linter_errors', 'linter_warnings', 'trailing', 'lineinfo' ], [ 'fileinfo' ] ],
      \   },
      \   'inactive': {
      \     'left': [ [ 'pwd' ], [ 'gitbranch' ] ],
      \     'right': [ [ 'lineinfo' ], [ 'fileinfo' ] ],
      \   },
      \   'tabline': {
      \     'left': [ [ 'buffers' ] ],
      \     'right': [ [ 'close' ] ],
      \   },
      \   'separator': { 'left': '', 'right': '' },
      \   'subseparator': { 'left': '', 'right': '' },
      \   'mode_map': {
      \     'n' : 'N',
      \     'i' : 'I',
      \     'R' : 'R',
      \     'v' : 'V',
      \     'V' : 'V-LINE',
      \     "\<C-v>": 'V-BLOCK',
      \     'c' : 'C',
      \     's' : 'S',
      \     'S' : 'S-LINE',
      \     "\<C-s>": 'S-BLOCK',
      \     't': '󰀣 ',
      \   },
      \   'component': {
      \     'lineinfo': '%l:%-v',
      \   },
      \   'component_expand': {
      \     'buffers': 'lightline#bufferline#buffers',
      \     'trailing': 'lightline#trailing_whitespace#component',
      \     'linter_ok': 'lightline#ale#ok',
      \     'linter_checking': 'lightline#ale#checking',
      \     'linter_warnings': 'lightline#ale#warnings',
      \     'linter_errors': 'lightline#ale#errors',
      \   },
      \   'component_function': {
      \     'pwd': 'LightlineWorkingDirectory',
      \     'fileinfo': 'LightlineFileinfo',
      \     'gitbranch': 'fugitive#head',
      \   },
      \   'component_type': {
      \     'buffers': 'tabsel',
      \     'trailing': 'error',
      \     'linter_ok': 'left',
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \   },
      \ }

function! LightlineFileinfo()
  if winwidth(0) < 90
    return ''
  endif

  let encoding = &fenc !=# "" ? &fenc : &enc
  let format = &ff
  let type = &ft !=# "" ? &ft : "no ft"
  return type . ' | ' . format . ' | ' . encoding
endfunction

function! LightlineWorkingDirectory()
  return &ft =~ 'help\|qf' ? '' : fnamemodify(getcwd(), ":~:.")
endfunction

function! s:get_buffer_name(i)
  let l:name = fnamemodify(bufname(a:i), s:filename_modifier)
  if
endfunction



" Lightline ALE (https://github.com/maximbaz/lightline-ale)
let g:lightline#ale#indicator_warnings = ' '
let g:lightline#ale#indicator_errors = ' '
let g:lightline#ale#indicator_checking = ' '
let g:lightline#ale#indicator_ok = "✓"


"lightline-bufferline

" Show devicons
let g:lightline#bufferline#enable_devicons = 1
" Show filename relative to current directory
let g:lightline#bufferline#filename_modifier = ':~:.'
" Use fancy unicode symbols for various indicators
let g:lightline#bufferline#unicode_symbols = 1
" Default name when no buffer is opened
let g:lightline#bufferline#unnamed = '[No Name]'
" Don't compress ~/my/folder/name to ~/m/f/n
let g:lightline#bufferline#shorten_path = 1
"Lightline trailing whitespace
let g:lightline#trailing_whitespace#indicator = '•'

let g:lightline#bufferline#show_number = 2

nmap <Leader>1 <Plug>lightline#bufferline#go(1)
nmap <Leader>2 <Plug>lightline#bufferline#go(2)
nmap <Leader>3 <Plug>lightline#bufferline#go(3)
nmap <Leader>4 <Plug>lightline#bufferline#go(4)
nmap <Leader>5 <Plug>lightline#bufferline#go(5)
nmap <Leader>6 <Plug>lightline#bufferline#go(6)
nmap <Leader>7 <Plug>lightline#bufferline#go(7)
nmap <Leader>8 <Plug>lightline#bufferline#go(8)
nmap <Leader>9 <Plug>lightline#bufferline#go(9)
nmap <Leader>0 <Plug>lightline#bufferline#go(10)


" remap arrow keys
nnoremap <Left> :bprev<CR>
nnoremap <Right> :bnext<CR>


" Update and show lightline but only if it's visible (e.g., not in Goyo)
autocmd User ALELint call s:MaybeUpdateLightline()

function! s:MaybeUpdateLightline()
  if exists('#lightline')
    call lightline#update()
  end
endfunction


" ----------------------------------------------------------------------------
" vim-fugitive
" ----------------------------------------------------------------------------
nmap     <Leader>g :Gstatus<CR>gg<c-n>
nnoremap <Leader>d :Gdiff<CR>

" ----------------------------------------------------------------------------
" vim-commentary
" ----------------------------------------------------------------------------
map  gc  <Plug>Commentary
nmap gcc <Plug>CommentaryLine


" ----------------------------------------------------------------------------
" ale
" ----------------------------------------------------------------------------
nmap <leader>p <Plug>(ale_fix)

let g:ale_linters = {
\   'javascript': ['eslint', 'flow'],
\   'html': ['htmlhint', 'tidy'],
\   'json': ['jsonlint'],
\   'go': ['gometalinter', 'gofmt'],
\ }

let g:ale_fixers = {
\   'javascript': ['prettier','eslint'],
\   'javascript.jsx': ['prettier', 'eslint'],
\   'go': ['gofmt'],
\ }

let g:ale_javascript_prettier_use_local_config = 1
let g:ale_javascript_eslint_use_global = 1
let g:ale_javascript_eslint_executable = 'eslint_d'
let g:ale_javascript_prettier_use_global = 1
let g:ale_javascript_prettier_executable = 'prettier_d'

let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'

hi link ALEErrorSign    Error
hi link ALEWarningSign  Warning
hi Error   cterm=bold gui=bold
hi Warning cterm=bold gui=bold

" See https://github.com/w0rp/ale/issues/249
" for more info on customising the colors.




"highlight ALEErrorSign ctermfg=9 ctermbg=15 guifg=#C30500 guibg=#F5F5F5
"highlight ALEWarningSign ctermfg=11 ctermbg=15 guifg=#ED6237 guibg=#F5F5F5

" ----------------------------------------------------------------------------
" ygg indent-lines
" ----------------------------------------------------------------------------
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#616161'
let g:indentLine_char = '|'
autocmd! User indentLine doautocmd indentLine Syntax

" ----------------------------------------------------------------------------
" auto-pairs
" ----------------------------------------------------------------------------
"let g:AutoPairsShortcutBackInsert = '<M-b>'

" ----------------------------------------------------------------------------
" Deoplete
" ----------------------------------------------------------------------------
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#sources = {}

"<TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

"<S-TAB>: completion back.
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"<C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"

" Close preview menu when finished
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Plugin key-mappings
" Control k to expand snippet
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)


" Deoplete Rust
let g:deoplete#sources#rust#racer_binary='$HOME/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path='$HOME/rust_test/rust/src'


let g:deoplete#sources#rust#show_duplicates=1

" ----------------------------------------------------------------------------
" <Enter> | vim-easy-align
" ----------------------------------------------------------------------------
let g:easy_align_delimiters = {
\ '>': { 'pattern': '>>\|=>\|>' },
\ '\': { 'pattern': '\\' },
\ '/': { 'pattern': '//\+\|/\*\|\*/', 'delimiter_align': 'l', 'ignore_groups': ['!Comment'] },
\ ']': {
\     'pattern':       '\]\zs',
\     'left_margin':   0,
\     'right_margin':  1,
\     'stick_to_left': 0
\   },
\ ')': {
\     'pattern':       ')\zs',
\     'left_margin':   0,
\     'right_margin':  1,
\     'stick_to_left': 0
\   },
\ 'f': {
\     'pattern': ' \(\S\+(\)\@=',
\     'left_margin': 0,
\     'right_margin': 0
\   },
\ 'd': {
\     'pattern': ' \ze\S\+\s*[;=]',
\     'left_margin': 0,
\     'right_margin': 0
\   }
\ }

" Start interactive EasyAlign in visual mode
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign with a Vim movement
nmap ga <Plug>(EasyAlign)
nmap gaa ga


" }}}
" ============================================================================
" FZF {{{
" ============================================================================

let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'


" Hide statusline of terminal buffer
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header': ['fg', 'Comment'] }


command! -bang -nargs=? -complete=dir Files
\ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

nnoremap <silent> <Leader>C        :Colors<CR>
nnoremap <silent> <Leader><Enter>  :Buffers<CR>
nnoremap <silent> <Leader>l        :Lines<CR>
nnoremap <silent> <Leader>ag       :Rg <C-R><C-W><CR>
nnoremap <silent> <Leader>AG       :Rg <C-R><C-A><CR>
xnoremap <silent> <Leader>ag       y:Ag <C-R>"<CR>
nnoremap <silent> <Leader>`        :Marks<CR>
nnoremap <silent> <Leader>f        :Files<CR>

inoremap <expr> <c-x><c-t> fzf#complete('tmuxwords.rb --all-but-current --scroll 500 --min 5')
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
inoremap <expr> <c-x><c-d> fzf#vim#complete#path('blsd')
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

function! s:plug_help_sink(line)
  let dir = g:plugs[a:line].dir
  for pat in ['doc/*.txt', 'README.md']
    let match = get(split(globpath(dir, pat), "\n"), 0, '')
    if len(match)
      execute 'tabedit' match
      return
    endif
  endfor
  tabnew
  execute 'Explore' dir
endfunction

command! PlugHelp call fzf#run(fzf#wrap({
  \ 'source': sort(keys(g:plugs)),
  \ 'sink': function('s:plug_help_sink')}))



" }}}
" ============================================================================
" Python Location{{{
" ============================================================================

" Python Path
" https://github.com/zchee/deoplete-jedi/wiki/Setting-up-Python-for-Neovim#using-virtual-environments
let g:python_host_prog  = '/usr/local/bin/python2'
let g:python3_host_prog = '/usr/local/bin/python3'
" }}}
" ============================================================================

