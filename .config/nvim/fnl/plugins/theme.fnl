(local {: autoload} (require :nfnl.module))
(local nvim (autoload :nvim))

; Kanagawa
; [{1 :rebelot/kanagawa.nvim
;   :lazy false
;   :priority 1000
;   :name "kanagawa"
;   :config (fn []
;             (let [theme (require :kanagawa)]
;               (theme.setup {:undercurl false
;                             :theme "wave"
;                             :background {:dark "wave"
;                                          :light "lotus"}})
;               (vim.cmd "colorscheme kanagawa")))}]


[{1 :no-clown-fiesta/no-clown-fiesta.nvim
  :lazy false
  :priority 1000
  :config (fn []
            (let [theme (require :no-clown-fiesta)]
              (theme.setup {:transparent false})
              (vim.cmd "colorscheme no-clown-fiesta")))}]
