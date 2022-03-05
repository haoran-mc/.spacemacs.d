;;; config.el --- No description!                    -*- lexical-binding: t; -*-

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
;;; Code:

(progn
  "Settings of `org-export'."
  (setq
	 ;; org-export-in-background t
   ;; Hide html built-in style and script.
   org-html-htmlize-output-type 'inline-css
   ))

(custom-set-faces
 '(org-level-1 ((t (:inherit outline-1 :height 1.0))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.0))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.0))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.0))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.0))))
 '(org-level-6 ((t (:inherit outline-6 :height 1.0))))
 '(org-level-7 ((t (:inherit outline-7 :height 1.0))))
 '(org-level-8 ((t (:inherit outline-8 :height 1.0)))))

;; (require 'htmlize)
(load-file "~/.spacemacs.d/htmlize.el")

(setq system-time-locale "C")

(setq httpd-port 9517)

(setq org-html-mathjax-options
			'((path "static/MathJax/cdn.bootcdn.net/ajax/libs/mathjax/3.1.2/es5/tex-mml-chtml.min.js")
				;; '((path "static/MathJax/cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.0/MathJax.js?config=TeX-AMS_HTML")
				;; '((path "https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.0/MathJax.js?config=TeX-AMS_HTML")
				(scale "100")
				(align "center")
				(font "TeX")
				(linebreaks "false")
				(autonumber "AMS")
				(indent "0em")
				(multlinewidth "85%")
				(tagindent ".8em")
				(tagside "right")))

;; (add-to-list 'org-modules 'org-tempo)
;; (defvar org-modules '(org-tempo))

(provide 'config)
;;; config.el ends here
