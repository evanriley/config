(local {: autoload} (require :nfnl.module))
(local nvim (autoload :nvim))

[{1 :rebelot/kanagawa.nvim
  :lazy false
  :priority 1000
  :name "kanagawa"
  :config (fn []
            (let [theme (require :kanagawa)]
              (theme.setup {:undercurl false
                            :theme "wave"
                            :background {:dark "wave"
                                         :light "lotus"}})
              (vim.cmd "colorscheme kanagawa")))}]

