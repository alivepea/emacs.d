;; Make a non-standard key binding.  We can put this in
;; c-mode-base-map because c-mode-map, c++-mode-map, and so on,
;; inherit from it.
(defun my-c-initialization-hook ()
  (define-key c-mode-base-map "\C-m" 'c-context-line-break))
(add-hook 'c-initialization-hook 'my-c-initialization-hook)

(setq c-default-style '((java-mode . "java")
 			(awk-mode . "awk")
			(other . "linux")))

(add-hook 'c-mode-hook (lambda () (hs-minor-mode t)))
(define-key c-mode-base-map "\C-m" 'c-context-line-break)
(define-key c-mode-base-map "\C-c\C-d" 'c-down-conditional)

(provide 'init-cmode)
