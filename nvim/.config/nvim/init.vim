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
set nohlsearch
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
set completeopt=menuone,noinsert,noselect
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
set relativenumber


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

" mouse (for emergency situations)
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
nnoremap <leader>s :update<cr>
nnoremap <leader>w :update<cr>

" Quit
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
" Colorscheme & Syntax Highlighting
" ----------------------------------------------------------------------------
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'fnune/base16-vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

" ----------------------------------------------------------------------------
" Git
" ----------------------------------------------------------------------------
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'lewis6991/gitsigns.nvim'

"----------------------------------------------------------------------------
" LSP, Autocompletion & Snippets
" ----------------------------------------------------------------------------
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
Plug 'jose-elias-alvarez/null-ls.nvim'

" ----------------------------------------------------------------------------
" Editing
" ----------------------------------------------------------------------------
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary',         { 'on': '<Plug>Commentary' }
Plug 'wellle/targets.vim'
Plug 'junegunn/vim-easy-align',      { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'plasticboy/vim-markdown'
Plug 'jiangmiao/auto-pairs'
Plug 'andymass/vim-matchup'
Plug 'junegunn/goyo.vim'
Plug 'ray-x/lsp_signature.nvim'

" ----------------------------------------------------------------------------
" Navigation/FuzzySearch
" ----------------------------------------------------------------------------
Plug 'justinmk/vim-dirvish'
Plug 'justinmk/vim-gtfo'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" ----------------------------------------------------------------------------
" Utils
" ----------------------------------------------------------------------------
Plug 'folke/which-key.nvim'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-unimpaired'
Plug 'mbbill/undotree',               { 'on': 'UndotreeToggle' }

Plug 'itchyny/lightline.vim'
Plug 'jonleopard/base16-vim-lightline'
Plug 'mengelbrecht/lightline-bufferline'

Plug 'airblade/vim-rooter'
Plug 'mhinz/vim-startify'
Plug 'junegunn/vim-emoji'
Plug 'ryanoasis/vim-devicons'
Plug 'editorconfig/editorconfig-vim'
Plug 'iamcco/markdown-preview.nvim',  { 'do': 'cd app & npm install'  }

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
  let base16colorspace=256
endif


" }}}
" ============================================================================
" PLUGIN SETTINGS{{{
" ============================================================================

lua require('plugin-settings')

" ----------------------------------------------------------------------------
" mappings
" ----------------------------------------------------------------------------

" telescope
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>dot <cmd>lua require('plugin-settings.telescope').search_dotfiles()<cr>
nnoremap <leader>gb <cmd>lua require('telescope_builtin').git_branches()<cr>


" lsp-config
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <C-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K     <cmd>Lspsaga hover_doc<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <C-p> <cmd>Lspsaga diagnostic_jump_prev<CR>
nnoremap <silent> <C-n> <cmd>Lspsaga diagnostic_jump_next<CR>
nnoremap <silent> gf    <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> gn    <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> ga    <cmd>Lspsaga code_action<CR>
xnoremap <silent> ga    <cmd>Lspsaga range_code_action<CR>
nnoremap <silent> gs    <cmd>Lspsaga signature_help<CR>


" compe
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })



" ----------------------------------------------------------------------------
" which-key
" ----------------------------------------------------------------------------
lua require('which-key').setup()


" ----------------------------------------------------------------------------
" undotree
" ----------------------------------------------------------------------------
if !exists('g:undotree_WindowLayout')
  let g:undotree_WindowLayout = 2
endif

" if set, let undotree window get focus after being opened, otherwise
" focus will stay in current window.
if !exists('g:undotree_SetFocusWhenToggle')
    let g:undotree_SetFocusWhenToggle = 1
endif

if has("persistent_undo")
  set undofile
  set undodir=$HOME/.config/nvim/undodir
endif

" User commands.
nnoremap U :UndotreeToggle<CR>


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
      \     'right': [ [ 'readonly', 'filename' ], [ 'fileinfo' ] ]
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
      \     'gitbranch': 'FugitiveHead',
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


" ----------------------------------------------------------------------------
" vim-fugitive
" ----------------------------------------------------------------------------
" nmap     <Leader>g :Gstatus<CR>gg<c-n>
" nnoremap <Leader>d :Gdiff<CR>

nmap <Leader>gb :Gblame<cr>
nmap <Leader>gs :Gstatus<cr>
nmap <Leader>gc :Git commit -v<cr>
nmap <Leader>ga :Git add -p<cr>
nmap <Leader>gm :Git commit --amend<cr>
nmap <Leader>gp :Gpush<cr>
nmap <Leader>gd :Gdiff<cr>
nmap <Leader>gw :Gwrite<cr>
nmap <Leader>gj :diffget //3<CR>
nmap <Leader>gf :diffget //2<CR>

autocmd BufReadPost fugitive:// setlocal bufhidden=delete

" ----------------------------------------------------------------------------
" vim-commentary
" ----------------------------------------------------------------------------
map  gc  <Plug>Commentary
nmap gcc <Plug>CommentaryLine

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

" }}}
