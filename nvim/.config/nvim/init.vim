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
set autoread
set smartindent
set lazyredraw
set laststatus=2
set showcmd
set noshowmode
set visualbell
set backspace=indent,eol,start
set timeoutlen=500
set whichwrap=b,s
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
set nocursorcolumn
set nrformats=hex
set title
set showtabline=2
set shortmess=aIT
set signcolumn=yes
set cmdheight=2
set updatetime=100
set noswapfile
set nobackup

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

"Make sure vim-plug is installed first
" if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
"   silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
"     \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"   autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
" endif



call plug#begin('~/.config/nvim/plugged')

" ----------------------------------------------------------------------------
" Javascript
" ----------------------------------------------------------------------------
Plug 'othree/jspc.vim',               { 'for': ['javascript', 'javascript.jsx'] }
Plug 'digitaltoad/vim-pug'


" ----------------------------------------------------------------------------
" Go
" ----------------------------------------------------------------------------
Plug 'fatih/vim-go',                  { 'do': ':GoUpdateBinaries' }

" ----------------------------------------------------------------------------
" Rust
" ----------------------------------------------------------------------------
Plug 'racer-rust/vim-racer'

" ----------------------------------------------------------------------------
" Colorscheme & Syntax Highlighting & Linting
" ----------------------------------------------------------------------------
Plug 'Yggdroot/indentLine', { 'on': 'IndentLinesEnable' }
Plug 'jonleopard/base16-vim'
Plug 'sheerun/vim-polyglot'
Plug 'hail2u/vim-css3-syntax'
Plug 'ap/vim-css-color'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'jparise/vim-graphql'
Plug 'elzr/vim-json'
Plug 'RRethy/vim-illuminate'


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
Plug 'Shougo/echodoc.vim'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}

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
Plug 'kristijanhusak/vim-dirvish-git'
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
"Plug 'roman/golden-ratio'

Plug 'itchyny/lightline.vim'
Plug 'jonleopard/base16-vim-lightline'
Plug 'maximbaz/lightline-trailing-whitespace'
Plug 'mengelbrecht/lightline-bufferline'

Plug 'mhinz/vim-startify'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/vim-emoji'
Plug 'metakirby5/codi.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'sgur/vim-editorconfig'
Plug 'iamcco/markdown-preview.vim'
"Plug 'TaDaa/vimade'
Plug 'janko-m/vim-test'

call plug#end()
" }}}
" ============================================================================
" COLOR SETTINGS {{{
" ============================================================================


let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

if !has('gui_running')
  set t_Co=256
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
" coc
" ----------------------------------------------------------------------------
" TODO: Need to get bas16 to work with these

highlight link CocErrorSign GitGutterDelete
highlight link CocWarningSign GitGutterChangeDelete
highlight link CocInfoSign GitGutterChange
highlight link CocHintSign GitGutterAdd

" use <tab> for trigger completion and navigate to next complete item
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()


" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)


" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
vmap <leader>p  <Plug>(coc-format-selected)
nmap <leader>p  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json,php,html setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

let g:coc_filetype_map = {
  \ 'blade': 'html',
  \ }


" ----------------------------------------------------------------------------
" vim-test
" ----------------------------------------------------------------------------
nnoremap <silent> <Leader>tN       :TestNearest<CR>
nnoremap <silent> <Leader>tF       :TestFile<CR>
nnoremap <silent> <Leader>tS       :TestSuite<CR>
nnoremap <silent> <Leader>tL       :TestLast<CR>
nnoremap <silent> <Leader>tG       :TestVisit<CR>

" make test commands execute using dispatch.vim
" let test#strategy = {
"   \ 'nearest': 'neovim',
"   \ 'suite':   'basic',
" \}
let test#php#phpunit#executable = '../../vendor/bin/phpunit --configuration /Users/jon/projects/php-learning/myproject/phpunit.xml'

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
  set undofile
  set undodir=~/.config/nvim/undodir
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
      \     'right': [ [ 'cocstatus', 'trailing', 'lineinfo' ], [ 'fileinfo' ] ],
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
      \   },
      \   'component_function': {
      \     'pwd': 'LightlineWorkingDirectory',
      \     'fileinfo': 'LightlineFileinfo',
      \     'gitbranch': 'fugitive#head',
      \     'cocstatus': 'coc#status',
      \   },
      \   'component_type': {
      \     'buffers': 'tabsel',
      \     'trailing': 'error',
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

"Lightline trailing whitespace
let g:lightline#trailing_whitespace#indicator = '•'

let g:cocstatus#indicator_warnings = ' '
let g:cocstatus#indicator_errors = ' '
let g:cocstatus#indicator_checking = ' '
let g:cocstatus#indicator_ok = "✓"


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

"let g:lightline#bufferline#show_number = 2

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

" Customize fzf colors to match your color scheme
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
  \ 'header':  ['fg', 'Comment'] }

" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" nnoremap <silent> <expr> <Leader><Leader> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
nnoremap <silent> <Leader>C        :Colors<CR>
nnoremap <silent> <Leader><Enter>  :Buffers<CR>
nnoremap <silent> <Leader>l        :Lines<CR>
nnoremap <silent> <Leader>rg       :Rg <C-R><C-W><CR>
nnoremap <silent> <Leader>RG       :Rg <C-R><C-A><CR>
xnoremap <silent> <Leader>rg       y:Ag <C-R>"<CR>
nnoremap <silent> <Leader>`        :Marks<CR>
nnoremap <silent> <Leader>f        :Files<CR>
nnoremap <silent> <Leader>b        :Buffers<CR>
nnoremap <silent> <Leader>gf       :Gfiles<CR>
nnoremap <silent> <Leader>gc       :Commits<CR>
nnoremap <silent> <Leader>cc       :Commands<CR>
nnoremap <silent> <Leader>mm       :Maps<CR>
nnoremap <silent> <Leader>h        :History<CR>


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
" AUTOCMD {{{
" ============================================================================

augroup vimrc 
" Automatic rename of tmux window
  if exists('$TMUX') && !exists('$NORENAME')
    au BufEnter * if empty(&buftype) | call system('tmux rename-window '.expand('%:t:S')) | endif
    au VimLeave * call system('tmux set-window automatic-rename on')
  endif
augroup END

" }}}
" ============================================================================
