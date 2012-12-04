;;----------------------------------------------------------------------------
;; Misc config - yet to be placed in separate files
;;----------------------------------------------------------------------------
(add-auto-mode 'tcl-mode "Portfile$")
(fset 'yes-or-no-p 'y-or-n-p)
(add-hook 'find-file-hooks 'goto-address-prog-mode)
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)
(setq goto-address-mail-face 'link)

(column-number-mode 1)

(setq-default regex-tool-backend 'perl)

(require 'pretty-mode)
(global-pretty-mode t)

(require 'color-theme-sanityinc-tomorrow)
(color-theme-sanityinc-tomorrow-eighties)

(global-set-key [C-tab] 'other-window)
(provide 'init-misc)
