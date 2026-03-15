local M = {}

function M.load(variant)
	return require("devglow.palettes." .. (variant or "sage"))
end

return M
