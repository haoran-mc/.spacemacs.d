(which-function-mode)
;; when editing js file, this feature is very useful
(setq-default header-line-format
              '((which-func-mode ("" which-func-format " "))))

;; more useful frame title, that show either a file or a
;; buffer name (if the buffer isn't visiting a file)
(setq frame-title-format
      '("" " ogmc - "
        (:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name)) "%b"))))
;; (setq-default frame-title-format "Forming into my Dreamtale!");;设置标题


(custom-set-faces
 '(lazy-highlight ((t (:background "#86dc2f" :foreground "#262626"))))
 )

;; (if window-system
;;     (custom-set-faces
;;      '(mode-line ((t (:background "#2b2b2b" :foreground "#005f87" :box nil))))
;;      ))


;; (setq initial-scratch-message
;;       (with-temp-buffer
;;         (insert "                                             ")
;;         (insert-image (create-image "~/.spacemacs.d/ONE_PIECE.png"))
;;         (insert "\n")
;;         (buffer-string)))
