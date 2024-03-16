;;; config.el -*- lexical-binding: t; -*-
;; This file has been generated from config.org file. DO NOT EDIT.
;; Sources are available from https://github.com/evanriley/config

;; Copyright (C) 2023 Evan Riley

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; For a full copy of the GNU General Public License
;; see <https://www.gnu.org/licenses/>.

(when (eq system-type 'darwin) (customize-set-variable 'native-comp-driver-options '("-Wl,-w")))

(setq-default custom-file (expand-file-name ".custom.el" doom-private-dir))
(when (file-exists-p custom-file)
  (load custom-file))

(setq user-full-name "Evan Riley"
      user-mail-address "evan@evanriley.net")

(setq-default
 gc-cons-threshold 134217738
 gc-cons-percentage 0.1
 window-combination-resize t                      ; take new window space from all other windows (not just current)
 x-stretch-cursor t)                              ; Stretch cursor to the glyph width

(setq auth-sources '("~/.authinfo.gpg")
      auth-source-cache-expiry nil) ; default is 7200 (2h)

(setq doom-font (font-spec :family "CommitMono" :size 17)
      doom-big-font (font-spec :family "CommitMono" :size 32)
      doom-variable-pitch-font (font-spec :family "Victor Mono" :size 17)
      doom-unicode-font (font-spec :family "JetBrainsMono Nerd Font")
      doom-serif-font (font-spec :family "IBM Plex Mono" :weight 'light))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
;;(setq doom-theme 'doom-tomorrow-night)

(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t)); if nil, italics is universally disabled

(setq doom-theme 'doom-tomorrow-night)

(add-to-list 'initial-frame-alist '(fullscreen . maximized))

(setq display-line-numbers-type 'relative)

(setq evil-vsplit-window-right t
      evil-split-window-below t)

(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (consult-buffer))

(setq vterm-always-compile-module t)

(setq vterm-kill-buffer-on-exit t)

(after! vterm
  (setf (alist-get "magit-status" vterm-eval-cmds nil nil #'equal)
        '((lambda (path)
            (magit-status path)))))

(solaire-global-mode +1)

(setq forge-owned-accounts '(("evanriley")))

(after! lsp-mode
  (setq lsp-enable-symbol-highlighting nil))

(after! lsp-ui
  (setq lsp-ui-sideline-enable nil  ; no more useful than flycheck
        lsp-ui-doc-enable nil))     ; redundant with K

(after! eglot
    (add-hook 'elixir-mode-hook 'eglot-ensure)
    (add-to-list 'eglot-server-programs '(elixir-mode "/opt/homebrew/bin/elixir-ls")))

(after! web-mode
  (add-to-list 'auto-mode-alist '("\\.eex\\'" . web-mode)))

(map! "C-'" #'avy-goto-char-timer)

(after! avy
  (setq avy-timeout-seconds 0.3))

(after! company
  (setq company-idle-delay 0.1
        company-selection-wrap-around t
        company-require-match 'never
        company-dabbrev-downcase nil
        company-dabbrev-ignore-case t
        company-dabbrev-other-buffers nil
        company-tooltip-limit 5
        company-tooltip-minimum-width 40)
  (set-company-backend!
    '(text-mode
      markdown-mode
      gfm-mode)
    '(:seperate
      company-files)))

(setq company-global-modes
      '(not erc-mode
            circe-mode
            message-mode
            help-mode
            gud-mode
            vterm-mode
            org-mode))

(setq which-key-idle-delay 0.5)

(setq which-key-allow-multiple-replacements t)
(after! which-key
  (pushnew!
   which-key-replacement-alist
   '(("" . "\\`+?evil[-:]?\\(?:a-\\)?\\(.*\\)") . (nil . "◂\\1"))
   '(("\\`g s" . "\\`evilem--?motion-\\(.*\\)") . (nil . "◃\\1"))
   ))

(defvar +messages--auto-tail-enabled nil)

(defun +messages--auto-tail-a (&rest arg)
  "Make *Messages* buffer auto-scroll to the end after each message."
  (let* ((buf-name (buffer-name (messages-buffer)))
         ;; Create *Messages* buffer if it does not exist
         (buf (get-buffer-create buf-name)))
    ;; Activate this advice only if the point is _not_ in the *Messages* buffer
    ;; to begin with. This condition is required; otherwise you will not be
    ;; able to use `isearch' and other stuff within the *Messages* buffer as
    ;; the point will keep moving to the end of buffer :P
    (when (not (string= buf-name (buffer-name)))
      ;; Go to the end of buffer in all *Messages* buffer windows that are
      ;; *live* (`get-buffer-window-list' returns a list of only live windows).
      (dolist (win (get-buffer-window-list buf-name nil :all-frames))
        (with-selected-window win
          (goto-char (point-max))))
      ;; Go to the end of the *Messages* buffer even if it is not in one of
      ;; the live windows.
      (with-current-buffer buf
        (goto-char (point-max))))))

(defun +messages-auto-tail-toggle ()
  "Auto tail the '*Messages*' buffer."
  (interactive)
  (if +messages--auto-tail-enabled
      (progn
        (advice-remove 'message '+messages--auto-tail-a)
        (setq +messages--auto-tail-enabled nil)
        (message "+messages-auto-tail: Disabled."))
    (advice-add 'message :after '+messages--auto-tail-a)
    (setq +messages--auto-tail-enabled t)
    (message "+messages-auto-tail: Enabled.")))

;; Increase undo history limits even more
(after! undo-fu
  ;; Emacs undo defaults
  (setq undo-limit        10000000    ;; 1MB   (default is 160kB, Doom's default is 400kB)
        undo-strong-limit 100000000   ;; 100MB (default is 240kB, Doom's default is 3MB)
        undo-outer-limit  1000000000) ;; 1GB   (default is 24MB,  Doom's default is 48MB)

  ;; Undo-fu customization options
  (setq undo-fu-allow-undo-in-region t ;; Undoing with a selection will use undo within that region.
        undo-fu-ignore-keyboard-quit t)) ;; Use the `undo-fu-disable-checkpoint' command instead of Ctrl-G `keyboard-quit' for non-linear behavior.

;; Evil undo
(after! evil
  (setq evil-want-fine-undo t)) ;; By default while in insert all changes are one big blob

(use-package! vundo
  :defer t
  :init
  (defconst +vundo-unicode-symbols
   '((selected-node   . ?●)
     (node            . ?○)
     (vertical-stem   . ?│)
     (branch          . ?├)
     (last-branch     . ?╰)
     (horizontal-stem . ?─)))

  (map! :leader
        (:prefix ("o")
         :desc "vundo" "v" #'vundo))

  :config
  (setq vundo-glyph-alist +vundo-unicode-symbols
        vundo-compact-display t
        vundo-window-max-height 6))

(setq projectile-ignored-projects '("~/" "/tmp" "~/.emacs.d/.local/straight/repos/"))
(setq projectile-project-search-path '("~/Code/personal/" "~/Code/work/" "~/Code/oss/"))
(defun projectile-ignored-project-function (filepath)
  "Return t if FILEPATH is within any of `projectile-ignored-projects'"
  (or (mapcar (lambda (p) (s-starts-with-p p filepath)) projectile-ignored-projects)))

(setq scroll-margin 2
      auto-save-default t
      delete-by-moving-to-trash t
      truncate-string-ellipsis "…"
      browse-url-browser-function 'xwidget-webkit-browse-url)

(fringe-mode 0)
(global-subword-mode 1)

(defun doom-modeline-conditional-buffer-encoding ()
  "We expect the encoding to be LF UTF-8, so only show the modeline when this is not the case"
  (setq-local doom-modeline-buffer-encoding
              (unless (and (memq (plist-get (coding-system-plist buffer-file-coding-system) :category)
                                 '(coding-category-undecided coding-category-utf-8))
                           (not (memq (coding-system-eol-type buffer-file-coding-system) '(1 2))))
                t)))

(add-hook 'after-change-major-mode-hook #'doom-modeline-conditional-buffer-encoding)

(display-time-mode 1)                             ; Enable time in the mode-line

(after! magit
  (magit-delta-mode +1))

(use-package! magit-pretty-graph
  :after magit
  :init
  (setq magit-pg-command
        (concat "git --no-pager log"
                " --topo-order --decorate=full"
                " --pretty=format:\"%H%x00%P%x00%an%x00%ar%x00%s%x00%d\""
                " -n 2000")) ;; Increase the default 100 limit

  (map! :localleader
        :map (magit-mode-map)
        :desc "Magit pretty graph" "p" (cmd! (magit-pg-repo (magit-toplevel)))))

(use-package! info-colors
  :commands (info-colors-fontify-node))

(add-hook 'Info-selection-hook 'info-colors-fontify-node)

(setq fancy-splash-image "~/.config/doom/emacs.svg")

(after! marginalia
  (setq marginalia--ellipsis "…"    ; Nicer ellipsis
        marginalia-align 'right     ; right alignment
        marginalia-align-offset -1)) ; one space on the right

(setq +zen-text-scale 0.8)

(use-package! nov
  :mode ("\\.epub\\'" . nov-mode)
  :config
  (map! :map nov-mode-map
        :n "RET" #'nov-scroll-up)

  (advice-add 'nov-render-title :override #'ignore)
  (defun +nov-mode-setup ()
    (face-remap-add-relative 'default :height 1.3)
    (setq-local next-screen-context-lines 4
                shr-use-colors nil)
    (require 'visual-fill-column nil t)
    (setq-local visual-fill-column-center-text t
                visual-fill-column-width 81
                nov-text-width 80)
    (visual-fill-column-mode 1)
    (add-to-list '+lookup-definition-functions #'+lookup/dictionary-definition)
    (add-hook 'nov-mode-hook #'+nov-mode-setup)))

(global-hl-line-mode 0)

(after! org
  (setq org-directory "~/org"                     ; let's put files here
        org-ellipsis "…"                          ; cute icon for folded org blocks
        org-list-allow-alphabetical t             ; have a. A. a) A) list bullets
        org-use-property-inheritance t            ; it's convenient to have properties inherited
        org-catch-invisible-edits 'smart          ; try not to accidently do weird stuff in invisible regions
        org-log-done 'time                        ; having the time a item is done sounds convenient
        ;;org-roam-directory "~/org/roam/"          ; same thing, for roam

        org-hide-emphasis-markers t
        org-pretty-entities t
        org-auto-align-tags nil
        org-tags-column 0
        org-catch-invisible-edits 'show-and-error
        org-insert-heading-respect-content t

        org-special-ctrl-a/e t
        org-agenda-block-separator ?─

        org-agenda-tags-column 0
        ;;org-agenda-block-separator ?─
        org-agenda-time-grid
        '((daily today require-timed)
          (800 1000 1200 1400 1600 1800 2000)
          " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
        org-agenda-current-time-string
        "⭠ now ─────────────────────────────────────────────────"))

(after! org-modern
  (global-org-modern-mode))

(after! org
  (setq org-src-fontify-natively t
        org-fontify-whole-heading-line t
        org-inline-src-prettify-results '("⟨" . "⟩")
        org-fontify-done-headline t
        org-fontify-quote-and-verse-blocks t))

(after! org
  (setq org-babel-default-header-args
        '((:session . "none")
          (:results . "replace")
          (:exports . "code")
          (:cache . "no")
          (:noweb . "no")
          (:hlines . "no")
          (:tangle . "no")
          (:comments . "link"))))

(after! ox
  (org-link-set-parameters "yt" :export #'+org-export-yt)
  (defun +org-export-yt (path desc backend _com)
    (cond ((org-export-derived-backend-p backend 'html)
           (format "<iframe width='440' \
height='335' \
src='https://www.youtube.com/embed/%s' \
frameborder='0' \
allowfullscreen>%s</iframe>" path (or "" desc)))
          ((org-export-derived-backend-p backend 'latex)
           (format "\\href{https://youtu.be/%s}{%s}" path (or desc "youtube")))
          (t (format "https://youtu.be/%s" path)))))

(custom-set-faces!
  '(org-document-title :height 1.2))

(custom-set-faces!
  '(outline-1 :weight extra-bold :height 1.25)
  '(outline-2 :weight bold :height 1.15)
  '(outline-3 :weight bold :height 1.12)
  '(outline-4 :weight semi-bold :height 1.09)
  '(outline-5 :weight semi-bold :height 1.06)
  '(outline-6 :weight semi-bold :height 1.03)
  '(outline-8 :weight semi-bold)
  '(outline-9 :weight semi-bold))

(use-package! org-modern
  :hook (org-mode . org-modern-mode)
  :config
  (setq org-modern-table-vertical 2
        org-modern-table-horizontal 4
        org-modern-list '((43 . "➤") (45 . "–") (42 . "•"))
        org-modern-footnote (cons nil (cadr org-script-display))
        org-modern-priority t
        org-modern-block t
        org-modern-block-fringe 1
        org-modern-horizontal-rule t)

  ;; Change faces
  (custom-set-faces! '(org-modern-tag :inherit (region org-modern-label)))
  (custom-set-faces! '(org-modern-statistics :inherit org-checkbox-statistics-todo)))

;; Handle collision with Doom ligatures
;;(when (modulep! :ui ligatures)
;;  (defadvice! +org-init-appearance-h--no-ligatures-a ()
;;    :after #'+org-init-appearance-h
;;    (set-ligatures! 'org-mode
;;                    :name nil
;;                    :src_block nil
;;                    :src_block_end nil
;;                    :quote nil
;;                    :quote_end nil)))

(use-package! org-appear
  :hook (org-mode . org-appear-mode)
  :config
  (setq org-appear-autoemphasis t
        org-appear-autosubmarkers t
        org-appear-autolinks nil)
  ;; for proper first-time setup, `org-appear--set-elements'
  ;; needs to be run after other hooks have acted.
  (run-at-time nil nil #'org-appear--set-elements))

;;(use-package! org-ol-tree :commands org-ol-tree)

;;(map! :map org-mode-map
;;      :after org
;;      :localleader
;;      :desc "Outline" "O" #'org-ol-tree)

(map! :map evil-org-mode-map
      :after evil-org
      :n "g <up>" #'org-backward-heading-same-level
      :n "g <down>" #'org-forward-heading-same-level
      :n "g <left>" #'org-up-element
      :n "g <right>" #'org-down-element)

;; Prettier labels for ROAM docs
(defvar org-reference-contraction-max-words 3
  "Maximum number of words in a reference reference.")
(defvar org-reference-contraction-max-length 35
  "Maximum length of resulting reference reference, including joining characters.")
(defvar org-reference-contraction-stripped-words
  '("the" "on" "in" "off" "a" "for" "by" "of" "and" "is" "to")
  "Superfluous words to be removed from a reference.")
(defvar org-reference-contraction-joining-char "-"
  "Character used to join words in the reference reference.")

(defun org-reference-contraction-truncate-words (words)
  "Using `org-reference-contraction-max-length' as the total character 'budget' for the WORDS
and truncate individual words to conform to this budget.

To arrive at a budget that accounts for words undershooting their requisite average length,
the number of characters in the budget freed by short words is distributed among the words
exceeding the average length.  This adjusts the per-word budget to be the maximum feasable for
this particular situation, rather than the universal maximum average.

This budget-adjusted per-word maximum length is given by the mathematical expression below:

max length = \\floor{ \\frac{total length - chars for seperators - \\sum_{word \\leq average length} length(word) }{num(words) > average length} }"
  ;; trucate each word to a max word length determined by
  ;;
  (let* ((total-length-budget (- org-reference-contraction-max-length  ; how many non-separator chars we can use
                                 (1- (length words))))
         (word-length-budget (/ total-length-budget                      ; max length of each word to keep within budget
                                org-reference-contraction-max-words))
         (num-overlong (-count (lambda (word)                            ; how many words exceed that budget
                                 (> (length word) word-length-budget))
                               words))
         (total-short-length (-sum (mapcar (lambda (word)                ; total length of words under that budget
                                             (if (<= (length word) word-length-budget)
                                                 (length word) 0))
                                           words)))
         (max-length (/ (- total-length-budget total-short-length)       ; max(max-length) that we can have to fit within the budget
                        num-overlong)))
    (mapcar (lambda (word)
              (if (<= (length word) max-length)
                  word
                (substring word 0 max-length)))
            words)))

(defun org-reference-contraction (reference-string)
  "Give a contracted form of REFERENCE-STRING that is only contains alphanumeric characters.
Strips 'joining' words present in `org-reference-contraction-stripped-words',
and then limits the result to the first `org-reference-contraction-max-words' words.
If the total length is > `org-reference-contraction-max-length' then individual words are
truncated to fit within the limit using `org-reference-contraction-truncate-words'."
  (let ((reference-words
         (-filter (lambda (word)
                    (not (member word org-reference-contraction-stripped-words)))
                  (split-string
                   (->> reference-string
                        downcase
                        (replace-regexp-in-string "\\[\\[[^]]+\\]\\[\\([^]]+\\)\\]\\]" "\\1") ; get description from org-link
                        (replace-regexp-in-string "[-/ ]+" " ") ; replace seperator-type chars with space
                        puny-encode-string
                        (replace-regexp-in-string "^xn--\\(.*?\\) ?-?\\([a-z0-9]+\\)$" "\\2 \\1") ; rearrange punycode
                        (replace-regexp-in-string "[^A-Za-z0-9 ]" "") ; strip chars which need %-encoding in a uri
                        ) " +"))))
    (when (> (length reference-words)
             org-reference-contraction-max-words)
      (setq reference-words
            (cl-subseq reference-words 0 org-reference-contraction-max-words)))

    (when (> (apply #'+ (1- (length reference-words))
                    (mapcar #'length reference-words))
             org-reference-contraction-max-length)
      (setq reference-words (org-reference-contraction-truncate-words reference-words)))

    (string-join reference-words org-reference-contraction-joining-char)))

(defun unpackaged/org-element-descendant-of (type element)
  "Return non-nil if ELEMENT is a descendant of TYPE.
TYPE should be an element type, like `item' or `paragraph'.
ELEMENT should be a list like that returned by `org-element-context'."
  ;; MAYBE: Use `org-element-lineage'.
  (when-let* ((parent (org-element-property :parent element)))
    (or (eq type (car parent))
        (unpackaged/org-element-descendant-of type parent))))

;;;###autoload
(defun unpackaged/org-return-dwim (&optional default)
  "A helpful replacement for `org-return-indent'.  With prefix, call `org-return-indent'.

On headings, move point to position after entry content.  In
lists, insert a new item or end the list, with checkbox if
appropriate.  In tables, insert a new row or end the table."
  ;; Inspired by John Kitchin: http://kitchingroup.cheme.cmu.edu/blog/2017/04/09/A-better-return-in-org-mode/
  (interactive "P")
  (if default
      (org-return t)
    (cond
     ;; Act depending on context around point.

     ;; NOTE: I prefer RET to not follow links, but by uncommenting this block, links will be
     ;; followed.

     ;; ((eq 'link (car (org-element-context)))
     ;;  ;; Link: Open it.
     ;;  (org-open-at-point-global))

     ((org-at-heading-p)
      ;; Heading: Move to position after entry content.
      ;; NOTE: This is probably the most interesting feature of this function.
      (let ((heading-start (org-entry-beginning-position)))
        (goto-char (org-entry-end-position))
        (cond ((and (org-at-heading-p)
                    (= heading-start (org-entry-beginning-position)))
               ;; Entry ends on its heading; add newline after
               (end-of-line)
               (insert "\n"))
              (t
               ;; Entry ends after its heading; back up
               (forward-line -1)
               (end-of-line)
               (when (org-at-heading-p)
                 ;; At the same heading
                 (forward-line)
                 (insert "\n")
                 (forward-line -1))
               (while (not (looking-back "\\(?:[[:blank:]]?\n\\)\\{3\\}" nil))
                 (insert "\n"))
               (forward-line -1)))))

     ((org-at-item-checkbox-p)
      ;; Checkbox: Insert new item with checkbox.
      (org-insert-todo-heading nil))

     ((org-in-item-p)
      ;; Plain list.  Yes, this gets a little complicated...
      (let ((context (org-element-context)))
        (if (or (eq 'plain-list (car context))  ; First item in list
                (and (eq 'item (car context))
                     (not (eq (org-element-property :contents-begin context)
                              (org-element-property :contents-end context))))
                (unpackaged/org-element-descendant-of 'item context))  ; Element in list item, e.g. a link
            ;; Non-empty item: Add new item.
            (org-insert-item)
          ;; Empty item: Close the list.
          ;; TODO: Do this with org functions rather than operating on the text. Can't seem to find the right function.
          (delete-region (line-beginning-position) (line-end-position))
          (insert "\n"))))

     ((when (fboundp 'org-inlinetask-in-task-p)
        (org-inlinetask-in-task-p))
      ;; Inline task: Don't insert a new heading.
      (org-return t))

     ((org-at-table-p)
      (cond ((save-excursion
               (beginning-of-line)
               ;; See `org-table-next-field'.
               (cl-loop with end = (line-end-position)
                        for cell = (org-element-table-cell-parser)
                        always (equal (org-element-property :contents-begin cell)
                                      (org-element-property :contents-end cell))
                        while (re-search-forward "|" end t)))
             ;; Empty row: end the table.
             (delete-region (line-beginning-position) (line-end-position))
             (org-return t))
            (t
             ;; Non-empty row: call `org-return-indent'.
             (org-return t))))
     (t
      ;; All other cases: call `org-return-indent'.
      (org-return t)))))

(map!
 :after evil-org
 :map evil-org-mode-map
 :i [return] #'unpackaged/org-return-dwim)

(use-package org-projectile
  :bind (("C-c n p" . org-projectile-project-todo-completing-read)
         ("C-c c" . org-capture))
  :config
  (progn
    (setq org-projectile-projects-file "~/org/projectile.org")
    (setq org-agenda-files (append org-agenda-files (org-projectile-todo-files)))
    (push (org-projectile-project-todo-entry) org-capture-templates))
  :ensure t)

(add-hook! 'elfeed-search-mode-hook #'elfeed-update)

(after! org
  (setq org-agenda-deadline-faces
        '((1.0 . error)
          (1.0 . org-warning)
          (0.5 . org-upcoming-deadline)
          (0.0 . org-upcoming-distant-deadline))))

(use-package! org-appear
  :after org
  :hook (org-mode . org-appear-mode)
  :config
  (setq org-appear-autoemphasis t
        org-appear-autolinks t
        org-appear-autosubmarkers t))

(setq org-export-with-sub-superscripts '{})

(after! org
  (setq org-latex-text-markup-alist
        '((bold . "\\textbf{%s}")
          (code . protectedtexttt)
          (italic . "\\emph{%s}")
          (strike-through . "\\sout{%s}")
          (underline . "\\uline{%s}")
          (verbatim . verb))))
