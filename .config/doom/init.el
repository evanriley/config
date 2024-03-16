(doom!
 :completion
 (company
  +childframe
  +tng)
 
 (ivy
  +fuzzy
  +icons
  +prescient)
 
 (vertico
  +icons)
 :ui
 deft
 doom
 doom-dashboard
 (emoji +unicode)
 hl-todo
 modeline
 nav-flash
 ophints
 (popup +defaults)
 (vc-gutter +pretty)
 vi-tilde-fringe
 workspaces
 ligatures
 :editor
 (evil +everywhere)
 file-templates
 fold
 (format +onsave)
 rotate-text
 snippets
 :emacs
 (dired
  +icons)
 electric
 undo
 vc
 :term
 vterm
 :checkers
 (syntax +childframe)
 :tools
 direnv
 editorconfig
 ein
 (eval +overlay)
 lookup
 (lsp +eglot)
 (magit +forge)
 pdf
 tree-sitter
 :os
 (:if IS-MAC macos)
 :lang
 (cc
  +lsp
  +tree-sitter)
 (clojure
  +lsp
  +tree-sitter)
 common-lisp
 data
 (elixir
  +lsp
  +tree-sitter)
 emacs-lisp
 (erlang
  +lsp
  +tree-sitter)
 (go
  +lsp
  +tree-sitter)
 (java
  +lsp
  +tree-sitter)
 (javascript
  +lsp
  +tree-sitter)
 (lua
  +fennel
  +lsp
  +tree-sitter)
 markdown
 (nix
  +tree-sitter)
 (org
  +journal
  +pretty
  +roam2)
 (php
  +lsp
  +tree-sitter)
 (python
  +lsp
  +tree-sitter
  +poetry)
 rest
 (ruby
  +rails
  +tree-sitter)
 (rust
  +lsp
  +tree-sitter)
 sh
 (web
  +lsp
  +tree-sitter)
 yaml
 (zig
  +lsp
  +tree-sitter)
 :email
 ;;(mu4e +org +gmail)
 ;;notmuch
 ;;(wanderlust +gmail)
 :app
 ;;calendar
 ;;emms
 ;;everywhere        ; *leave* Emacs!? You must be joking
 ;;irc               ; how neckbeards socialize
 ;;(rss +org)        ; emacs as an RSS reader
 ;;twitter           ; twitter client https://twitter.com/vnought
 :config
 literate
 (default +bindings +smartparens)
 )
