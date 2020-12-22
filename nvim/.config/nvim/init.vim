" vim: set foldmethod=marker foldlevel=0 nomodeline:
" ============================================================================
" Jon's .vimrc {{{
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
set hlsearch
set incsearch
set hidden
set ignorecase smartcase
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
set completeopt=menuone,preview
set nocursorline
set nrformats=hex
set title
set showtabline=2
set shortmess=aIT
set signcolumn=yes
set updatetime=100
set noswapfile
set nobackup
set modelines=2


" 80 chars/line
set textwidth=80
if exists('&colorcolumn')
  set colorcolumn=80
endif

set synmaxcol=1000

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" set complete=.,w,b,u,t
set complete-=i

" Keep the cursor on the same column
set nostartofline

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

" Disable CTRL-A on tmux & screen
if $TERM =~ 'screen'
  nnoremap <C-a> <nop>
  nnoremap <Leader><C-a> <C-a>
endif

" Save
nnoremap <C-s>     :update<cr>
nnoremap <leader>s :update<cr>
nnoremap <leader>w :update<cr>

" Quit
nnoremap <C-Q>     :q<cr>
vnoremap <C-Q>     <esc>
nnoremap <Leader>q :q<cr>
nnoremap <Leader>Q :qa!<cr>

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright


" Movement in insert mode
inoremap <C-h> <C-o>h
inoremap <C-l> <C-o>a
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-^> <C-o><C-^>

" ----------------------------------------------------------------------------
" Buffers
" ----------------------------------------------------------------------------
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

