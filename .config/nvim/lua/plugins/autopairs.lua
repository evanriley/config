local status_ok, pairs = pcall(require, "nvim-autopairs")
if not status_ok then
  return
end

pairs.setup({
  check_ts = true,
  disable_filetypes = { "TelescopePrompt" },
})
