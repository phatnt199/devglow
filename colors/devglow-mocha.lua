vim.cmd("hi clear")
if vim.g.colors_name then
  vim.cmd("syntax reset")
end

vim.o.background = "dark"
vim.g.colors_name = "devglow-mocha"

local palette = require("devglow.palette").load("mocha")
require("devglow.highlights")(palette)
