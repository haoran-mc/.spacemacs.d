;;; funcs.el --- site                                -*- lexical-binding: t; -*-

;; Copyright (C) 2021  L.M.haoran

;; Author: L.M.haoran <haoran.mc@outlook.com>
;; Keywords: 

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:

(defun save-and-publish-website()
  "Save all buffers and publish."
  (interactive)
  (when (yes-or-no-p "Really save and publish current project?")
    (save-some-buffers t)
    (org-publish-project "org-notes" t)
    (message "Site published done.")))

(defun save-and-publish-statics ()
  "Just copy statics like js, css, and image file .etc."
  (interactive)
  (org-publish-project "statics" t)
  (message "Copy statics done."))

(defun save-and-publish-rstatics ()
  "Just copy statics like js, css, and image file .etc.
Which is a reverse operation of `save-and-publish-statics'."
  (interactive)
  (org-publish-project "rstatics" t)
  (message "Copy rstatics done."))

(defun ogmc/save-and-publish-file ()
  "Save current buffer and publish."
  (interactive)
  (save-buffer t)
  (org-publish-current-file t))

(defun delete-org-and-html ()
  "Delete current org and the relative html when it exists."
  (interactive)
  (when (yes-or-no-p "Really delete current org and the relative html?")
    (let ((fileurl (concat "~/haoran/Notes/Org/Programming/public/" (file-name-base (buffer-name)) ".html")))
      (if (file-exists-p fileurl)
          (delete-file fileurl))
      (delete-file (buffer-file-name))
      (kill-this-buffer)
      (message "Delete org and the relative html done."))))

(defun just-delete-relative-html ()
  "Just delete the relative html when it exists."
  (interactive)
  (when (yes-or-no-p "Really delete the relative html?")
    (let ((fileurl (concat "~/haoran/Notes/Org/Programming/public/" (file-name-base (buffer-name)) ".html")))
      (if (file-exists-p fileurl)
          (progn
            (delete-file fileurl)
            (message "Delete the relative html done."))
        (message "None relative html.")))))

(define-minor-mode auto-save-and-publish-file-mode
  "Toggle auto save and publish current file."
  :global nil
  :lighter ""
  (if auto-save-and-publish-file-mode
      ;; When the mode is enabled
      (progn
        (add-hook 'after-save-hook #'ogmc/save-and-publish-file :append :local))
    ;; When the mode is disabled
    (remove-hook 'after-save-hook #'ogmc/save-and-publish-file :local)))

;; ; (use-package auto-save-and-publish-file-mode :hook (org-mode))

(defun ogmc/preview-current-buffer-in-browser ()
  "Open current buffer as html."
  (interactive)
  (let ((fileurl (concat "http://127.0.0.1:8517/" (file-name-base (buffer-name)) ".html")))
    (ogmc/save-and-publish-file)
    (unless (httpd-running-p) (httpd-start))
    (browse-url-chrome fileurl)))


(provide 'funcs)
;;; funcs.el ends here