" ----------------------------------------------------------------------------
" Tabs
" ----------------------------------------------------------------------------
nnoremap ]t :tabn<cr>
nnoremap [t :tabp<cr>


" }}}
" ============================================================================
" VIM-PLUG BLOCK {{{
" ============================================================================

call plug#begin('~/.config/nvim/plugged')


" ----------------------------------------------------------------------------
" Colorscheme & Syntax Highlighting & Linting
" ----------------------------------------------------------------------------
Plug 'Yggdroot/indentLine',           { 'on': 'IndentLinesEnable' }
Plug 'jonleopard/base16-vim'
Plug 'sheerun/vim-polyglot'

" ----------------------------------------------------------------------------
" Git
" ----------------------------------------------------------------------------
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'mhinz/vim-signify'

" ----------------------------------------------------------------------------
" Tmux
" ----------------------------------------------------------------------------
Plug 'tmux-plugins/vim-tmux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux-focus-events'

"----------------------------------------------------------------------------
" Autocompletion & Snippets
" ----------------------------------------------------------------------------
Plug 'neoclide/coc.nvim',           {'branch': 'release'}
"Plug 'antoinemadec/coc-fzf'
Plug 'honza/vim-snippets'
"Plug 'Shougo/deoppet.nvim'
" Plug 'Shougo/neosnippet.vim'
" Plug 'Shougo/neosnippet-snippets'
" Plug 'sdras/vue-vscode-snippets' 

" ----------------------------------------------------------------------------
" Editing
" ----------------------------------------------------------------------------
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-commentary',         { 'on': '<Plug>Commentary' }
Plug 'wellle/targets.vim'
Plug 'junegunn/vim-easy-align',      { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'plasticboy/vim-markdown'
Plug 'jiangmiao/auto-pairs'
Plug 'andymass/vim-matchup'

" ----------------------------------------------------------------------------
" Searching/Navigating
" ----------------------------------------------------------------------------
Plug 'junegunn/fzf',                  { 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-dirvish'
Plug 'justinmk/vim-gtfo'

" ----------------------------------------------------------------------------
" Utils
" ----------------------------------------------------------------------------
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-obsession'
Plug 'mbbill/undotree',               { 'on': 'UndotreeToggle' }

Plug 'itchyny/lightline.vim'
Plug 'jonleopard/base16-vim-lightline'
Plug 'mengelbrecht/lightline-bufferline'

Plug 'airblade/vim-rooter'
Plug 'mhinz/vim-startify'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/vim-emoji'
Plug 'metakirby5/codi.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'editorconfig/editorconfig-vim'
Plug 'iamcco/markdown-preview.nvim',  { 'do': 'cd app & npm install'  }
Plug 'janko-m/vim-test'

call plug#end()
" }}}
" ============================================================================
" COLOR SETTINGS {{{
" ============================================================================


if has('termguicolors')
  set termguicolors
  execute "set t_8f=\e[38;2;%lu;%lu;%lum"
  execute "set t_8b=\e[48;2;%lu;%lu;%lum"
endif

" base16-vim will match whatever you have set your shell color scheme as
if filereadable(expand("~/.vimrc_background"))
  source ~/.vimrc_background
endif

" shelfing until https://github.com/base16-manager/base16-manager/issues/72 is
" fixed
"if filereadable(expand("~/.config/nvim/colorscheme.vim"))
"  "let base16colorspace=256
"  source ~/.config/nvim/colorscheme.vim
"endif
" }}}
" ============================================================================
" PLUGIN SETTINGS{{{
" ============================================================================

" ----------------------------------------------------------------------------
" vim-signify
" ----------------------------------------------------------------------------
let g:signify_vcs_list = ['git']

" omap ic <plug>(signify-motion-inner-pending)
" xmap ic <plug>(signify-motion-inner-visual)
" omap ac <plug>(signify-motion-outer-pending)
" xmap ac <plug>(signify-motion-outer-visual)
" nnoremap <silent><leader>p :SignifyHunkDiff<cr>
" nnoremap <silent><leader>u :SignifyHunkUndo<cr>
" autocmd User SignifyAutocmds autocmd! signify CursorHold,CursorHoldI

" ----------------------------------------------------------------------------
" coc
" ----------------------------------------------------------------------------

let g:coc_global_extensions = [
  \ 'coc-docker',
  \ 'coc-tailwindcss',
  \ 'coc-prettier',
  \ 'coc-snippets',
  \ 'coc-git',
  \ 'coc-eslint',
  \ 'coc-emmet',
  \ 'coc-yaml',
  \ 'coc-vimlsp',
  \ 'coc-vetur',
  \ 'coc-tsserver',
  \ 'coc-rls',
  \ 'coc-phpls',
  \ 'coc-json',
  \ 'coc-html',
  \ 'coc-go',
  \ 'coc-css',
  \ ]


highlight link CocErrorSign GitGutterDelete
highlight link CocWarningSign GitGutterChangeDelete
highlight link CocInfoSign GitGutterChange
highlight link CocHintSign GitGutterAdd

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 
" NEOSNIPPET + COC CONFIG
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has_key(g:plugs, 'coc.nvim')
 
  " <TAB> - trigger completion, pum navigate, snippet expand and jump like VSCode
  inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  let g:coc_snippet_next = '<tab>'
  let g:coc_snippet_prev = '<s-tab>'

  " <C-space> - trigger completion
  inoremap <silent><expr> <c-space> coc#refresh()

  " <CR> - select the first completion item and confirm the completion when no item has been selected
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  " Use `[g` and `]g` to navigate diagnostics
  " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)
   

  " GoTo code navigation.
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Use K for show documentation in preview window
  nnoremap <silent> K :call <SID>show_documentation()<CR>


  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute '!' . &keywordprg . " " . expand('<cword>')
    endif
  endfunction

  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Symbol renaming.
  nmap <leader>rn <Plug>(coc-rename)

  " Formatting selected code.
  vmap <leader>p  <Plug>(coc-format-selected)
  nmap <leader>p  <Plug>(coc-format-selected)

  augroup coc-config
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json,php,html,blade setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    " remove extra $ for coc autocomplete
    autocmd BufNewFile,BufRead *.php set iskeyword+=$
    " Add missing imports on save (similar to the vim-go experience)
    autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
  augroup end

  " Applying codeAction to the selected region.
  " Example: `<leader>aap` for current paragraph
  xmap <leader>a  <Plug>(coc-codeaction-selected)
  nmap <leader>a  <Plug>(coc-codeaction-selected)

  " Remap keys for applying codeAction to the current buffer.
  nmap <leader>ac  <Plug>(coc-codeaction)
  " Apply AutoFix to problem on the current line.
  nmap <leader>qf  <Plug>(coc-fix-current)

  " Remap <C-f> and <C-b> for scroll float windows/popups.
  " Note coc#float#scroll works on neovim >= 0.4.3 or vim >= 8.2.0750
  nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

  " NeoVim-only mapping for visual mode scroll
  " Useful on signatureHelp after jump placeholder of snippet expansion
  if has('nvim')
    vnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#nvim_scroll(1, 1) : "\<C-f>"
    vnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#nvim_scroll(0, 1) : "\<C-b>"
  endif

  " use `:OR` for organize import of current buffer
  command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')


  " let g:coc_filetype_map = {
  "   \ 'blade': 'html',
  "   \ 'vue': 'html',
  "   \ }
endif

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
" startify
" ----------------------------------------------------------------------------

nnoremap <leader>st :Startify<cr>

let g:startify_lists = [
      \ { 'header': ['   MRU'],            'type': 'files' },
      \ { 'header': ['   MRU '. getcwd()], 'type': 'dir' },
      \ { 'header': ['   Sessions'],       'type': 'sessions' },
      \ ]

let g:startify_change_to_dir       = 0
let g:startify_custom_header       = 'startify#pad(startify#fortune#boxed())'
let g:startify_enable_special      = 0
let g:startify_fortune_use_unicode = 1
let g:startify_update_oldfiles     = 1
let g:startify_use_env             = 1

" ----------------------------------------------------------------------------
" vim-dirvish (file explorer)
" ----------------------------------------------------------------------------
" Relative line numbers in a Dirvish buffer
autocmd! FileType dirvish setlocal relativenumber


" ----------------------------------------------------------------------------
" Lightline (statusbar)
" ----------------------------------------------------------------------------

let g:lightline = {
      \   'active': {
      \     'left': [ ['mode','paste'], [ 'gitbranch' ], [ 'pwd' ] ],
      \     'right': [ [ 'cocstatus', 'readonly', 'filename' ], [ 'fileinfo' ] ]
      \   },
      \   'inactive': {
      \     'left': [ [ 'pwd' ], [ 'gitbranch' ] ],
      \     'right': [ [ 'lineinfo' ], [ 'fileinfo' ] ]
      \   },
      \   'tabline': {
      \     'left': [ [ 'buffers' ] ],
      \     'right': [ [] ]
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
      \   },
      \   'component_function': {
      \     'pwd': 'LightlineWorkingDirectory',
      \     'fileinfo': 'LightlineFileinfo',
      \     'gitbranch': 'fugitive#head',
      \     'cocstatus': 'coc#status',
      \   },
      \   'component_type': {
      \     'buffers': 'tabsel',
      \   },
      \ }


" Match base16 color
let base16theme = $BASE16_THEME
try
    execute "colorscheme ".base16theme
    let csunderscores = substitute(base16theme, '-', '_', 'g')
catch
    execute "colorscheme base16-".base16theme
    let csunderscores = "base16_".substitute(base16theme, '-', '_', 'g')
endtry
let g:lightline.colorscheme = csunderscores

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

"Lightline coc-integration
let g:cocstatus#indicator_warnings = ' '
let g:cocstatus#indicator_errors = ' '
let g:cocstatus#indicator_checking = ' '
let g:cocstatus#indicator_ok = "✓"


"lightline-bufferline
let g:lightline#bufferline#unicode_symbols = 1
" Show devicons
let g:lightline#bufferline#enable_devicons = 1
" Don't show path
let g:lightline#bufferline#filename_modifier = ':t'

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


" ----------------------------------------------------------------------------
" vim-fugitive
" ----------------------------------------------------------------------------
" nmap     <Leader>g :Gstatus<CR>gg<c-n>
" nnoremap <Leader>d :Gdiff<CR>

nmap <Leader>gb :Gblame<cr>
nmap <Leader>gs :Gstatus<cr>
nmap <Leader>gc :Gcommit -v<cr>
nmap <Leader>ga :Git add -p<cr>
nmap <Leader>gm :Gcommit --amend<cr>
nmap <Leader>gp :Gpush<cr>
nmap <Leader>gd :Gdiff<cr>
nmap <Leader>gw :Gwrite<cr>

autocmd BufReadPost fugitive:// setlocal bufhidden=delete

" ----------------------------------------------------------------------------
" vim-commentary
" ----------------------------------------------------------------------------
map  gc  <Plug>Commentary
nmap gcc <Plug>CommentaryLine

" ----------------------------------------------------------------------------
" indent-lines
" ----------------------------------------------------------------------------
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#616161'
let g:indentLine_char = '|'
autocmd! User indentLine doautocmd indentLine Syntax

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

xmap <Leader>ga <Plug>(LiveEasyAlign)

" }}}
" ============================================================================
" FZF {{{
" ============================================================================
if has('nvim') || has('gui_running')
  let $FZF_DEFAULT_OPTS .= ' --inline-info'
endif

" Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" RG
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" All files
command! -nargs=? -complete=dir AF
  \ call fzf#run(fzf#wrap(fzf#vim#with_preview({
  \   'source': 'fd --type f --hidden --follow --exclude .git --no-ignore . '.expand(<q-args>)
  \ })))

