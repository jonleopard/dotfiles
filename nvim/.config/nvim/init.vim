" vim: set foldmethod=marker foldlevel=0:
" ============================================================================
" Jon Leopard's .vimrc {{{
" ============================================================================

" }}}
" ============================================================================
" BASIC SETTINGS {{{
" ============================================================================
let mapleader = ' '                       " Map  <leader> key to space
let maplocalleader = ' '                  " Map local leader to space
set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.
set showmode            " Show current mode.
set ruler               " Show the line and column numbers of the cursor.
set number              " Show the line numbers on the left side.
set formatoptions+=o    " Continue comment marker in new lines.
set textwidth=0         " Hard-wrap long lines as you type them.
set expandtab           " Insert spaces when TAB is pressed.
set tabstop=2           " Render TABs using this many spaces.
set shiftwidth=2        " Indentation amount for < and > commands.

set noerrorbells        " No beeps.
set modeline            " Enable modeline.
set linespace=0         " Set line-spacing to minimum.
set nojoinspaces        " Prevents inserting two spaces after punctuation on a join (J)

let g:netrw_localrmdir='rm -r'            " Allow deletion of a dir that isn't empty
let g:netrw_banner=0                      " Dont show the banner

" Keep the cursor on the same column
set nostartofline

" Annoying temporary files
set backupdir=/tmp//,.
set directory=/tmp//,.

" 80 chars/line
set textwidth=0
if exists('&colorcolumn')
  set colorcolumn=80
endif


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

noremap <C-F> <C-D>
noremap <C-B> <C-U>

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

" toggle paste in cmd only
" nnoremap <Leader>p :set invpaste<CR>


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
" Colorscheme & Syntax Highlighting
" ----------------------------------------------------------------------------
Plug 'Yggdroot/indentLine', { 'on': 'IndentLinesEnable' }
autocmd! User indentLine doautocmd indentLine Syntax
Plug 'chriskempson/base16-vim'
Plug 'sheerun/vim-polyglot'
"Plug 'hail2u/vim-css3-syntax'
"Plug 'styled-components/vim-styled-components'

" ----------------------------------------------------------------------------
" Linting
" ----------------------------------------------------------------------------
Plug 'w0rp/ale' 

" ----------------------------------------------------------------------------
" Git
" ----------------------------------------------------------------------------
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" ----------------------------------------------------------------------------
" Tmux
" ----------------------------------------------------------------------------
Plug 'christoomey/vim-tmux-navigator'

" ----------------------------------------------------------------------------
" Autocompletion & Snippets
" ----------------------------------------------------------------------------
Plug 'Shougo/deoplete.nvim',         { 'do': ':UpdateRemotePlugins' }
Plug 'honza/vim-snippets' 
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neco-vim'
Plug 'zchee/deoplete-zsh'

