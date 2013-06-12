
(setq c-default-style '((java-mode . "java")
			(python-mode . "python")
			(awk-mode . "awk")
			(other . "linux")))

(defun my-c-initialization-hook ()
  (define-key c-mode-base-map "\C-m" 'c-context-line-break))
(add-hook 'c-initialization-hook 'my-c-initialization-hook)

(defun my-c-mode-common-hook ()
  (c-toggle-auto-newline 1))

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(defun my-load-cc-fonts ()
  (require 'cc-fonts))
(add-hook 'c-initialization-hook 'my-load-cc-fonts)


(add-hook 'c-mode-hook
	  '(lambda ()
	     (gtags-mode t)))

(add-hook 'c-mode-hook
	  '(lambda ()
	     (hs-minor-mode t)
	     (setq show-trailing-whitespace t)))

(add-hook 'c-mode-common-hook
	  (lambda ()
	    (define-key c-mode-base-map (kbd "C-c C-u")
	      'c-up-conditional-with-else)))

(which-function-mode t)


(provide 'init-ccmode)
