;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

(package! rotate)

(package! company-tabnine :recipe (:host github :repo "TommyX12/company-tabnine"))

(unpin! org-roam)
(package! websocket)
(package! org-roam-ui :recipe (:host github :repo "org-roam/org-roam-ui" :files ("*.el" "out")))
(use-package! websocket
  :after org-roam)

(use-package! org-roam-ui
  :after org
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

(unpin! doom-themes)
