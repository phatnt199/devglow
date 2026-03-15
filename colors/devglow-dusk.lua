vim.cmd("hi clear")
if vim.g.colors_name then
  vim.cmd("syntax reset")
end

vim.o.background = "dark"
vim.g.colors_name = "devglow-dusk"

local palette = require("devglow.palette").load("dusk")
require("devglow.highlights")(palette)
