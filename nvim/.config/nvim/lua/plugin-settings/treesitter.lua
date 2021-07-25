require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  ensure_installed = {
    "go",
    "vue",
    "tsx",
    "toml",
    "php",
    "json",
    "yaml",
    "html",
    "scss"
  },
}
