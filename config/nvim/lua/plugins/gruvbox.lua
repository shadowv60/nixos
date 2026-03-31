return {
  -- Configure Gruvbox to support transparency
  {
    "ellisonleao/gruvbox.nvim",
    opts = {
      transparent_mode = true, -- This tells Gruvbox not to set a background color
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },

  -- Configure LazyVim to use Gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    opts = {},
  },
}
