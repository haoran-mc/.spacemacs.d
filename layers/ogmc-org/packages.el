(defconst ogmc-org-packages
  '(
    (org :location built-in)
    org-superstar   ;;org-bullet的后代
    )
  )

(defun ogmc-org/post-init-org-superstar ()
  (progn
    ;; (setq org-superstar-headline-bullets-list '("☰" "☷" "☯" "☭"))
    ;; (setq org-ellipsis "..")
    (setq org-ellipsis " ▼ ")
    ))

;; 如果用自带的org，那么使用init-org，否则使用post-init-org
(defun ogmc-org/init-org ()
  (with-eval-after-load 'org
    (progn
      (require 'org)
      (require 'org-tempo);;添加这一句之后就可以<s<TAB>了
      (setq org-link-frame-setup  ;;打开链接全屏，不然就会分屏打开
            '((vm . vm-visit-folder)
              (vm-imap . vm-visit-imap-folder)
              (gnus . gnus)
              (file . find-file)
              (wl . wl-frame)))
      (spacemacs|disable-company org-mode);; 不允许自动补全
      (add-hook 'org-mode-hook 'toggle-truncate-lines) ;;自动换行
      (setq org-M-RET-may-split-line '((header-line . nil)));;M-RET不分割
      ;; (setq org-startup-folded t)
      (setq org-startup-folded 'content);; 只显示标题
      (setq org-html-head
            "<link rel=\"stylesheet\" href=\"./static/css/org.css\">")
      )))
