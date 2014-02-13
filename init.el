;; -*- coding: utf-8 -*-
(add-to-list 'load-path (expand-file-name "~/.emacs.d"))

(require 'init-site-lisp)
(require 'init-face)
(require 'init-speedbar)
(require 'init-window)
(require 'init-ido)
(require 'init-buffer)
(require 'init-minibuffer)
(require 'init-edit)
(require 'init-snippet)
(require 'init-completion)
(require 'init-dired)
(require 'init-diff)
(require 'init-eim)
(require 'init-browser)
(require 'init-woman)
(require 'init-ispell)

(require 'init-org)
(require 'init-ccmode)
(require 'init-compilation)
(require 'init-tags)
(require 'init-term)
(require 'init-markdown)
(require 'init-gdb)

(require 'git-emacs)
(require 'buffer-move)

(require 'init-misc)

(message (concat "startup eclipse: "
	  (number-to-string
	   (time-to-seconds
	    (time-subtract (current-time) before-init-time)))))
