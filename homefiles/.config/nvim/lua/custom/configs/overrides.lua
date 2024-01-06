local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "c",
    "cpp",
    "python",
    "markdown",
  },
  indent = {
    enable = false,
    -- disable = {
    --   "python"
    -- },
  },

  highlight = {
    enable = true,
    use_languagetree = true,
  },
}

M.mason = {
  ensure_installed = {
    "black",
    "clang-format",
    "pyright",
    "mypy",
    "ruff",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

return M