" ripgrep
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

" Files + devicons
function! Fzf_dev()
  let l:fzf_files_options = '--preview "bat --style=numbers,changes --color always {2..-1} | head -'.&lines.'"'

  function! s:files()
    let l:files = split(system($FZF_DEFAULT_COMMAND), '\n')
    return s:prepend_icon(l:files)
  endfunction

  function! s:prepend_icon(candidates)
    let l:result = []
    for l:candidate in a:candidates
      let l:filename = fnamemodify(l:candidate, ':p:t')
      let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
      call add(l:result, printf('%s %s', l:icon, l:candidate))
    endfor

    return l:result
  endfunction

  function! s:edit_file(item)
    let l:pos = stridx(a:item, ' ')
    let l:file_path = a:item[pos+1:-1]
    execute 'silent e' l:file_path
  endfunction

  call fzf#run({
        \ 'source': <sid>files(),
        \ 'sink':   function('s:edit_file'),
        \ 'options': '-m ' . l:fzf_files_options,
        \ 'down':    '40%' })
endfunction



" Global line completion (not just open buffers. ripgrep required.)
inoremap <expr> <c-x><c-l> fzf#vim#complete(fzf#wrap({
  \ 'prefix': '^.*$',
  \ 'source': 'rg -n ^ --color always',
  \ 'options': '--ansi --delimiter : --nth 3..',
  \ 'reducer': { lines -> join(split(lines[0], ':\zs')[2:], '') }}))

