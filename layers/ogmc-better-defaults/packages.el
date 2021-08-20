(defconst ogmc-better-defaults-packages
  '(
    (dired-mode :location built-in)
    (recentf :location built-in)
    )
  )

(defun ogmc-better-defaults/post-init-recentf ()
  (progn
    (setq recentf-max-saved-items 2048)))

(defun ogmc-better-defaults/init-dired-mode ()
  (use-package dired-mode
    :defer t
    :init
    (progn
      (require 'dired-x)
      (require 'dired-aux);;加上这句才能buffer共用
      ;; always delete and copy recursively
      (setq dired-recursive-deletes 'always)
      (setq dired-recursive-copies 'always)
      (put 'dired-find-alternate-file 'disabled nil);;buffer共用
      (with-eval-after-load 'dired
        (define-key dired-mode-map (kbd "C-k") 'ogmc/dired-up-directory))
      )
    ))
