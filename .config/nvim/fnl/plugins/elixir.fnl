
(local {: autoload} (require :nfnl.module))
(local nvim (autoload :nvim))

[{1 :elixir-tools/elixir-tools.nvim
  :lazy true
  :ft [:elixir]
  :config (fn []
            (let [elixir (require :elixir)
                  elixirls (require :elixir.elixirls)]
              (elixir.setup
                {:nextls {:enable true}
                 :elixirls {:enable false}})))}]