" Advanced customization using Vim function
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

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


" Terminal buffer options for fzf
autocmd! FileType fzf
autocmd  FileType fzf set noshowmode noruler nonu

"Floating window
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } } 

"File w/ previews
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang ProjectFiles call fzf#vim#files('~/projects', <bang>0)

nnoremap <silent> <Leader>C        :Colors<CR>
nnoremap <silent> <Leader><Enter>  :Buffers<CR>
nnoremap <silent> <Leader>l        :Lines<CR>
nnoremap <silent> <Leader>rg       :Rg <C-R><C-W><CR>
nnoremap <silent> <Leader>RG       :Rg <C-R><C-A><CR>
xnoremap <silent> <Leader>rg       y:Ag <C-R>"<CR>
nnoremap <silent> <Leader>`        :Marks<CR>
nnoremap <silent> <Leader>f        :Files<CR>
nnoremap <silent> <Leader>F        :call Fzf_dev()<CR>
nnoremap <silent> <Leader>b        :Buffers<CR>
nnoremap <silent> <Leader>gf       :Gfiles<CR>
nnoremap <silent> <Leader>gc       :Commits<CR>
nnoremap <silent> <Leader>cc       :Commands<CR>
nnoremap <silent> <Leader>mm       :Maps<CR>
nnoremap <silent> <Leader>h        :History<CR>


" Insert  Mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Mapping selecting mappings
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
  \ 'sink':   function('s:plug_help_sink')}))

let g:fzf_commits_log_options = '--graph --color=always
  \ --format="%C(yellow)%h%C(red)%d%C(reset)
  \ - %C(bold green)(%ar)%C(reset) %s %C(blue)<%an>%C(reset)"'

" }}}
" ============================================================================
" AUTOCMD {{{
" ============================================================================

augroup vimrc 
  au BufWritePost vimrc,.vimrc nested if expand('%') !~ 'fugitive' | source % | endif

  " File Types
  au BufRead,BufNewFile *.gohtml            set filetype=html
  au BufRead,BufNewFile *.blade.php         set filetype=html
  "au BufRead,BufNewFile *.vue setfiletype html
 
  " http://vim.wikia.com/wiki/Highlight_unwanted_spaces
  au BufNewFile,BufRead,InsertLeave * silent! match ExtraWhitespace /\s\+$/
  au InsertEnter * silent! match ExtraWhitespace /\s\+\%#\@<!$/

  " Close preview window
  if exists('##CompleteDone')
    au CompleteDone * pclose
  else
    au InsertLeave * if !pumvisible() && (!exists('*getcmdwintype') || empty(getcmdwintype())) | pclose | endif
  endif

" }}}
