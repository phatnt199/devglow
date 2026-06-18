vim.cmd("hi clear")
if vim.g.colors_name then
  vim.cmd("syntax reset")
end

vim.o.background = "dark"
vim.g.colors_name = "devglow-tide"

local palette = require("devglow.palette").load("tide")
require("devglow.highlights")(palette)
