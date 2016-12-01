" Set Python Paths
let g:python_host_prog = '/usr/local/bin/python2'
let g:python3_host_prog = '/usr/local/bin/python3'

" neomake
autocmd! BufWritePost * Neomake
let g:neomake_open_list = 2
let g:neomake_verbose = 3
let g:neomake_javascript_enabled_makers=['xo']
let g:neomake_jsx_enabled_makers = ['xo']
let g:neomake_javascript_xo_maker={
      \ 'args': ['--reporter=compact'],
      \ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,' .
      \ '%W%f: line %l\, col %c\, Warning - %m'
      \ }

" neomake config
let g:neomake_place_signs = 0
let g:neomake_open_list = 2
let g:neomake_javascript_enabled_makers = ['xo']

" vim color scheme (gruvbox)
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let g:gruvbox_invert_selection = 1
let g:gruvbox_bold=1
let g:gruvbox_italic = 1
let g:gruvbox_contrast_dark = 'medium'
let g:gruvbox_termcolors = 256
set termguicolors
syntax enable
colorscheme gruvbox
set background=dark

" Highlight Italics
highlight Comment cterm=italic
