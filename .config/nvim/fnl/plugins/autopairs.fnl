(local {: autoload} (require :nfnl.module))
(local nvim (autoload :nvim))

[{1 :altermo/ultimate-autopair.nvim
  :event ["InsertEnter" "CmdLineEnter"]
  :config (fn []
            (let [ultimate-autopair (require :ultimate-autopair)]
              (ultimate-autopair.setup {})))}]
