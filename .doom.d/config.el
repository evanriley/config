;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Place M-x customize out of side of init.el
(setq-default custom-file (expand-file-name ".custom.el" doom-private-dir))
(when (file-exists-p custom-file)
  (load custom-file))

;; Some better defaults
(setq scroll-margin 2
      auto-save-default t
      display-line-numbers-type 'relative
      delete-by-moving-to-trash t
      truncate-string-ellipsis "…"
      browse-url-browser-function 'xwidget-webkit-browse-url)

(fringe-mode 0)
(global-subword-mode 1)


;; Tell Emacs who I am
(setq user-full-name "Evan Riley"
      user-mail-address "evan@evanriley.dev")

;; Better Window Mangement
(setq evil-vsplit-window-right t
      evil-split-window-below t)
(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (consult-buffer))

;; If the process exits, kill the vterm buffer
(setq vterm-kill-buffer-on-exit t)

;; Set fonts
(setq doom-font (font-spec :family "JuliaMono" :size 16)
      doom-big-font (font-spec :family "JuliaMono" :size 20)
      doom-variable-pitch-font (font-spec :family "IBM Plex Sans" :size 16)
      doom-unicode-font (font-spec :family "JuliaMono")
      doom-serif-font (font-spec :family "IBM Plex Sans" :size 16 :weight 'medium))

;; Make the LSP behave
(after! lsp-mode
  (setq lsp-enable-symbol-highlighting nil))

(after! lsp-ui
  (setq lsp-ui-sideline-enable nil  ; no more useful than flycheck
        lsp-ui-doc-enable nil))     ; redundant with K

;; Make s/../.. assume a /g at the end
(after! evil
  (setq evil-ex-substitute-global t     ; I like my s/../.. to by global by default
        evil-move-cursor-back nil       ; Don't move the block cursor when toggling insert mode
        evil-kill-on-visual-paste nil)) ; Don't put overwritten text in the kill ring
;; Remove the evil prefix from which key
(setq which-key-allow-multiple-replacements t
      which-key-idle-delay 0.5) ;; I need the help, I really do
(after! which-key
  (pushnew!
   which-key-replacement-alist
   '(("" . "\\`+?evil[-:]?\\(?:a-\\)?\\(.*\\)") . (nil . " \\1"))
   '(("\\`g s" . "\\`evilem--?motion-\\(.*\\)") . (nil . " \\1"))))

;; Use magit delta.
(after! magit
  (magit-delta-mode +1))

;; Simpler, cleaner dashboard
(setq fancy-splash-image (expand-file-name "misc/splash-images/emacs-e-template.svg" doom-private-dir)
      +doom-dashboard-banner-padding '(0 . 0))

(defvar splash-phrase-source-folder
  (expand-file-name "misc/splash-phrases" doom-private-dir)
  "A folder of text files with a fun phrase on each line.")

(defvar splash-phrase-sources
  (let* ((files (directory-files splash-phrase-source-folder nil "\\.txt\\'"))
         (sets (delete-dups (mapcar
                             (lambda (file)
                               (replace-regexp-in-string "\\(?:-[0-9]+-\\w+\\)?\\.txt" "" file))
                             files))))
    (mapcar (lambda (sset)
              (cons sset
                    (delq nil (mapcar
                               (lambda (file)
                                 (when (string-match-p (regexp-quote sset) file)
                                   file))
                               files))))
            sets))
  "A list of cons giving the phrase set name, and a list of files which contain phrase components.")

(defvar splash-phrase-set
  (nth (random (length splash-phrase-sources)) (mapcar #'car splash-phrase-sources))
  "The default phrase set. See `splash-phrase-sources'.")

(defun splase-phrase-set-random-set ()
  "Set a new random splash phrase set."
  (interactive)
  (setq splash-phrase-set
        (nth (random (1- (length splash-phrase-sources)))
             (cl-set-difference (mapcar #'car splash-phrase-sources) (list splash-phrase-set))))
  (+doom-dashboard-reload t))

(defvar splase-phrase--cache nil)

(defun splash-phrase-get-from-file (file)
  "Fetch a random line from FILE."
  (let ((lines (or (cdr (assoc file splase-phrase--cache))
                   (cdar (push (cons file
                                     (with-temp-buffer
                                       (insert-file-contents (expand-file-name file splash-phrase-source-folder))
                                       (split-string (string-trim (buffer-string)) "\n")))
                               splase-phrase--cache)))))
    (nth (random (length lines)) lines)))

(defun splash-phrase (&optional set)
  "Construct a splash phrase from SET. See `splash-phrase-sources'."
  (mapconcat
   #'splash-phrase-get-from-file
   (cdr (assoc (or set splash-phrase-set) splash-phrase-sources))
   " "))

(defun doom-dashboard-phrase ()
  "Get a splash phrase, flow it over multiple lines as needed, and make fontify it."
  (mapconcat
   (lambda (line)
     (+doom-dashboard--center
      +doom-dashboard--width
      (with-temp-buffer
        (insert-text-button
         line
         'action
         (lambda (_) (+doom-dashboard-reload t))
         'face 'doom-dashboard-menu-title
         'mouse-face 'doom-dashboard-menu-title
         'help-echo "Random phrase"
         'follow-link t)
        (buffer-string))))
   (split-string
    (with-temp-buffer
      (insert (splash-phrase))
      (setq fill-column (min 70 (/ (* 2 (window-width)) 3)))
      (fill-region (point-min) (point-max))
      (buffer-string))
    "\n")
   "\n"))

(defadvice! doom-dashboard-widget-loaded-with-phrase ()
  :override #'doom-dashboard-widget-loaded
  (setq line-spacing 0.2)
  (insert
   "\n\n"
   (propertize
    (+doom-dashboard--center
     +doom-dashboard--width
     (doom-display-benchmark-h 'return))
    'face 'doom-dashboard-loaded)
   "\n"
   (doom-dashboard-phrase)
   "\n"))

;; remove useless dashboard info
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
(add-hook! '+doom-dashboard-mode-hook (hide-mode-line-mode 1) (hl-line-mode -1))
(setq-hook! '+doom-dashboard-mode-hook evil-normal-state-cursor (list nil))

;; Info Colors
(use-package! info-colors
  :commands (info-colors-fontify-node))

(add-hook 'Info-selection-hook 'info-colors-fontify-node)

;; Clean Up Marginalia
(after! marginalia
  (setq marginalia--ellipsis "…"    ; Nicer ellipsis
        marginalia-align 'right     ; right alignment
        marginalia-align-offset -1)) ; one space on the right

;; Doom Mode Line
(after! doom-modeline
  (doom-modeline-def-segment buffer-name
    "Display the current buffer's name, without any other information."
    (concat
     (doom-modeline-spc)
     (doom-modeline--buffer-name)))

  (doom-modeline-def-segment pdf-icon
    "PDF icon from all-the-icons."
    (concat
     (doom-modeline-spc)
     (doom-modeline-icon 'octicon "file-pdf" nil nil
                         :face (if (doom-modeline--active)
                                   'all-the-icons-red
                                 'mode-line-inactive)
                         :v-adjust 0.02)))

  (defun doom-modeline-update-pdf-pages ()
    "Update PDF pages."
    (setq doom-modeline--pdf-pages
          (let ((current-page-str (number-to-string (eval `(pdf-view-current-page))))
                (total-page-str (number-to-string (pdf-cache-number-of-pages))))
            (concat
             (propertize
              (concat (make-string (- (length total-page-str) (length current-page-str)) ? )
                      " P" current-page-str)
              'face 'mode-line)
             (propertize (concat "/" total-page-str) 'face 'doom-modeline-buffer-minor-mode)))))

  (doom-modeline-def-segment pdf-pages
    "Display PDF pages."
    (if (doom-modeline--active) doom-modeline--pdf-pages
      (propertize doom-modeline--pdf-pages 'face 'mode-line-inactive)))

  (doom-modeline-def-modeline 'pdf
    '(bar window-number pdf-pages pdf-icon buffer-name)
    '(misc-info matches major-mode process vcs)))

(custom-set-faces!
  '(doom-modeline-buffer-modified :foreground "orange"))


(defun doom-modeline-conditional-buffer-encoding ()
  "We expect the encoding to be LF UTF-8, so only show the modeline when this is not the case"
  (setq-local doom-modeline-buffer-encoding
              (unless (and (memq (plist-get (coding-system-plist buffer-file-coding-system) :category)
                                 '(coding-category-undecided coding-category-utf-8))
                           (not (memq (coding-system-eol-type buffer-file-coding-system) '(1 2))))
                t)))

(add-hook 'after-change-major-mode-hook #'doom-modeline-conditional-buffer-encoding)

;; Theme
(setq doom-theme 'doom-molokai)

;; Replace org-modern, some what heavier but looks way better.
(use-package svg-tag-mode
  :commands svg-tag-mode
  :config
  (defconst date-re "[0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\}")
  (defconst time-re "[0-9]\\{2\\}:[0-9]\\{2\\}")
  (defconst day-re "[A-Za-z]\\{3\\}")
  (defconst day-time-re (format "\\(%s\\)? ?\\(%s\\)?" day-re time-re))

  (defun svg-progress-percent (value)
    (svg-image (svg-lib-concat
                (svg-lib-progress-bar (/ (string-to-number value) 100.0)
                                  nil :margin 0 :stroke 2 :radius 3 :padding 2 :width 11)
                (svg-lib-tag (concat value "%")
                             nil :stroke 0 :margin 0)) :ascent 'center))

  (defun svg-progress-count (value)
    (let* ((seq (mapcar #'string-to-number (split-string value "/")))
           (count (float (car seq)))
           (total (float (cadr seq))))
    (svg-image (svg-lib-concat
                (svg-lib-progress-bar (/ count total) nil
                                      :margin 0 :stroke 2 :radius 3 :padding 2 :width 11)
                (svg-lib-tag value nil
                             :stroke 0 :margin 0)) :ascent 'center)))

  (setq svg-tag-tags
        `(
          ;; Org tags
          (":\\([A-Za-z0-9]+\\)" . ((lambda (tag) (svg-tag-make tag))))
          (":\\([A-Za-z0-9]+[ \-]\\)" . ((lambda (tag) tag)))

          ;; Task priority
          ("\\[#[A-Z]\\]" . ( (lambda (tag)
                                (svg-tag-make tag :face 'org-priority
                                              :beg 2 :end -1 :margin 0))))

          ;; Progress
          ("\\(\\[[0-9]\\{1,3\\}%\\]\\)" . ((lambda (tag)
                                              (svg-progress-percent (substring tag 1 -2)))))
          ("\\(\\[[0-9]+/[0-9]+\\]\\)" . ((lambda (tag)
                                            (svg-progress-count (substring tag 1 -1)))))

          ;; TODO / DONE
          ("TODO" . ((lambda (tag) (svg-tag-make "TODO" :face 'org-todo :inverse t :margin 0))))
          ("DONE" . ((lambda (tag) (svg-tag-make "DONE" :face 'org-done :margin 0))))


          ;; Citation of the form [cite:@Knuth:1984]
          ("\\(\\[cite:@[A-Za-z]+:\\)" . ((lambda (tag)
                                            (svg-tag-make tag
                                                          :inverse t
                                                          :beg 7 :end -1
                                                          :crop-right t))))
          ("\\[cite:@[A-Za-z]+:\\([0-9]+\\]\\)" . ((lambda (tag)
                                                  (svg-tag-make tag
                                                                :end -1
                                                                :crop-left t))))


          ;; Active date (with or without day name, with or without time)
          (,(format "\\(<%s>\\)" date-re) .
           ((lambda (tag)
              (svg-tag-make tag :beg 1 :end -1 :margin 0))))
          (,(format "\\(<%s \\)%s>" date-re day-time-re) .
           ((lambda (tag)
              (svg-tag-make tag :beg 1 :inverse nil :crop-right t :margin 0))))
          (,(format "<%s \\(%s>\\)" date-re day-time-re) .
           ((lambda (tag)
              (svg-tag-make tag :end -1 :inverse t :crop-left t :margin 0))))

          ;; Inactive date  (with or without day name, with or without time)
           (,(format "\\(\\[%s\\]\\)" date-re) .
            ((lambda (tag)
               (svg-tag-make tag :beg 1 :end -1 :margin 0 :face 'org-date))))
           (,(format "\\(\\[%s \\)%s\\]" date-re day-time-re) .
            ((lambda (tag)
               (svg-tag-make tag :beg 1 :inverse nil :crop-right t :margin 0 :face 'org-date))))
           (,(format "\\[%s \\(%s\\]\\)" date-re day-time-re) .
            ((lambda (tag)
               (svg-tag-make tag :end -1 :inverse t :crop-left t :margin 0 :face 'org-date)))))))


;;  RIP Google Reader.
(map! :map elfeed-search-mode-map
      :after elfeed-search
      [remap kill-this-buffer] "q"
      [remap kill-buffer] "q"
      :n doom-leader-key nil
      :n "q" #'+rss/quit
      :n "e" #'elfeed-update
      :n "r" #'elfeed-search-untag-all-unread
      :n "u" #'elfeed-search-tag-all-unread
      :n "s" #'elfeed-search-live-filter
      :n "RET" #'elfeed-search-show-entry
      :n "p" #'elfeed-show-pdf
      :n "+" #'elfeed-search-tag-all
      :n "-" #'elfeed-search-untag-all
      :n "S" #'elfeed-search-set-filter
      :n "b" #'elfeed-search-browse-url
      :n "y" #'elfeed-search-yank)
(map! :map elfeed-show-mode-map
      :after elfeed-show
      [remap kill-this-buffer] "q"
      [remap kill-buffer] "q"
      :n doom-leader-key nil
      :nm "q" #'+rss/delete-pane
      :nm "o" #'ace-link-elfeed
      :nm "RET" #'org-ref-elfeed-add
      :nm "n" #'elfeed-show-next
      :nm "N" #'elfeed-show-prev
      :nm "p" #'elfeed-show-pdf
      :nm "+" #'elfeed-show-tag
      :nm "-" #'elfeed-show-untag
      :nm "s" #'elfeed-show-new-live-search
      :nm "y" #'elfeed-show-yank)

(after! elfeed-search
  (set-evil-initial-state! 'elfeed-search-mode 'normal))
(after! elfeed-show-mode
  (set-evil-initial-state! 'elfeed-show-mode   'normal))

(after! evil-snipe
  (push 'elfeed-show-mode   evil-snipe-disabled-modes)
  (push 'elfeed-search-mode evil-snipe-disabled-modes))

(after! elfeed
  (elfeed-org)
  (use-package! elfeed-link)
  (setq rmh-elfeed-org-files '("~/org/elfeed.org"))

  (setq elfeed-search-filter "@1-week-ago +unread"
        elfeed-search-print-entry-function '+rss/elfeed-search-print-entry
        elfeed-search-title-min-width 80
        elfeed-show-entry-switch #'pop-to-buffer
        elfeed-show-entry-delete #'+rss/delete-pane
        elfeed-show-refresh-function #'+rss/elfeed-show-refresh--better-style
        shr-max-image-proportion 0.6)

  (add-hook! 'elfeed-show-mode-hook (hide-mode-line-mode 1))
  (add-hook! 'elfeed-search-update-hook #'hide-mode-line-mode)

  (defface elfeed-show-title-face '((t (:weight ultrabold :slant italic :height 1.5)))
    "title face in elfeed show buffer"
    :group 'elfeed)
  (defface elfeed-show-author-face `((t (:weight light)))
    "title face in elfeed show buffer"
    :group 'elfeed)
  (set-face-attribute 'elfeed-search-title-face nil
                      :foreground 'nil
                      :weight 'light)

  (defadvice! +rss-elfeed-wrap-h-nicer ()
    "Enhances an elfeed entry's readability by wrapping it to a width of
`fill-column' and centering it with `visual-fill-column-mode'."
    :override #'+rss-elfeed-wrap-h
    (setq-local truncate-lines nil
                shr-width 120
                visual-fill-column-center-text t
                default-text-properties '(line-height 1.1))
    (let ((inhibit-read-only t)
          (inhibit-modification-hooks t))
      (visual-fill-column-mode)
      ;; (setq-local shr-current-font '(:family "Merriweather" :height 1.2))
      (set-buffer-modified-p nil)))

  (defun +rss/elfeed-search-print-entry (entry)
    "Print ENTRY to the buffer."
    (let* ((elfeed-goodies/tag-column-width 40)
           (elfeed-goodies/feed-source-column-width 30)
           (title (or (elfeed-meta entry :title) (elfeed-entry-title entry) ""))
           (title-faces (elfeed-search--faces (elfeed-entry-tags entry)))
           (feed (elfeed-entry-feed entry))
           (feed-title
            (when feed
              (or (elfeed-meta feed :title) (elfeed-feed-title feed))))
           (tags (mapcar #'symbol-name (elfeed-entry-tags entry)))
           (tags-str (concat (mapconcat 'identity tags ",")))
           (title-width (- (window-width) elfeed-goodies/feed-source-column-width
                           elfeed-goodies/tag-column-width 4))

           (tag-column (elfeed-format-column
                        tags-str (elfeed-clamp (length tags-str)
                                               elfeed-goodies/tag-column-width
                                               elfeed-goodies/tag-column-width)
                        :left))
           (feed-column (elfeed-format-column
                         feed-title (elfeed-clamp elfeed-goodies/feed-source-column-width
                                                  elfeed-goodies/feed-source-column-width
                                                  elfeed-goodies/feed-source-column-width)
                         :left)))

      (insert (propertize feed-column 'face 'elfeed-search-feed-face) " ")
      (insert (propertize tag-column 'face 'elfeed-search-tag-face) " ")
      (insert (propertize title 'face title-faces 'kbd-help title))))

  (defun +rss/elfeed-show-refresh--better-style ()
    "Update the buffer to match the selected entry, using a mail-style."
    (interactive)
    (let* ((inhibit-read-only t)
           (title (elfeed-entry-title elfeed-show-entry))
           (date (seconds-to-time (elfeed-entry-date elfeed-show-entry)))
           (author (elfeed-meta elfeed-show-entry :author))
           (link (elfeed-entry-link elfeed-show-entry))
           (tags (elfeed-entry-tags elfeed-show-entry))
           (tagsstr (mapconcat #'symbol-name tags ", "))
           (nicedate (format-time-string "%a, %e %b %Y %T %Z" date))
           (content (elfeed-deref (elfeed-entry-content elfeed-show-entry)))
           (type (elfeed-entry-content-type elfeed-show-entry))
           (feed (elfeed-entry-feed elfeed-show-entry))
           (feed-title (elfeed-feed-title feed))
           (base (and feed (elfeed-compute-base (elfeed-feed-url feed)))))
      (erase-buffer)
      (insert "\n")
      (insert (format "%s\n\n" (propertize title 'face 'elfeed-show-title-face)))
      (insert (format "%s\t" (propertize feed-title 'face 'elfeed-search-feed-face)))
      (when (and author elfeed-show-entry-author)
        (insert (format "%s\n" (propertize author 'face 'elfeed-show-author-face))))
      (insert (format "%s\n\n" (propertize nicedate 'face 'elfeed-log-date-face)))
      (when tags
        (insert (format "%s\n"
                        (propertize tagsstr 'face 'elfeed-search-tag-face))))
      ;; (insert (propertize "Link: " 'face 'message-header-name))
      ;; (elfeed-insert-link link link)
      ;; (insert "\n")
      (cl-loop for enclosure in (elfeed-entry-enclosures elfeed-show-entry)
               do (insert (propertize "Enclosure: " 'face 'message-header-name))
               do (elfeed-insert-link (car enclosure))
               do (insert "\n"))
      (insert "\n")
      (if content
          (if (eq type 'html)
              (elfeed-insert-html content base)
            (insert content))
        (insert (propertize "(empty)\n" 'face 'italic)))
      (goto-char (point-min)))))

(after! elfeed-show
  (require 'url)

  (defvar elfeed-pdf-dir
    (expand-file-name "pdfs/"
                      (file-name-directory (directory-file-name elfeed-enclosure-default-dir))))

  (defvar elfeed-link-pdfs
    '(("https://www.jstatsoft.org/index.php/jss/article/view/v0\\([^/]+\\)" . "https://www.jstatsoft.org/index.php/jss/article/view/v0\\1/v\\1.pdf")
      ("http://arxiv.org/abs/\\([^/]+\\)" . "https://arxiv.org/pdf/\\1.pdf"))
    "List of alists of the form (REGEX-FOR-LINK . FORM-FOR-PDF)")

  (defun elfeed-show-pdf (entry)
    (interactive
     (list (or elfeed-show-entry (elfeed-search-selected :ignore-region))))
    (let ((link (elfeed-entry-link entry))
          (feed-name (plist-get (elfeed-feed-meta (elfeed-entry-feed entry)) :title))
          (title (elfeed-entry-title entry))
          (file-view-function
           (lambda (f)
             (when elfeed-show-entry
               (elfeed-kill-buffer))
             (pop-to-buffer (find-file-noselect f))))
          pdf)

      (let ((file (expand-file-name
                   (concat (subst-char-in-string ?/ ?, title) ".pdf")
                   (expand-file-name (subst-char-in-string ?/ ?, feed-name)
                                     elfeed-pdf-dir))))
        (if (file-exists-p file)
            (funcall file-view-function file)
          (dolist (link-pdf elfeed-link-pdfs)
            (when (and (string-match-p (car link-pdf) link)
                       (not pdf))
              (setq pdf (replace-regexp-in-string (car link-pdf) (cdr link-pdf) link))))
          (if (not pdf)
              (message "No associated PDF for entry")
            (message "Fetching %s" pdf)
            (unless (file-exists-p (file-name-directory file))
              (make-directory (file-name-directory file) t))
            (url-copy-file pdf file)
            (funcall file-view-function file)))))))

;; Basic Org Settings
(after! org
  (setq org-directory "~/Documents/org/"          ; let's put files here
        org-ellipsis "  ﬋"                        ; cute icon for folded org blocks
        org-list-allow-alphabetical t             ; have a. A. a) A) list bullets
        org-use-property-inheritance t            ; it's convenient to have properties inherited
        org-catch-invisible-edits 'smart          ; try not to accidently do weird stuff in invisible regions
        org-log-done 'time                        ; having the time a item is done sounds convenient
        org-roam-directory "~/Documents/org/Notes/"))        ; same thing, for roam

;; Org Fontification
(after! org
  (setq org-src-fontify-natively t
        org-fontify-whole-heading-line t
        org-inline-src-prettify-results '("⟨" . "⟩")
        org-fontify-done-headline t
        org-fontify-quote-and-verse-blocks t))

;; Change Org Mode Bullet Order
(after! org
  (setq org-list-demote-modify-bullet '(("+" . "-") ("-" . "+") ("*" . "+") ("1." . "a."))))

;; Add default dashes
(font-lock-add-keywords 'org-mode
                        '(("^ *\\([-]\\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
(font-lock-add-keywords 'org-mode
                        '(("^ *\\([+]\\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "◦"))))))

;; Basic Org Roam Settings
(use-package! websocket
  :after org-roam)

(use-package! org-roam-ui
  :after org-roam
  :commands org-roam-ui-open
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))
;; Replace org-roam buffer with org-roam-ui
(after! org-roam
  (setq +org-roam-open-buffer-on-find-file nil))

;; Setup Org Agenda
(after! org-agenda
  (setq org-agenda-files (list "~/Documents/org/work.org"
                               "~/Documents/org/todo.org"))
  (setq org-agenda-window-setup 'current-window
        org-agenda-restore-windows-after-quit t
        org-agenda-show-all-dates nil
        org-agenda-time-in-grid t
        org-agenda-show-current-time-in-grid t
        org-agenda-start-on-weekday 1
        org-agenda-span 7
        org-agenda-tags-column 0
        org-agenda-block-separator nil
        org-agenda-category-icon-alist nil
        org-agenda-sticky t)
  (setq org-agenda-prefix-format
        '((agenda . "%i %?-12t%s")
          (todo .   "%i")
          (tags .   "%i")
          (search . "%i")))
  (setq org-agenda-sorting-strategy
        '((agenda deadline-down scheduled-down todo-state-up time-up
                  habit-down priority-down category-keep)
          (todo   priority-down category-keep)
          (tags   timestamp-up priority-down category-keep)
          (search category-keep))))

;; Change Org Mode Deadlines
(after! org
  (setq org-agenda-deadline-faces
        '((1.0 . error)
          (1.0 . org-warning)
          (0.5 . org-upcoming-deadline)
          (0.0 . org-upcoming-distant-deadline))))

;; Conceal some syntax markers
(use-package! org-appear
  :after org
  :hook (org-mode . org-appear-mode)
  :config
  (setq org-appear-autoemphasis t
        org-appear-autolinks t
        org-appear-autosubmarkers t))

;; No longer have to gate sub|superscript characaters
(setq org-export-with-sub-superscripts '{})

;; Update verbatim
(after! org
  (setq org-latex-text-markup-alist
        '((bold . "\\textbf{%s}")
          (code . protectedtexttt)
          (italic . "\\emph{%s}")
          (strike-through . "\\sout{%s}")
          (underline . "\\uline{%s}")
          (verbatim . verb))))

;; Nice Window Divider
(use-package frame
  :custom
  (window-divider-default-right-width 12)
  (window-divider-default-bottom-width 1)
  (window-divider-default-places 'right-only)
  (window-divider-mode t))
;; Make sure new frames use window-divider
(add-hook 'before-make-frame-hook 'window-divider-mode)

;; Disable weird jumpy eldoc window thing
(setq eldoc-message-function #'ignore)
