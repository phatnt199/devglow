vim.cmd("hi clear")
if vim.g.colors_name then
  vim.cmd("syntax reset")
end

vim.o.background = "dark"
vim.g.colors_name = "devglow-nocturne"

local palette = require("devglow.palette").load("nocturne")
require("devglow.highlights")(palette)
