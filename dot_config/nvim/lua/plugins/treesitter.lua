return{
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.config")
    configs.setup({
      ensure_installed = { "lua", "vim", "vimdoc", "php", "tsx", "typescript" },
      highlight = { enable = true },
    })
  end,
}
