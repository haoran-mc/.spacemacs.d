(defun ogmc/highlight-dwim ()
  (interactive)
  (if (use-region-p)
      (progn
        (highlight-frame-toggle)
        (deactivate-mark))
    (spacemacs/symbol-overlay)))

(defun ogmc/clearn-highlight ()
  (interactive)
  (symbol-overlay-remove-all))

(defun ogmc/hidden-dos-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))

(defun ogmc/remove-dos-eol ()
  "Replace DOS eolns CR LF with Unix eolns CR"
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))

(defun ogmc/graphic-p ()
  "判断当前环境是否为图形环境"
  (getenv "DISPLAY"))

(defun ogmc/load-my-layout ()
  (interactive)
  (persp-load-state-from-file (concat persp-save-dir "haoran")))

(defun ogmc/save-my-layout ()
  (interactive)
  (persp-save-state-to-file (concat persp-save-dir "haoran")))
