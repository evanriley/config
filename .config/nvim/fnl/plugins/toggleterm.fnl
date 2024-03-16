(local {: autoload} (require :nfnl.module))
(local nvim (autoload :nvim))

[{1 :akinsho/toggleterm.nvim
  :lazy false
  :config (fn []
            (let [toggleterm (require :toggleterm)]
              (toggleterm.setup {:open_mapping "<C-t>"})))}]
