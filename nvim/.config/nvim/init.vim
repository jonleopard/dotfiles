" Basic Settings {{{

set nocompatible                          " Use Vim's improvements
filetype plugin indent on                 " Enable fitetype detection, filetype scripts & indent scripts

let mapleader = ","                       " Map  <leader> key to ,
let maplocalleader="\\"                   " Map local leader to \\
set autoread                              " Auto-reload modified files
set encoding=utf-8                        " Encode characters as utf-8
set fileencoding=utf-8                    " Encode files as utf-8
set termencoding=utf-8                    " Set encoding used for the terminal
set foldmethod=marker                     " Fold based on specified markers
set gdefault                              " Default to substituting globally
set hlsearch                              " Highlight results
set ignorecase                            " Ignore the case in regexes
set incsearch                             " Enable incremental search
set smartcase                             " Override ignorecase if an uppercase is typed
set iskeyword-=_                          " Underscores delimit words
set lazyredraw                            " For better performance when replaying macros
set matchpairs+=<:>                       " Show matching <>'s, mostly for HTML
set noswapfile                            " Turn off file backups
set nowritebackup                         " Turn off swap file generation
set showbreak=                            " Show that a line has been wrapped
set nojoinspaces                          " Avoid double spaced when joining lines
set formatoptions=tcr                     " Auto-wrap text and comments at textwidth and insert the comment leader in insert mode
set formatoptions+=l                      " If a line is longer that textwidth when the insert starts, don't reformat it
set formatoptions+=1                      " Don't wrap after a 1 letter word, wrap before
set formatoptions+=jq                     " Delete comment leaders when joining lines and allow `gq` on comments

set smartindent
set backspace=indent,eol,start
"set colorcolumn=80                       " Highlight 80 character limit
set hidden                                " Hide buffers instead of closing them
set history=1000                          " Rememebr command mode history
set laststatus=2                          " Always show the status bar. Airline requires this.
set list                                  " Show invisible characters
set listchars=tab:›\ ,eol:¬,trail:⋅       " Set the characters for the invisibles
set number relativenumber                 " Line number is relative to your position
set scrolloff=5                           " Keep the cursor centered in the screen
set sidescroll=1                          " Scroll sideways a character at a time, not a screen at a time
set sidescrolloff=5                       " Show 5 characters of context when side scrolling
set showmatch                             " Highlight matching braces
set showmode                              " Show the current mode on the open buffer
set splitbelow                            " Better split opening
set splitright                            " Better split opening
set title                                 " Set the title for gvim
set visualbell                            " Use a visual bell to notify us
set expandtab smarttab                    " Expand tabs to the proper type and size
set tabstop=2                             " Tabs width in spaces
set shiftwidth=2                          " Amount of spaces when shifting
set shell=/usr/local/bin/zsh              " Setting shell to homebrew zsh
set synmaxcol=160                         " Don't try to syntax highlight minified files"
set notimeout
set ttimeout
set ttimeoutlen=10
let g:netrw_localrmdir='rm -r'            " Allow deletion of a dir that isn't empty
let g:netrw_banner=0                      " Dont show the banner


" }}}

" Plugins {{{

"Check for vim-plug before installing plugins
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

" Colorscheme & Syntax Highlighting
Plug 'Yggdroot/indentLine'
Plug 'dracula/vim'

" Git
Plug 'junegunn/vim-github-dashboard'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Tmux
Plug 'christoomey/vim-tmux-navigator'


" Auto completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Editing
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'sheerun/vim-polyglot'
Plug 'neomake/neomake'
"Plug 'tomtom/tcomment_vim
Plug 'tpope/vim-commentary',        { 'on': '<Plug>Commentary' }
Plug 'junegunn/vim-easy-align',     { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'fatih/vim-hclfmt'
Plug 'plasticboy/vim-markdown'
Plug 'reasonml/vim-reason-loader'
Plug 'tpope/vim-repeat'
Plug 'mattn/emmet-vim'

" Javascript
Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'] }
"Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

" Puppet
Plug 'voxpupuli/vim-puppet'

" Go
Plug 'fatih/vim-go'
Plug 'zchee/deoplete-go'

" Ruby/Rails
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'

" Searching/Navigation
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-vinegar'
Plug 'justinmk/vim-dirvish'

" Utils
Plug 'tpope/vim-eunuch'
Plug 'ervandew/supertab'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-startify'
Plug 'metakirby5/codi.vim'
Plug 'mhinz/vim-grepper'
Plug 'easymotion/vim-easymotion'
Plug 'sjl/gundo.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'rizzatti/dash.vim'

call plug#end()
" }}}

" Statusline (Airline) {{{
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='dracula'

" }}}

" Color settings {{{

" vim color scheme (dracula)
syntax on
color dracula
set t_Co=256

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later,
"you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 
  "< https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.40 (`guicolors` option) 
  "< https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  "< https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
        set termguicolors
  endif
endif

" }}}

" Windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l


" Plugin Settings {{{

" ----------------------------------------------------------------------------
" vim-commentary
" ----------------------------------------------------------------------------
map  gc  <Plug>Commentary
nmap gcc <Plug>CommentaryLine

"Gundu
nnoremap <leader>t :GundoToggle<CR>

" Deoplete
let g:deoplete#enable_at_startup = 1
set completeopt=longest,menuone,preview
let g:deoplete#sources = {}
let g:deoplete#sources['javascript.jsx'] = ['file', 'ultisnips', 'ternjs']
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']

" Omnifuncs
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
  \ 'tern#Complete',
  \ 'jspc#omni'
\]

