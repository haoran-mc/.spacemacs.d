;; config.el 里原则上除了 setq 别的都不能放，甚至大多数情况下不会写 config.el。这些都放对应的 use-package 里。require 那行因为已经有 use-package 应该直接去掉，
;; config.el 执行的時候 package.el 还沒加載。只能用 Emacs 和 Spacemacs 內置的函數。(global-hungry-delete-mode) (global-linum-mode 1) 這些都是外部的函數。
