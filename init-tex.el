;;; auctex initialization

(setq Tex-auto-save t)
(setq Tex-parse-self t)
(setq-default Tex-master nil)

(add-to-list 'load-path "/usr/share/emacs/site-lisp/tex-utils")
(require 'xdvi-search)

(setq TeX-PDF-mode t)

(provide 'init-tex)
