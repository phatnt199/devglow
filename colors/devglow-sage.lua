vim.cmd("hi clear")
if vim.g.colors_name then
	vim.cmd("syntax reset")
end

vim.o.background = "dark"
vim.g.colors_name = "devglow-sage"

local palette = require("devglow.palette").load("sage")
require("devglow.highlights")(palette)
