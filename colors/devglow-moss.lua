vim.cmd("hi clear")
if vim.g.colors_name then
  vim.cmd("syntax reset")
end

vim.o.background = "dark"
vim.g.colors_name = "devglow-moss"

local palette = require("devglow.palette").load("moss")
require("devglow.highlights")(palette)
