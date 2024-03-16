local wezterm = require("wezterm")

return {
	font = wezterm.font_with_fallback({
		"CommitMono",
		"JetBrainsMono Nerd Font Mono Regular",
	}),
	font_size = 14.0,
	colors = {
		foreground = "#ffffff",
		background = "#161616",
		cursor_bg = "#ffffff",
		cursor_fg = "#161616",
		selection_fg = "#f2f4f8",
		selection_bg = "#393939",
		scrollbar_thumb = "#262626",
		split = "#262626",
		ansi = {
			"#161616",
			"#33b1ff",
			"#ff7eb6",
			"#42be65",
			"#08bdba",
			"#be95ff",
			"#78a9ff",
			"#dde1e6",
		},
		brights = {
			"#525252",
			"#33b1ff",
			"#ff7eb6",
			"#42be65",
			"#3ddbd9",
			"#82cfff",
			"#78a9ff",
			"#ffffff",
		},
	},
}
