
(add-hook 'java-mode-hook
	  '(lambda ()
	     (gtags-mode t)))

(provide 'init-java)
