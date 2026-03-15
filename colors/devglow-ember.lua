vim.cmd("hi clear")
if vim.g.colors_name then
	vim.cmd("syntax reset")
end

vim.o.background = "dark"
vim.g.colors_name = "devglow-ember"

local palette = require("devglow.palette").load("ember")
require("devglow.highlights")(palette)
