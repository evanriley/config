;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Evan Riley"
      user-mail-address "git@evanriley.dev")


(setq auth-sources '("~/.authinfo.gpg")
      auth-source-cache-expiry nil)

(cond (IS-MAC
       (setq mac-command-modifier       'meta
             mac-option-modifier        'alt
             mac-right-option-modifier  'alt)))

(when (eq system-type 'darwin) (ns-auto-titlebar-mode))

(setq-default
 delete-by-moving-to-trash t
 window-combination-resize t
 x-stretch-cursor t
 truncate-lines nil)

(setq undo-limit 8000000
      evil-want-fine-undo t)

(setq auto-save-default t
      make-backup-files t)

(setq password-cache-expiry nil)

(display-time-mode 1)
(global-subword-mode 1)

(setq display-line-numbers-type t)

(setq org-directory "~/Documents/Notes/")
(setq org-roam-directory "~/Documents/Notes/")

(setq evil-vsplit-window-right t
      evil-split-window-below t)

(defadvice! prompt-for-buffer (&rest)
  :after '(evil-window-split evil-window-vsplit)
  (+ivy/switch-buffer))


(setq doom-theme 'doom-flatwhite)

(setq
 doom-font (font-spec :family "JuliaMono" :size 16)
 doom-big-font (font-spec :family "JuliaMono" :size 36)
 doom-variable-pitch-font (font-spec :family "JuliaMono" :size 16)
 doom-serif-font (font-spec :family "JuliaMono" :weight 'light))

(custom-set-faces!
  `(org-block :background ,(doom-darken 'bg 0.3)))
(custom-set-faces!
  `(org-block-begin-line :background ,(doom-darken 'bg 0.2)))
(custom-set-faces!
  `(org-block-end-line :background ,(doom-darken 'bg 0.2)))

(defun doom-modeline-conditional-buffer-encoding ()
  (setq-local doom-modeline-buffer-encoding
        (unless (and (memq (plist-get (coding-system-plist buffer-file-coding-system) :category)
                           '(coding-category-undecided coding-category-utf-8))
                     (not (memq (coding-system-eol-type buffer-file-coding-system) '(1 2))))
          t)))


(add-hook 'after-change-major-mode-hook #'doom-modeline-conditional-buffer-encoding)

(setq doom-fallback-buffer-name "► Doom"
      +doom-dashboard-name "► Doom")
(map! :map +doom-dashboard-mode-map
      :ne "f" #'find-file
      :ne "r" #'consult-recent-file
      :ne "p" #'doom/open-private-config
      :ne "c" (cmd! (find-file (expand-file-name "config.org" doom-private-dir)))
      :ne "." (cmd! (doom-project-find-file "~/.config/")) ; . for dotfiles
      :ne "b" #'+vertico/switch-workspace-buffer
      :ne "B" #'consult-buffer
      :ne "q" #'save-buffers-kill-terminal)

(map! :n [mouse-8] #'better-jumper-jump-backward
      :n [mouse-9] #'better-jumper-jump-forward)

(setq frame-title-format
      '(""
        (:eval
         (if (s-contains-p org-roam-directory (or buffer-file-name ""))
             (replace-regexp-in-string
              ".*/[0-9]*-?" "☰ "
              (subst-char-in-string ?_ ?  buffer-file-name))
           "%b"))
        (:eval
         (let ((project-name (projectile-project-name)))
           (unless (string= "-" project-name)
             (format (if (buffer-modified-p)  " ◉ %s" "  ●  %s") project-name))))))


(defun doom-dashboard-draw-ascii-emacs-banner-fn ()
  (let* ((banner
          '(",---.,-.-.,---.,---.,---."
            "|---'| | |,---||    `---."
            "`---'` ' '`---^`---'`---'"))
         (longest-line (apply #'max (mapcar #'length banner))))
    (put-text-property
     (point)
     (dolist (line banner (point))
       (insert (+doom-dashboard--center
                +doom-dashboard--width
                (concat
                 line (make-string (max 0 (- longest-line (length line)))
                                   32)))
               "\n"))
     'face 'doom-dashboard-banner)))

(setq +doom-dashboard-ascii-banner-fn #'doom-dashboard-draw-ascii-emacs-banner-fn)


(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
(add-hook! '+doom-dashboard-mode-hook (hide-mode-line-mode 1) (hl-line-mode -1))
(setq-hook! '+doom-dashboard-mode-hook evil-normal-state-cursor (list nil))


(setq which-key-idle-delay 0.5)

(setq which-key-allow-multiple-replacements t)
(after! which-key
  (pushnew!
   which-key-replacement-alist
   '(("" . "\\`+?evil[-:]?\\(?:a-\\)?\\(.*\\)") . (nil . "◂\\1"))
   '(("\\`g s" . "\\`evilem--?motion-\\(.*\\)") . (nil . "◃\\1"))
   ))

(after! company
  (setq +lsp-company-backends '(company-tabnine :separate company-capf company-yasnippet))
  (setq company-show-numbers t)
  (setq company-idle-delay 0))

(after! company
  (setq company-show-quick-access t))

(setq eros-eval-result-prefix "⟹ ")

(setq yas-triggers-in-field t)

(sp-local-pair
 '(org-mode)
 "<<" ">>"
 :actions '(insert))

(add-to-list 'auto-mode-alist '("\\.tmpl\\'" . web-mode))
(setq web-mode-engines-alist
      '(("go"    . "\\.gohtml\\'")
        ("go"    . "\\.gotmpl\\'")
        ("go"    . "\\.tmpl\\'")))

(setq org-src-fontify-natively t)
;; Hide Org Markup Indicators
(after! org (setq org-hide-emphasis-markers t))
;; Insert Org Headings At Point.
(after! org (setq org-insert-heading-respect-content nil))

;; start the initial frame maximized
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

(setq lsp-signature-auto-activate nil)
(setq lsp-lens-enable nil)

(setq lsp-rust-analyzer-server-display-inlay-hints t)
(setq lsp-rust-analyzer-inlay-hints-mode t)
