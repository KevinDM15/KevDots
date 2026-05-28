return {
  -- Navegación entre paneles de Zellij/tmux con hjkl
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft", "TmuxNavigateDown",
      "TmuxNavigateUp", "TmuxNavigateRight",
    },
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>" },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>" },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>" },
      { "<C-l>", "<cmd>TmuxNavigateRight<cr>" },
    },
  },

  -- Autopares mejorado
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = { check_ts = true },
  },

  -- Resalta colores hex en el código
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
      user_default_options = { tailwind = true, css = true },
    },
  },

  -- Mejor UI para LSP rename/code action
  {
    "stevearc/dressing.nvim",
    opts = {},
  },

  -- Historial de archivo y diffs entre commits
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>",                desc = "Diff View" },
      { "<leader>gf", "<cmd>DiffviewFileHistory %<cr>",       desc = "File History" },
      { "<leader>gF", "<cmd>DiffviewFileHistory<cr>",         desc = "Repo History" },
      { "<leader>gx", "<cmd>DiffviewClose<cr>",               desc = "Close Diff" },
    },
  },

  -- Resalta TODO/FIXME/HACK en el código
  {
    "folke/todo-comments.nvim",
    event = "BufReadPost",
    opts = { signs = true },
    keys = {
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo Comments" },
    },
  },

  -- Blame inline al final de la línea (estilo GitLens)
  {
    "f-person/git-blame.nvim",
    event = "BufReadPre",
    opts = {
      enabled = true,
      message_template = " <author> • <date> • <summary>",
      date_format = "%d/%m/%y",
      highlight_group = "Comment",
    },
    keys = {
      { "<leader>gb", "<cmd>GitBlameToggle<cr>", desc = "Toggle Git Blame" },
    },
  },

  -- Git decorations en el gutter
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
    },
  },
}