" ----------------------------------------------------------------------------
" Editing
" ----------------------------------------------------------------------------
Plug 'tpope/vim-surround'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-endwise'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary',         { 'on': '<Plug>Commentary' }
Plug 'junegunn/vim-easy-align',      { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'fatih/vim-hclfmt'
Plug 'plasticboy/vim-markdown'
Plug 'reasonml/vim-reason-loader'
Plug 'tpope/vim-repeat'
Plug 'jiangmiao/auto-pairs'
" ----------------------------------------------------------------------------
" Javascript
" ----------------------------------------------------------------------------
Plug 'ternjs/tern_for_vim',           { 'for': ['javascript', 'javascript.jsx'] }
Plug 'carlitux/deoplete-ternjs',      { 'for': ['javascript', 'javascript.jsx'], 'do': 'npm install -g tern' }
Plug 'othree/jspc.vim',               { 'for': ['javascript', 'javascript.jsx'] }
Plug 'digitaltoad/vim-pug'
Plug 'elzr/vim-json'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'alexlafroscia/deoplete-flow',   { 'branch': 'pass-filename-to-autocomplete' }


" ----------------------------------------------------------------------------
" Go
" ----------------------------------------------------------------------------
Plug 'fatih/vim-go',                  {'do': ':GoInstallBinaries' }

" ----------------------------------------------------------------------------
" Searching/Navigation
" ----------------------------------------------------------------------------
Plug 'junegunn/fzf',                  { 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-vinegar'
Plug 'justinmk/vim-dirvish'
Plug 'jremmen/vim-ripgrep'

" ----------------------------------------------------------------------------
" Utils
" ----------------------------------------------------------------------------
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-unimpaired'
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'itchyny/lightline.vim'
Plug 'daviesjamie/vim-base16-lightline'
Plug 'mhinz/vim-startify'
"Plug 'rizzatti/dash.vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/vim-emoji'
Plug 'metakirby5/codi.vim'
Plug 'tpope/vim-obsession'
Plug 'jeffkreeftmeijer/vim-numbertoggle'

call plug#end()
" }}}
" ============================================================================
" COLOR SETTINGS {{{
" ============================================================================
" True color
if has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif

let g:lightline = {
\   'colorscheme': 'base16'
\ }

" base16-vim will match whatever you have set your shell color scheme as
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
" }}}
" ============================================================================
" PLUGIN SETTINGS{{{
" ============================================================================


" ----------------------------------------------------------------------------
" vim-airline (statusbar)
" ----------------------------------------------------------------------------
"let g:airline_section_z = airline#section#create(['%{ObsessionStatus(''$'', '''')}', 'windowswap', '%3p%% ', 'linenr', ':%3v '])

"let g:airline_left_sep = ''
"let g:airline_right_sep = ''
"let g:airline_powerline_fonts=1




let g:airline#extensions#ale#enabled = 1
function ALE() abort
    return exists('*ALEGetStatusLine') ? ALEGetStatusLine() : ''
endfunction
let g:airline_section_error = '%{ALE()}'
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']

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
"let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1
let g:ale_echo_msg_format = '%linter% says %s'
let g:ale_fixers = {}
let g:ale_linters = {
\   'javascript': ['eslint', 'flow'],
\   'html': ['htmlhint', 'tidy'],
\   'json': ['jsonlint'],
\ }

"let g:ale_fixers = {'javascript': ['prettier', 'eslint']}
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier', 'eslint']


let g:ale_javascript_prettier_use_global = 1
let g:ale_javascript_eslint_use_global = 1
let g:ale_javascript_eslint_executable = 'eslint_d'
let g:ale_javascript_prettier_executable = 'prettier_d'
let g:ale_javascript_prettier_eslint_options = '--write --single-quote --print-width=80 --parser=flow --tab-width=2'
autocmd FileType javascript.jsx,javascript setlocal formatprg=prettier\ --stdin
"autocmd FileType javascript set formatprg=prettier-eslint\ --stdin

" ----------------------------------------------------------------------------
" indentLine
" ----------------------------------------------------------------------------
" let g:indentLine_setColors = 0



" ----------------------------------------------------------------------------
" auto-pairs
" ----------------------------------------------------------------------------
"let g:AutoPairsFlyMode = 1
let g:AutoPairsShortcutBackInsert = '<M-b>'

" ----------------------------------------------------------------------------
" Deoplete
" ----------------------------------------------------------------------------
call deoplete#enable()
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1

" Javscript Completion
let g:deoplete#sources = {}
let g:deoplete#sources['javascript.jsx'] = ['file', 'neosnippet', 'ternjs']
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']

let g:deoplete#sources#ternjs#filetypes = [
                \ 'jsx',
                \ 'javascript.jsx',
                \ 'vue',
                \ ]

let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
                \ 'tern#complete',
                \ 'jspc#omni'
                \ ]

" HTML completion
let g:deoplete#sources = {}
let g:deoplete#sources['html'] = ['file', 'neosnippet', 'vim-snippets']



" ----------------------------------------------------------------------------
" Neosnippet controls
" ----------------------------------------------------------------------------


" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif



" I want to use my tab more smarter. If we are inside a completion menu jump
" to the next item. Otherwise check if there is any snippet to expand, if yes
" expand it. Also if inside a snippet and we need to jump tab jumps. If none
" of the above matches we just call our usual 'tab'.
function! s:neosnippet_complete()
  if pumvisible()
    return "\<c-n>"
  else
    if neosnippet#expandable_or_jumpable() 
      return "\<Plug>(neosnippet_expand_or_jump)"
    endif
    return "\<tab>"
  endif
endfunction

imap <expr><TAB> <SID>neosnippet_complete()


" function! s:tab_complete()
"   " is completion menu open? cycle to next item
"   if pumvisible()
"     return "\<c-n>"
"   endif

"   " is there a snippet that can be expanded?
"   " is there a placholder inside the snippet that can be jumped to?
"   if neosnippet#expandable_or_jumpable() 
"     return "\<Plug>(neosnippet_expand_or_jump)"
"   endif

"   " if none of these match just use regular tab
"   return "\<tab>"
" endfunction

" imap <silent><expr><TAB> <SID>tab_complete()

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
nmap gaa ga_

" xmap <Leader><Enter>   <Plug>(LiveEasyAlign)
" nmap <Leader><Leader>a <Plug>(LiveEasyAlign)

" inoremap <silent> => =><Esc>mzvip:EasyAlign/=>/<CR>`z$a<Space>

" ----------------------------------------------------------------------------
" neomake
" ----------------------------------------------------------------------------
"let g:neomake_javascript_enabled_makers = ['eslint']
"let g:neomake_jsx_enabled_makers = ['eslint']
"autocmd! BufWritePost * Neomake
"let g:neomake_verbose=3
"let g:neomake_open_list = 2


" Neomake bindings
"nmap <Leader><Space>o :lopen<CR>      " open location window
"nmap <Leader><Space>c :lclose<CR>     " close location window
"nmap <Leader><Space>, :ll<CR>         " go to current error/warning
"nmap <Leader><Space>n :lnext<CR>      " next error/warning
"nmap <Leader><Space>p :lprev<CR>      " previous error/warning


" }}}
" ============================================================================
" FZF {{{
" ============================================================================

" FZF + Ripgrep

" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

nmap <C-p> :Files<cr>
  imap <c-x><c-l> <plug>(fzf-complete-line)

  let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-i': 'split',
    \ 'ctrl-s': 'vsplit' }
  let g:fzf_layout = { 'down': '~20%' }

  let g:rg_command = '
    \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
    \ -g "*.{js,json,php,md,styl,pug,jade,html,config,py,cpp,c,go,hs,rb,conf,fa,lst}"
    \ -g "!{.config,.git,node_modules,vendor,build,yarn.lock,*.sty,*.bst,*.coffee,dist}/*" '

  command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)


nnoremap <silent> <Leader>C        :Colors<CR>
nnoremap <silent> <Leader><Enter>  :Buffers<CR>
nnoremap <silent> <Leader>ag       :Rg <C-R><C-W><CR>
nnoremap <silent> <Leader>AG       :Rg <C-R><C-A><CR>
xnoremap <silent> <Leader>ag       y:Rg <C-R>"<CR>
nnoremap <silent> <Leader>`        :Marks<CR>

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


" }}}
" ============================================================================
" PYENV PATH{{{
" ============================================================================


" Pyenv Paths
" https://github.com/zchee/deoplete-jedi/wiki/Setting-up-Python-for-Neovim#using-virtual-environments
"let g:python_host_prog  = '/Users/jon/.pyenv/versions/neovim2/bin/python'
"let g:python3_host_prog = '/Users/jon/.pyenv/versions/neovim3/bin/python'


" Faster startup time
  "let g:python_host_skip_check=1            " Skip python 2 host check
  "let g:loaded_python3_provider=1           " Disable python 2 interface

" }}}
" ============================================================================
