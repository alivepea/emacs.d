;; shell-pop
(add-to-list 'load-path "~/.emacs.d/shell-pop")
(require 'shell-pop)
(shell-pop-set-internal-mode "ansi-term")
(shell-pop-set-internal-mode-shell "/bin/bash")
(shell-pop-set-window-height 60)
(global-set-key (kbd "<f11>") 'shell-pop)

(add-hook 'term-mode-hook
	  (function
	   (lambda ()
	     (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *")
	     (make-local-variable
	      'mouse-yank-at-point)
	     (make-local-variable 'transient-mark-mode)
	     (auto-fill-mode -1)
	     (setq mouse-yank-at-point t)
	     (setq transient-mark-mode nil)
	     (setq scroll-margin 0)
	     (setq tab-width 8 ))))

;; enable cua and transient mark modes in term-line-mode
(defadvice term-line-mode (after term-line-mode-fixes ())
  (set (make-local-variable 'cua-mode) t)
  (set (make-local-variable 'transient-mark-mode) t))
(ad-activate 'term-line-mode)
;; disable cua and transient mark modes in term-char-mode
(defadvice term-char-mode (after term-char-mode-fixes ())
  (set (make-local-variable 'cua-mode) nil)
  (set (make-local-variable 'transient-mark-mode) nil))
(ad-activate 'term-char-mode)


(provide 'init-term)


