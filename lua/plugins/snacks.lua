return {
	"folke/snacks.nvim",
	opts = {
		picker = {
			sources = {
				explorer = {
					formatters = {
						file = {
							icon = function(item)
								local mini_icons = require("mini.icons")
								if item.is_dir then
									if item.is_open then
										return " ", "MiniIconsAzure"
									else
										return " ", "MiniIconsAzure"
									end
								end
								return mini_icons.get("file", item.file)
							end,
						},
					},
				},
			},
		},
	},
}
