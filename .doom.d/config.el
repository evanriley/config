;; My user information
(setq user-full-name "Evan Riley"
      user-mail-address "evanriley@hey.com")
;; Change the Mac Modifiers to be better
(cond (IS-MAC
         (setq mac-command-modifier      'meta
               mac-option-modifier       'alt
               mac-right-option-modifier 'alt)))


;; Enable auto-save and backup files
(setq auto-save-default t
      make-backup-files t)

;; Path settings that sometimes decide not to work
(add-to-list 'exec-path "/opt/homebrew/bin/lein")

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

;; Simple ascii emacs banner
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

;; Remove doom-dashboard links...I've literally never used one on purpose.
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
(add-hook! '+doom-dashboard-mode-hook (hide-mode-line-mode 1) (hl-line-mode -1))
(setq-hook! '+doom-dashboard-mode-hook evil-normal-state-cursor (list nil))

;; Set fonts
(setq
 doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 16)
 doom-big-font (font-spec :family "JetBrainsMono Nerd Font" :size 36)
 doom-variable-pitch-font (font-spec :fammily "Overpass" :size 16)
 doom-serif-font (font-spec :family "IBM Plex Mono" :weight 'light))


;; Set theme
;;(setq doom-theme 'doom-wilmersdorf)
;; (setq doom-theme 'doom-city-lights)
;; (setq doom-theme 'doom-acario-light)
;; (setq doom-theme 'doom-tomorrow-day)
;; (setq doom-theme 'doom-opera-light)
;; (setq doom-theme 'doom-horizon)
;; (setq doom-theme 'doom-challenger-deep)
;; (setq doom-theme 'doom-gruvbox)
;; (setq doom-theme 'doom-xcode)
;; (setq doom-theme 'doom-sourcerer)
(setq doom-theme 'doom-tokyo-night)
;; (setq doom-theme 'doom-rouge)

;; Modeline Settings
(defun doom-modeline-conditional-buffer-encoding ()
  (setq-local doom-modeline-buffer-encoding
        (unless (and (memq (plist-get (coding-system-plist buffer-file-coding-system) :category)
                           '(coding-category-undecided coding-category-utf-8))
                     (not (memq (coding-system-eol-type buffer-file-coding-system) '(1 2))))
          t)))

(add-hook 'after-change-major-mode-hook #'doom-modeline-conditional-buffer-encoding)


;; Window title
(setq frame-title-format
      '(""
        (:eval
         (if (s-contains-p org-roam-directory (or buffer-file-name ""))
             (replace-regexp-in-string
              ".*/[0-9]*-?" "☰ "
              (subst-char-in-string ?_ ? buffer-file-name))
           "%b"))
        (:eval
         (let ((project-name (projectile-project-name)))
           (unless (string= "-" project-name)
             (format (if (buffer-modified-p) " ◉ %s" "  ●  %s") project-name))))))

;; Simple Settings/Better Defaults
(setq-default
 delete-by-moving-to-trash t
 window-combination-resize t
 x-stretch-cursor t)

(setq password-cache-expiry nil)

(setq undo-limit 8000000
      evil-want-fine-undo t)

(display-time-mode 1)
(global-subword-mode 1)

;; Ask which buffer I want to see after splitting window.
(setq evil-vsplit-window-right t
      evil-split-window-below t)

(defadvice! prompt-for-buffer (&rest)
  :after '(evil-window-split evil-window-vsplit)
  (+ivy/switch-buffer))

(setq +ivy-buffer-preview

;; Use SPC w for window rotation
 (map! :map evil-window-map
      "SPC" #'rotate-layout
      ;; Navigation
      "<left>"     #'evil-window-left
      "<down>"     #'evil-window-down
      "<up>"       #'evil-window-up
      "<right>"    #'evil-window-right
      ;; Swapping windows
      "C-<left>"       #'+evil/window-move-left
      "C-<down>"       #'+evil/window-move-down
      "C-<up>"         #'+evil/window-move-up
      "C-<right>"      #'+evil/window-move-right))
;; Set directory for org
(setq
 org-directory "~/Code/org/")

;; Setup Org-Roam
(use-package! org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/Code/org/notes")
  (org-roam-complete-everywhere t)
  :config
  (org-roam-db-autosync-mode))

;; Org mode code block syntax highlighting
(setq org-src-fontify-natively t)

;; Hide Org Markup Indicators
(after! org (setq org-hide-emphasis-markers t))

;; Insert Org Headings At Point.
(after! org (setq org-insert-heading-respect-content nil))

;; Nested YASnippet
(setq yas-triggers-in-field t)

;; Magit Settings
(setq +magit-hub-features t)

;; General LSP Settings
;; (after! lsp-ui
;;   (setq lsp-ui-sideline-enable nil)
;;   (setq lsp-ui-doc-show-with-cursor nil)
;;   (setq lsp-ui-doc-show-with-mouse t))


;; Start pinentry on launch
(pinentry-start)

;; Tree Sitter
;; (use-package! tree-sitter
;;   :config
;;   (require 'tree-sitter-langs)
;;   (global-tree-sitter-mode)
;;   (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

;; Direnv
(use-package! direnv
  :config
  (direnv-mode))

;; email settings
(after! mu4e
 (setq sendmail-program (executable-find "msmtp")
       send-mail-function #'smtpmail-send-it
       message-sendmail-f-is-evil t
       message-sendmail-extra-arguments '("--read-envelope-from")
       message-send-mail-function #'message-send-mail-with-sendmail))

(setq mu4e-get-mail-command (concat (executable-find "mbsync") " -a"))

(set-email-account! "evan@riley.industires"
  '((mu4e-sent-folder       . "/icloud/Sent Messages")
    (mu4e-drafts-folder     . "/icloud/Drafts")
    (mu4e-trash-folder      . "/icloud/Deleted Messages")
    (mu4e-refile-folder     . "/icloud/Archive")
    (smtpmail-smtp-user     . "evancriley")
    (user-mail-address      . "evan@riley.industries")    ;; only needed for mu < 1.4
    (mu4e-compose-signature . "---\nEvan Riley"))
  t)

(set-email-account! "me@evanriley.me"
  '((mu4e-sent-folder       . "/fastmail/Sent")
    (mu4e-drafts-folder     . "/fastmail/Drafts")
    (mu4e-trash-folder      . "/fastmail/Trash")
    (mu4e-refile-folder     . "/fastmail/Archive")
    (smtpmail-smtp-user     . "me@evanriley.me")
    (user-mail-address      . "me@evanriley.me")    ;; only needed for mu < 1.4
    (mu4e-compose-signature . "---\nEvan Riley"))
  t)

(setq   mu4e-maildir-shortcuts
        '(("/icloud/INBOX" . ?i)
          ("/icloud/Sent Messages" . ?I)
          ("/fastmail/INBOX" . ?f)
          ("/fastmail/Sent" . ?F)))

;; screenshot settings
;; Currently doesn't work on macOS Sadge
;; (use-package! screenshot
;;   :defer t
;;   :config (setq screenshot-upload-fn "upload %s 2>/dev/null"))

;; For Go
(add-to-list 'auto-mode-alist '("\\.tmpl\\'" . web-mode))
(setq web-mode-engines-alist
      '(("go"    . "\\.gohtml\\'")
        ("go"    . "\\.gotmpl\\'")
        ("go"    . "\\.tmpl\\'")))

;; For Parinfer
(setq parinfer-rust-library "~/.emacs.d/.local/etc/parinfer-rust/parinfer-rust-darwin.so")

;; For Lisp
(load (expand-file-name "~/.roswell/helper.el"))

;; Tabnine
(use-package! company-tabnine
  :after company
  :config
  (cl-pushnew 'company-tabnine (default-value 'company-backends)))