" Supertab
autocmd FileType javascript let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:UltiSnipsExpandTrigger="<C-j>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"


" FZF+Ag
if has('nvim')
 let $FZF_DEFAULT_OPTS .= ' --inline-info'
 " let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif

" File preview using Highlight (http://www.andre-simon.de/doku/highlight/en/highlight.php)
let g:fzf_files_options = printf('--preview "%s {} | head -'.&lines.'"',
      \ g:plugs['fzf.vim'].dir.'/bin/preview.rb')

" nnoremap <silent> <Leader><Leader> :Files<CR>
nnoremap <silent> <Leader>C        :Colors<CR>
nnoremap <silent> <Leader><Enter>  :Buffers<CR>
nnoremap <silent> <Leader>ag       :Ag <C-R><C-W><CR>
nnoremap <silent> <Leader>AG       :Ag <C-R><C-A><CR>
xnoremap <silent> <Leader>ag       y:Ag <C-R>"<CR>
nnoremap <silent> <Leader>`        :Marks<CR>
" nnoremap <silent> q: :History:<CR>
" nnoremap <silent> q/ :History/<CR>

inoremap <expr> <c-x><c-t> fzf#complete('tmuxwords.rb --all-but-current --scroll 500 --min 5')
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

command! Plugs call fzf#run({
  \ 'source':  map(sort(keys(g:plugs)), 'g:plug_home."/".v:val'),
  \ 'options': '--delimiter / --nth -1',
  \ 'down':    '~40%',
  \ 'sink':    'Explore'})

" Use ; for commands.
nnoremap ; :

" Use Q to execute default register.
nnoremap Q @q


" Set // to search the current visual selection
vnoremap // y/<C-R>"<CR>"

" neomake
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_jsx_enabled_makers = ['eslint']
autocmd! BufWritePost * Neomake
let g:neomake_verbose=3
let g:neomake_open_list = 2

" Neomake bindings
nmap <Leader><Space>o :lopen<CR>      " open location window
nmap <Leader><Space>c :lclose<CR>     " close location window
nmap <Leader><Space>, :ll<CR>         " go to current error/warning
nmap <Leader><Space>n :lnext<CR>      " next error/warning
nmap <Leader><Space>p :lprev<CR>      " previous error/warning


" Shortcut to yanking to the system clipboard
map <leader>y "*y
map <leader>p "*p

" Navigating tabs easier
map <D-S-{> :tabprevious
map <D-S-}> :tabprevious

" To force myself to use hjkl. Pleb mode.
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" yank to clipboard
if has("clipboard")
  set clipboard=unnamed " copy to the system clipboard
  if has("unnamedplus") " X11 support
    set clipboard+=unnamedplus
  endif
endif

" Keybind crosshairs on and off
hi CursorLine   cterm=NONE ctermbg=235
hi CursorColumn cterm=NONE ctermbg=235
nnoremap x :set cursorline! cursorcolumn!

" toggle paste in cmd only
nnoremap <Leader>p :set invpaste<CR>

" netrw goodness
"let g:netrw_banner = 0
""let g:netrw_liststyle = 3
"let g:netrw_browse_split = 4
"let g:netrw_altv = 1
"let g:netrw_winsize = 25
"augroup ProjectDrawer
""  autocmd!
""  autocmd VimEnter * :Vexplore
"augroup END


" }}}

" Pyenv Paths {{{
  let g:python_host_prog  = '/Users/jon/.pyenv/versions/neovim2/bin/python'
  let g:python3_host_prog = '/Users/jon/.pyenv/versions/neovim3/bin/python'


" Faster startup time
  "let g:python_host_skip_check=1            " Skip python 2 host check
  "let g:loaded_python3_provider=1           " Disable python 2 interface

" }}}
