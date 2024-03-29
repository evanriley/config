(local {: autoload} (require :nfnl.module))
(local nvim (autoload :nvim))

(local servers
  ["gopls" "rust_analyzer" "html" "elixirls" "clojure_lsp" "lua_ls"])

;symbols to show for lsp diagnostics
(fn define-signs
  [prefix]
  (let [error (.. prefix "SignError")
        warn  (.. prefix "SignWarn")
        info  (.. prefix "SignInfo")
        hint  (.. prefix "SignHint")]
    (vim.fn.sign_define error {:text "" :texthl error})
    (vim.fn.sign_define warn  {:text "" :texthl warn})
    (vim.fn.sign_define info  {:text "" :texthl info})
    (vim.fn.sign_define hint  {:text "" :texthl hint})))

(define-signs "Diagnostic")

[{1 :neovim/nvim-lspconfig
    :dependencies [:lukas-reineke/lsp-format.nvim
                   :williamboman/mason.nvim
                   :williamboman/mason-lspconfig.nvim]
  :config (fn []
            (let [lsp (require :lspconfig)
                  lsp-format (require :lsp-format)
                  cmplsp (require :cmp_nvim_lsp)
                  mason (require :mason)
                  mason-lspconfig (require :mason-lspconfig)
                  handlers {"textDocument/publishDiagnostics"
                            (vim.lsp.with
                              vim.lsp.diagnostic.on_publish_diagnostics
                              {:severity_sort true
                               :update_in_insert true
                               :underline true
                               :virtual_text true})
                            "textDocument/hover"
                            (vim.lsp.with
                              vim.lsp.handlers.hover
                              {:border "single"})
                            "textDocument/signatureHelp"
                            (vim.lsp.with
                              vim.lsp.handlers.signature_help
                              {:border "single"})}
                  capabilities (cmplsp.default_capabilities)
                  before_init (fn [params]
                                (set params.workDoneToken :1))
                  on_attach (fn [client bufnr]
                              (do
                                (nvim.buf_set_keymap bufnr :n :gd "<Cmd>lua vim.lsp.buf.definition()<CR>" {:noremap true})
                                (nvim.buf_set_keymap bufnr :n :K "<Cmd>lua vim.lsp.buf.hover()<CR>" {:noremap true})
                                (nvim.buf_set_keymap bufnr :n :gD "<Cmd>lua vim.lsp.buf.declaration()<CR>" {:noremap true})
                                (nvim.buf_set_keymap bufnr :n :<leader>D "<cmd>lua vim.lsp.buf.type_definition()<CR>" {:noremap true})
                                (nvim.buf_set_keymap bufnr :n :<leader>lh "<cmd>lua vim.lsp.buf.signature_help()<CR>" {:noremap true})
                                (nvim.buf_set_keymap bufnr :n :<leader>rn "<cmd>lua vim.lsp.buf.rename()<CR>" {:noremap true})
                                (nvim.buf_set_keymap bufnr :n :<leader>le "<cmd>lua vim.diagnostic.open_float()<CR>" {:noremap true})
                                (nvim.buf_set_keymap bufnr :n :<leader>lq "<cmd>lua vim.diagnostic.setloclist()<CR>" {:noremap true})
                                (nvim.buf_set_keymap bufnr :n :<leader>lf "<cmd>lua vim.lsp.buf.format()<CR>" {:noremap true})
                                (nvim.buf_set_keymap bufnr :n :<leader>lj "<cmd>lua vim.diagnostic.goto_next()<CR>" {:noremap true})
                                (nvim.buf_set_keymap bufnr :n :<leader>lk "<cmd>lua vim.diagnostic.goto_prev()<CR>" {:noremap true})
                                (nvim.buf_set_keymap bufnr :n :<leader>ca "<cmd>lua vim.lsp.buf.code_action()<CR>" {:noremap true})
                                (nvim.buf_set_keymap bufnr :v :<leader>la "<cmd>lua vim.lsp.buf.range_code_action()<CR> " {:noremap true})
                                ;telescope
                                (nvim.buf_set_keymap bufnr :n :<leader>lw ":lua require('telescope.builtin').diagnostics()<cr>" {:noremap true})
                                (nvim.buf_set_keymap bufnr :n :gr ":lua require('telescope.builtin').lsp_references()<cr>" {:noremap true})
                                (nvim.buf_set_keymap bufnr :n :gI ":lua require('telescope.builtin').lsp_implementations()<cr>" {:noremap true})))]

              (mason.setup {})
              (mason-lspconfig.setup {:ensure_installed servers})
              (each [_ server (ipairs servers)]
                ((. (. lsp server) :setup) {:on_attach lsp-format.on_attach
                                            :before_init before_init
                                            :handlers handlers
                                            :capabilities capabilities}))))}]
