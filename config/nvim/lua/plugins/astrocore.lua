return {
  "AstroNvim/astrocore",
  opts = {
    autocmds = {
      transparent_ui = {
        {
          event = "ColorScheme",
          desc = "Force transparent UI",
          callback = function()
            local groups = {
              -- Base
              "Normal",
              "NormalNC",
              "NeoTreeNormal",
              "NeoTreeNormalNC",
              "NeoTreeEndOfBuffer",
              "NeoTreeVertSplit",
              "NeoTreeWinSeparator",
              -- Statusline / Powerline
              "StatusLine",
              "StatusLineNC",
              -- Tabline
              "TabLine",
              "TabLineFill",
              "TabLineSel",

              -- Separators
              "WinSeparator",
            }

            for _, group in ipairs(groups) do
              vim.api.nvim_set_hl(0, group, { bg = "none" })
            end
          end,
        },
      },
    },
  },
}

