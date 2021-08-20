;; C-M-\能够直接对全文格式化，不使用这个函数与下面一个函数的话，只能对选中的地方格式化
(defun ogmc/indent-buffer ()
  "Indent the currently visited buffer."
  (interactive)
  (indent-region (point-min) (point-max)))

(defun ogmc/indent-region-or-buffer () ;;一键格式化
  "Indent a region if selected, otherwise the whole buffer."
  (interactive)
  (save-excursion;;记忆光标位置
    (if (region-active-p)
        (progn
          (indent-region (region-beginning) (region-end))
          (message "Indented selected region."))
      (progn
        (ogmc/indent-buffer)
        (message "Indented buffer.")))))

;; 自动抓取光标停留的单词，至于为什么叫这个函数名，dwim = do what I mean
(defun occur-dwim()
  "Call `occur' with a sane default."
  (interactive)
  (push (if (region-active-p)
            (buffer-substring-no-properties
             (region-beginning)
             (region-end))
          (let ((sym (thing-at-point 'symbol)))
            (when (stringp sym)
              (regexp-quote sym))))
        regexp-history)
  (call-interactively 'occur))

(defun ogmc/dired-up-directory()
  "goto up directory and resue buffer"
  (interactive)
  (find-alternate-file ".."))
