
(add-hook 'term-mode-hook
	  (function
	   (lambda ()
	     (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *")
	     (make-local-variable
	      'mouse-yank-at-point)
	     (make-local-variable 'transient-mark-mode)
	     (setq mouse-yank-at-point t)
	     (setq transient-mark-mode nil)
	     (auto-fill-mode -1)
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


