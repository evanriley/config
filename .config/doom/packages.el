;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;;org
(package! doct)
(package! websocket)
(package! org-appear)
(package! org-preview-html)
(package! org-modern)
(package! org-projectile)
;;(package! org-pretty-table)
;;(package! org-ol-tree)

;;programming
;; Any other programming-specific packages can go here


;;looks
(package! focus)
(package! doom-themes)
(package! solaire-mode)
(package! svg-tag-mode)

(package! vundo
  :recipe (:host github
           :repo "casouri/vundo")
  :pin "10d5debe317b2244d19085151040f955dda4a9ab")

;;emacs additions
(package! nov)
(package! lexic)
(package! info-colors)
(package! xit-mode)
(package! magit-delta :recipe (:host github :repo "dandavison/magit-delta"))

(package! magit-pretty-graph
  :recipe (:host github
           :repo "georgek/magit-pretty-graph")
  :pin "26dc5535a20efe781b172bac73f14a5ebe13efa9")

;;fun
(package! smudge)
