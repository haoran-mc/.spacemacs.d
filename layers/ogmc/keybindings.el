(global-set-key (kbd "C-M-\\") 'ogmc/indent-region-or-buffer)
(global-set-key (kbd "C-,") 'emmet-expand-line)

(spacemacs/set-leader-keys "oy" 'youdao-dictionary-search-at-point+)
;; open fire
(spacemacs/set-leader-keys "rc" '(lambda() (interactive) (dired "~/.spacemacs.d/")))
(spacemacs/set-leader-keys "tw" '(lambda() (interactive) (find-file "~/haoran/Notes/Org/Programming/+wiki-list.org")))
(spacemacs/set-leader-keys "oT"  '(lambda() (interactive) (dired "~/haoran/Notes/Markdown/")))
(spacemacs/set-leader-keys "oo"  'ogmc/open-in-browser)
(spacemacs/set-leader-keys "otn" '(lambda() (interactive) (find-file "~/haoran/Notes/Org/Diary/wiki.org")))
;; dired
(spacemacs/set-leader-keys "ode"  '(lambda() (interactive) (dired "~/.emacs.d/")))
;; layout
(spacemacs/set-leader-keys "oll" 'ogmc/load-my-layout)
(spacemacs/set-leader-keys "ols" 'ogmc/save-my-layout)
;; run
(spacemacs/set-leader-keys "ors" 'run-geiser)

;; highlight
(spacemacs/set-leader-keys "hh" 'ogmc/highlight-dwim)
(spacemacs/set-leader-keys "hc" 'ogmc/clearn-highlight)

