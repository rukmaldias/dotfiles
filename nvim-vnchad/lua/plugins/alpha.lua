return {
  "goolord/alpha-nvim",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    local alpha = require "alpha"
    local dashboard = require "alpha.themes.startify"

    dashboard.section.header.val = {
      " ._       __          ____                               ",
      ";  `\\--,-' /`)    _.-'    `-._                           ",
      " \\_/    ' | /`--,'            `-.     .--....____        ",
      "  /                              `._.'           `---... ",
      "  |-.   _      ;                        .-----..._______)",
      ",,\\q/ (q_>'_...                      .-'                 ",
      "===/ ; _.-'~~-             /       ,'                    ",
      '`""`-\'_,;  `""         ___(       |                      ',
      "         \\         ; /'/   \\      \\                      ",
      "          `.      //' (    ;`\\    `\\                     ",
      "          / \\    ;     `-  /  `-.  /                     ",
      "         (  (;   ;     (__/    /  /                      ",
      "          \\,_)\\  ;           ,'  /                       ",
      "  .-.          |  |           `--'                       ",
      ' ("_.)-._     (__,>                                      ',
    }
    alpha.setup(dashboard.opts)
  end,
}
