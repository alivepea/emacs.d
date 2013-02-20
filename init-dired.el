
(setq dired-listing-switches "-al --dired")


;; dired-x
(add-hook 'dired-load-hook
	  (lambda ()
	    ;; Bind dired-x-find-file.
	    (setq dired-x-hands-off-my-keys nil)
	    (load "dired-x")
	    ))

(add-hook 'dired-load-hook
	  (lambda ()
	    (load "dired-x")
	    ;; Set dired-x global variables here.  For example:
	    ;; (setq dired-guess-shell-gnutar "gtar")
	    ;; (setq dired-x-hands-off-my-keys nil) 
	    ))
(add-hook 'dired-mode-hook
	  (lambda ()
	    ;; Set dired-x buffer-local variables here.  For example:
	    ;; (dired-omit-mode 1)
	    ))

(setq dired-guess-shell-alist-user
      (list
       (list "\\.pdf$" "zathura");; fixed rule
       (list "\\.png$" "feh")
       ;; possibly more rules...
       (list "\\.bar$";; rule with condition test
	     '(if CONDITION
		  "BAR-COMMAND-1"
		"BAR-COMMAND-2"))))


(provide 'init-dired)
