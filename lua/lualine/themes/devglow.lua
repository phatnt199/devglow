local colors = {
	color0 = "#EEE2DE",
	color1 = "#222222",
	color2 = "#111111",
	color3 = "#E5B567",
	color4 = "#797979",
	color5 = "#87AF87",
	color6 = "#AF5F5F",
	color7 = "#7EAAC7",
}

return {
	visual = {
		b = { fg = colors.color0, bg = colors.color1 },
		a = { fg = colors.color2, bg = colors.color3, gui = "bold" },
	},
	inactive = {
		b = { fg = colors.color4, bg = colors.color2 },
		c = { fg = colors.color4, bg = colors.color2 },
		a = { fg = colors.color4, bg = colors.color2, gui = "bold" },
	},
	insert = {
		b = { fg = colors.color0, bg = colors.color1 },
		a = { fg = colors.color2, bg = colors.color5, gui = "bold" },
	},
	replace = {
		b = { fg = colors.color0, bg = colors.color1 },
		a = { fg = colors.color2, bg = colors.color6, gui = "bold" },
	},
	normal = {
		b = { fg = colors.color0, bg = colors.color1 },
		c = { fg = colors.color4, bg = colors.color2 },
		a = { fg = colors.color2, bg = colors.color7, gui = "bold" },
	},
}
