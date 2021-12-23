(defconst ogmc-org-packages
  '(
    (org :location built-in)
    org-superstar   ;;org-bullet的后代
    ;; htmlize
    simple-httpd
    )
  )

(defun ogmc-org/post-init-org-superstar ()
  (progn
    (setq org-superstar-headline-bullets-list '("◉" "○" "✸" "■" "◆" "▲" "▶"))
    ;; (setq org-superstar-bullet-list '("☰" "☷" "■" "◆" "▲" "▶"))
    (setq org-ellipsis " ▼ ")
    ))

;; 如果用自带的org，那么使用init-org，否则使用post-init-org
(defun ogmc-org/init-org ()
  (with-eval-after-load 'org
    (progn
      (require 'org)
      (require 'org-tempo);;添加这一句之后就可以<s<TAB>了
      (setq org-link-frame-setup ;;打开链接全屏，不然就会分屏打开
            '((vm . vm-visit-folder)
              (vm-imap . vm-visit-imap-folder)
              (gnus . gnus)
              (file . find-file)
              (wl . wl-frame)))
      (spacemacs|disable-company org-mode);; 不允许自动补全
      (add-hook 'org-mode-hook 'toggle-truncate-lines) ;;自动换行
      (setq org-M-RET-may-split-line '((header-line . nil)));;M-RET不分割
			(setq org-cycle-include-plain-lists 'integrate)
      (setq org-startup-folded t)
      (setq org-startup-folded 'content);; 只显示标题
			;; (setq org-hide-block-startup t)
      ;; (setq org-html-head "<link rel=\"stylesheet\" href=\"./static/css/org.css\">")
      ;; (setq org-export-with-sub-superscripts nil)
      ;; site
      (require 'ox-publish)
      (setq org-publish-project-alist
            '(("org-notes"
               ;; ; Sources and destinations for files.
               :base-directory "~/haoran/Notes/Org/Programming/org"
               :base-extension "org"
               :publishing-directory "~/haoran/Notes/Org/Programming/public"
               ;; :exclude "^_[[:word:]-]*.org"
							 :exclude "wiki*\.org|Diary\.org|Book\.org|Film\.org|Note\.org"
               :recursive t
               :publishing-function org-html-publish-to-html ;; Publishing action
               :html-head-include-default-style nil ;; org-html-head-include-default-style
               :html-head-include-scripts nil       ;; org-html-head-include-scripts
							 :with-sub-superscript {}             ;; 禁用 _ 转义成下标，^转义成上标。但加 {} 就可以转义了
							 :preserve-breaks t                   ;; 是否保留换行符。如果设置为 nil，导出后就会多行文本显示在一行
               ;; ; Generic properties
							 :author "haoran"
							 :email "haoran.mc@outlook.com"
               :html-doctype "html5" ;; org-html-doctype
               :headline-levels 6    ;; org-export-headline-levels
               :language "zh"        ;; org-export-default-language
               :html-checkbox-type unicode  ;; org-html-checkbox-type
               :section-numbers nil  ;; org-export-with-section-numbers
               :with-toc t           ;; org-export-with-toc
               ;; :html-metadata-timestamp-format "%Y-%m-%d" ;; org-html-metadata-timestamp-format
               ;; :with-planning t      ;; org-export-with-planning
               ;; :with-priority t      ;; org-export-with-priority
               ;; :with-tags not-in-toc ;; org-export-with-tags
               :html-head
               "
                <link rel=\"stylesheet\" href=\"static/css/org.css\" type=\"text/css\"  />
                <script type=\"module\" src=\"static/js/main.js\" defer></script>
                <link rel=\"shortcut icon\" href=\"images/favicon.ico\" type=\"image/x-icon\" />
               "
               )
							;; ("org-static"
							;;  :base-directory "~/haoran/Notes/Org/Programming/public/static"
							;;  :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|txt\\|asc"
							;;  ;; :publishing-directory ,(concat docs-base "output/assets")
							;;  ;; :recursive t
							;;  :publishing-function org-publish-attachment
							;;  )
							;; ("org" :components ("org-notes" "org-static"))
							;; <script src=\"https://sdk.jinrishici.com/v2/browser/jinrishici.js\" charset=\"utf-8\"></script>
							))
			(let ((fileurl (concat "~/haoran/Notes/Org/Programming/public/" (file-name-base (buffer-name)) ".html")))
				(if (file-exists-p fileurl)
						(add-hook 'org-mode-hook 'auto-save-and-publish-file-mode)
					))
			)))

(defun ogmc-org/init-simple-httpd ()
  (setq httpd-root "~/haoran/Notes/Org/Programming/public"))


;; (defun ogmc-org/post-init-htmlize ()
;; 	(setq org-export-in-background nil
;; 				org-html-htmlize-output-type 'inline-css))
