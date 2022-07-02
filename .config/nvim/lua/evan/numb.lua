local numb_status_ok, numb = pcall(require, "numb")
if not numb_status_ok then
	return
end

numb.setup({
	number_only = true,
})
