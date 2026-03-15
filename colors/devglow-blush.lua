vim.cmd("hi clear")
if vim.g.colors_name then
  vim.cmd("syntax reset")
end

vim.o.background = "dark"
vim.g.colors_name = "devglow-blush"

local palette = require("devglow.palette").load("blush")
require("devglow.highlights")(palette)
