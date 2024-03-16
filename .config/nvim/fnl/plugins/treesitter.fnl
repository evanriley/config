[{1 :nvim-treesitter/nvim-treesitter
  :dependencies [:windwp/nvim-ts-autotag
                 :nvim-treesitter/nvim-treesitter-textobjects
                 :JoosepAlviste/nvim-ts-context-commentstring
                 :mrjones2014/nvim-ts-rainbow
                 :nvim-treesitter/nvim-treesitter-context
                 :RRethy/nvim-treesitter-endwise]
  :build ":TSUpdate"
  :config (fn []
            (let [treesitter (require :nvim-treesitter.configs)]
              (treesitter.setup {:highlight {:enable true}
                                 :indent {:enable true}
                                 :ensure_installed :all
                                 :rainbow {:enable true
                                           :extended_mode true}
                                 :autotag {:enable true}
                                 :endiwse {:enable true}
                                 :contet_commentstring {:enable true}}))
            (let [treesitter-context (require :treesitter-context)]
              (treesitter-context.setup {:enable true})))}]
