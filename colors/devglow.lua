-----------------------------------------------------------------------------
-- DEVGLOW (default: sage)
--- A professional dark colorscheme for Neovim
---
--- Author: Phat Nguyen (tanphat199@gmail.com)
--- Version: 1.0.3
---
--- Usage:
---   :colorscheme devglow        (sage, default)
---   :colorscheme devglow-sage   (explicit sage)
---   :colorscheme devglow-ember  (warm terracotta)
-----------------------------------------------------------------------------

vim.cmd("hi clear")
if vim.g.colors_name then
  vim.cmd("syntax reset")
end

vim.o.background = "dark"
vim.g.colors_name = "devglow"

local palette = require("devglow.palette").load("sage")
require("devglow.highlights")(palette)
