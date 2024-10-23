local colors = {
	color0 = "#EEE2DE",
	color1 = "#BBBBBB",
	color4 = "#30302C",
	color5 = "#E5B567",
	color6 = "#444444",
	color7 = "#797979",
	color10 = "#87AF87",
	color13 = "#AF5F5F",
	color14 = "#7EAAC7",
}

return {
	visual = {
		b = { fg = colors.color0, bg = colors.color1 },
		a = { fg = colors.color4, bg = colors.color5, gui = "bold" },
	},
	inactive = {
		b = { fg = colors.color6, bg = colors.color4 },
		c = { fg = colors.color6, bg = colors.color4 },
		a = { fg = colors.color7, bg = colors.color4, gui = "bold" },
	},
	insert = {
		b = { fg = colors.color0, bg = colors.color1 },
		a = { fg = colors.color4, bg = colors.color10, gui = "bold" },
	},
	replace = {
		b = { fg = colors.color0, bg = colors.color1 },
		a = { fg = colors.color4, bg = colors.color13, gui = "bold" },
	},
	normal = {
		b = { fg = colors.color0, bg = colors.color1 },
		c = { fg = colors.color7, bg = colors.color4 },
		a = { fg = colors.color4, bg = colors.color14, gui = "bold" },
	},
}
