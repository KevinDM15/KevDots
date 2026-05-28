return {
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "night",
      transparent = true,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        sidebars = "transparent",
        floats = "transparent",
      },
      on_colors = function(colors)
        colors.bg = "#0d0010"
        colors.bg_dark = "#0a000d"
      end,
    },
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "mocha",
      transparent_background = true,
      styles = {
        comments = { "italic" },
        keywords = { "italic" },
      },
    },
  },

  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      variant = "moon",
      disable_background = true,
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-night",
    },
  },

  {
    "nvim-lua/plenary.nvim",
    keys = {
      {
        "<leader>uc",
        function()
          local themes = { "tokyonight-night", "catppuccin", "rose-pine" }
          vim.ui.select(themes, { prompt = "Colorscheme" }, function(choice)
            if choice then
              vim.cmd("colorscheme " .. choice)
            end
          end)
        end,
        desc = "Switch Colorscheme",
      },
    },
  },
}
