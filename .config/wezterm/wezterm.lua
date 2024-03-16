local wezterm = require("wezterm")

return {
  font = wezterm.font_with_fallback({
    "JuliaMono",
    "JetBrainsMono Nerd Font Mono Regular",
  }),
  font_size = 12.0,
  color_scheme = "Gruvbox dark, medium (base16)",
}
