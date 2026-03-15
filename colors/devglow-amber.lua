vim.cmd("hi clear")
if vim.g.colors_name then
  vim.cmd("syntax reset")
end

vim.o.background = "dark"
vim.g.colors_name = "devglow-amber"

local palette = require("devglow.palette").load("amber")
require("devglow.highlights")(palette)
