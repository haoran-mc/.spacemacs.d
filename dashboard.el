;;; dashboard.el --- change a few about spacemacs-buffer  -*- lexical-binding: t; -*-

;; Copyright (C) 2021  L.M.haoran

;; Author: L.M.haoran <haoran.mc@outlook.com>
;; Keywords: docs

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
;;; Code:

;; 太难了，重写了这个函数，才把终端界面的logo换掉，以后咱自己写一个dashboard
(defun spacemacs-buffer//choose-banner ()
  "Return the full path of a banner based on the dotfile value."
  (when dotspacemacs-startup-banner
    (cond ((eq 'official dotspacemacs-startup-banner)
           (if (and (display-graphic-p) (image-type-available-p 'png))
               spacemacs-banner-official-png
             "~/.spacemacs.d/ONE_PIECE.txt"))
          ((eq 'random dotspacemacs-startup-banner)
           (spacemacs-buffer//choose-random-text-banner))
          ((eq 'random* dotspacemacs-startup-banner)
           (spacemacs-buffer//choose-random-text-banner t))
          ((eq 'doge dotspacemacs-startup-banner)
           (spacemacs-buffer//get-banner-path 999))
          ((eq 'doge-inverted dotspacemacs-startup-banner)
           (spacemacs-buffer//get-banner-path 997))
          ((eq 'cat dotspacemacs-startup-banner)
           (spacemacs-buffer//get-banner-path 998))
          ((integerp dotspacemacs-startup-banner)
           (spacemacs-buffer//get-banner-path dotspacemacs-startup-banner))
          ((and dotspacemacs-startup-banner
                (image-type-available-p (intern (file-name-extension
                                                 dotspacemacs-startup-banner)))
                (display-graphic-p))
           (if (file-exists-p dotspacemacs-startup-banner)
               dotspacemacs-startup-banner
             (spacemacs-buffer/warning (format "could not find banner %s"
                                               dotspacemacs-startup-banner))
             "~/.spacemacs.d/ONE_PIECE.txt"))
          (t "~/.spacemacs.d/ONE_PIECE.txt"))))

;; 下面是另一种选择，直接关闭dashboard
;; (defun spacemacs-buffer/goto-buffer (&optional refresh))
;; (defun spacemacs-buffer/display-startup-note ())
;; (defun spacemacs-buffer//startup-hook ())

(defun spacemacs-buffer//insert-footer ()
  "Insert the footer of the home buffer."
  (save-excursion
    (let* ((badge-path spacemacs-badge-official-png)
           (badge (when (and (display-graphic-p)
                             (image-type-available-p
                              (intern (file-name-extension badge-path))))
                    (create-image badge-path)))
           (badge-size (when badge (car (image-size badge))))
           (heart-path spacemacs-purple-heart-png)
           (heart (when (and (display-graphic-p)
                             (image-type-available-p
                              (intern (file-name-extension badge-path))))
                    (create-image heart-path)))
           (heart-size (when heart (car (image-size heart))))
           (build-lhs "Made with ")
           (build-rhs " by the community")
           (proudly-free "Proudly free software")
           (gplv3-path spacemacs-gplv3-official-png)
           (gplv3 (when (and (display-graphic-p)
                             (image-type-available-p
                              (intern (file-name-extension gplv3-path))))
                    (create-image gplv3-path)))
           (gplv3-size (when gplv3 (car (image-size gplv3))))
           (buffer-read-only nil))
      (when (or badge heart gplv3)
        (goto-char (point-max))
        (spacemacs-buffer/insert-page-break)
        (insert "\n")
        ;; (when badge    ;;表明它是spacemacs
        ;;   (insert-image badge)
        ;;   (spacemacs-buffer//center-line badge-size))
        (when heart
          (when badge (insert "\n\n"))
          (insert build-lhs)
          (insert-image heart)
          (insert build-rhs)
          (spacemacs-buffer//center-line (+ (length build-lhs)
                                            heart-size
                                            (length build-rhs)))
          (insert "\n"))
        (when gplv3
          (insert "\n")
          (widget-create 'url-link
                         :tag proudly-free
                         :help-echo "What is free software?"
                         :mouse-face 'highlight
                         :follow-link "\C-m"
                         "https://www.gnu.org/philosophy/free-sw.en.html")
          (spacemacs-buffer//center-line (+ 2 (length proudly-free)))
          (insert "\n\n")
          ;; (insert-image gplv3)
          (spacemacs-buffer//center-line gplv3-size)
          (insert "\n"))))))

(defun spacemacs-buffer//insert-buttons-2 ()
  "Create and insert the interactive buttons under Spacemacs banner."
  (goto-char (point-max))
  ;; (spacemacs-buffer||add-shortcut "m" "[?]" t)
  (widget-create 'url-link
                 :tag (propertize "Homepage" 'face 'font-lock-keyword-face)
                 :help-echo "Open the Spacemacs GitHub page in your browser."
                 :mouse-face 'highlight
                 :follow-link "\C-m"
                 "https://github.com/haoran-mc")
  (insert " ")
  (widget-create 'push-button
                 :tag (propertize "Restore" 'face 'font-lock-keyword-face)
                 :help-echo
                 "Rollback ELPA package updates if something got borked."
                 :action (lambda (&rest ignore)
                           (call-interactively 'configuration-layer/rollback))
                 :mouse-face 'highlight
                 :follow-link "\C-m"
                 (propertize "Rollback Package Update"
                             'face 'font-lock-keyword-face))
  (insert " ")
  (widget-create 'push-button
                 :tag (propertize "Settings" 'face 'font-lock-keyword-face)
                 :help-echo "Open custom file"
                 :action (lambda (&rest ignore) (find-file custom-file))
                 :mouse-face 'highlight
                 :follow-link "\C-m")
  (insert " ")
  (widget-create 'push-button
                 :help-echo "Update Spacemacs core and layers."
                 :action (lambda (&rest ignore) (spacemacs/switch-to-version))
                 :mouse-face 'highlight
                 :follow-link "\C-m"
                 (propertize "Update" 'face 'font-lock-keyword-face))
  (insert " ")
  (widget-create 'url-link
                 :tag (propertize "?" 'face 'font-lock-doc-face)
                 :help-echo "Open the quickhelp."
                 :action (lambda (&rest ignore) (dired "~/.emacs.d/doc/"))
                 :mouse-face 'highlight
                 :follow-link "\C-m")
  (spacemacs-buffer//center-line)
  (insert "\n")
  (let ((len (- (line-end-position)
                (line-beginning-position))))
    (spacemacs-buffer//center-line)
    (setq spacemacs-buffer--buttons-position (- (line-end-position)
                                                (line-beginning-position)
                                                len))))

(defun spacemacs-buffer//insert-buttons ()
  "Create and insert the interactive buttons under Spacemacs banner."
  (goto-char (point-max))
  (insert "[Homepage] [Restore] [Settings] [Update]")
  (spacemacs-buffer//center-line)
  (insert "\n")
  (let ((len (- (line-end-position)
                (line-beginning-position))))
    (spacemacs-buffer//center-line)
    (setq spacemacs-buffer--buttons-position (- (line-end-position)
                                                (line-beginning-position)
                                                len))))
;; (provide 'dashboard)
;;; dashboard.el ends here
