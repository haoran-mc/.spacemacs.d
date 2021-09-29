(setq ogmc-programming-packages
      '(
        js2-mode
        web-mode
        flycheck
        company
        yasnippet
        auto-yasnippet
        json-mode
        ;; emmet-mode
        ;; auto-complete
        ;; lsp-mode
        go-mode
        ))

(defun ogmc-programming/post-init-flycheck ()
  (with-eval-after-load 'flycheck
    (progn
      (setq flycheck-display-errors-delay 0.9)
      (setq flycheck-idle-change-delay 2.0)
      )))

(defun ogmc-programming/post-init-js2-mode ()
  (progn
    (add-hook 'js2-mode-hook 'flycheck-mode)

    (spacemacs|define-jump-handlers js2-mode)
    (add-hook 'spacemacs-jump-handlers-js2-mode 'etags-select-find-tag-at-point)

    (setq company-backends-js2-mode '((company-dabbrev-code :with company-keywords company-etags)
                                      company-files company-dabbrev))
    (setq company-backends-js-mode '((company-dabbrev-code :with company-keywords company-etags)
                                     company-files company-dabbrev))
    ;; add your own keywords highlight here
    (font-lock-add-keywords 'js2-mode
                            '(("\\<\\(cc\\)\\>" 1 font-lock-type-face)))
    (with-eval-after-load 'js2-mode
      (progn
        ;; these mode related variables must be in eval-after-load
        ;; https://github.com/magnars/.emacs.d/blob/master/settings/setup-js2-mode.el
        (setq-default js2-allow-rhino-new-expr-initializer nil)
        (setq-default js2-auto-indent-p nil)
        (setq-default js2-enter-indents-newline nil)
        (setq-default js2-global-externs '("module" "ccui" "require" "buster" "sinon" "assert" "refute" "setTimeout" "clearTimeout" "setInterval" "clearInterval" "location" "__dirname" "console" "JSON"))
        (setq-default js2-idle-timer-delay 0.2)
        (setq-default js2-mirror-mode nil)
        (setq-default js2-strict-inconsistent-return-warning nil)
        (setq-default js2-include-rhino-externs nil)
        (setq-default js2-include-gears-externs nil)
        (setq-default js2-concat-multiline-strings 'eol)
        (setq-default js2-rebind-eol-bol-keys nil)
        (setq-default js2-auto-indent-p t)

        (setq-default js2-bounce-indent nil)
        (setq-default js-indent-level 4)
        (setq-default js2-basic-offset 4)
        (setq-default js-switch-indent-offset 4)
        ;; Let flycheck handle parse errors
        (setq-default js2-mode-show-parse-errors t)
        (setq-default js2-mode-show-strict-warnings nil)
        (setq-default js2-highlight-external-variables t)
        (setq-default js2-strict-trailing-comma-warning nil)

        (add-hook 'web-mode-hook 'my-web-mode-indent-setup)
        ))
    ;; (evilified-state-evilify js2-error-buffer-mode js2-error-buffer-mode-map)
    ))

(defun ogmc-programming/post-init-web-mode ()
  (add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.wxml\\'" . web-mode))
  (with-eval-after-load "web-mode"
    (progn
      (my-web-mode-indent-setup)
      (web-mode-toggle-current-element-highlight)
      (web-mode-dom-errors-show)
      (setq web-mode-enable-current-element-highlight t)
      (setq web-mode-enable-css-colorization t)
      ))
  (setq company-backends-web-mode '((company-dabbrev-code
                                     company-keywords
                                     company-etags)
                                    company-files company-dabbrev)))

(defun ogmc-programming/post-init-company ()
  (progn
    (setq company-minimum-prefix-length 1
          company-idle-delay 0.08)
    ))

(defun ogmc-programming/post-init-yasnippet ()
  (progn
    (set-face-background 'secondary-selection "gray")

    (with-eval-after-load 'yasnippet
      (progn
        (define-key yas-keymap [(tab)]       (yas-filtered-definition 'yas-next-field))
        (define-key yas-keymap (kbd "TAB")   (yas-filtered-definition 'yas-next-field))))
    (mapc #'(lambda (hook) (remove-hook hook 'spacemacs/load-yasnippet)) '(prog-mode-hook
                                                                           org-mode-hook
                                                                           markdown-mode-hook))
    (spacemacs/add-to-hooks 'ogmc/load-yasnippet '(prog-mode-hook
                                                   markdown-mode-hook
                                                   org-mode-hook))
    ))

(defun ogmc-programming/post-init-auto-yasnippet ()
  (progn
    (defun autoinsert-yas-expand()
      "Replace text in yasnippet template."
      (yas-expand-snippet (buffer-string) (point-min) (point-max)))
    (require 'autoinsert)
    (setq auto-insert-query nil)
    (setq auto-insert-directory (locate-user-emacs-file "templates"))
    (add-hook 'find-file-hook 'auto-insert)
    (auto-insert-mode 1)
    (define-auto-insert "\\.org$" ["~/.spacemacs.d/snippets/default-org.el" autoinsert-yas-expand])
    ))

(defun ogmc-programming/post-init-json-mode ()
  (add-to-list 'auto-mode-alist '("\\.tern-project\\'" . json-mode))
  (add-to-list 'auto-mode-alist '("\\.fire\\'" . json-mode))
  (add-to-list 'auto-mode-alist '("\\.fire.meta\\'" . json-mode))
  )

(defun ogmc-programming/post-init-go-mode ())
