
(setq compilation-scroll-output t)

;; compile-dwim
(defvar get-buffer-compile-command (lambda (file) (cons file 1)))
(make-variable-buffer-local 'get-buffer-compile-command)

(setq-default compile-command "")

(defun compile-dwim (&optional arg)
  "Compile Do What I Mean.
    Compile using `compile-command'.
    When `compile-command' is empty prompt for its default value.
    With prefix C-u always prompt for the default value of
    `compile-command'.
    With prefix C-u C-u prompt for buffer local compile command with
    suggestion from `get-buffer-compile-command'.  An empty input removes
    the local compile command for the current buffer."
  (interactive "P")
  (cond
   ((and arg (> (car arg) 4))
    (let ((cmd (read-from-minibuffer
		"Buffer local compile command: "
		(funcall get-buffer-compile-command
			 (or (file-relative-name (buffer-file-name)) ""))
		nil nil 'compile-history)))
      (cond ((equal cmd "")
	     (kill-local-variable 'compile-command)
	     (kill-local-variable 'compilation-directory))
	    (t
	     (set (make-local-variable 'compile-command) cmd)
	     (set (make-local-variable 'compilation-directory)
		  default-directory))))
    (when (not (equal compile-command ""))
      ;; `compile' changes the default value of
      ;; compilation-directory but this is a buffer local
      ;; compilation
      (let ((dirbak (default-value 'compilation-directory)))
	(compile compile-command)
	(setq-default compilation-directory dirbak))))
   ((or (and arg (<= (car arg) 4))
	(equal compile-command ""))
    (setq-default compile-command (read-from-minibuffer
				   "Compile command: "
				   (if (equal compile-command "")
				       "make " compile-command)
				   nil nil 'compile-history))
    (setq-default compilation-directory default-directory)
    (when (not (equal (default-value 'compile-command) ""))
      (compile (default-value 'compile-command))))
   (t
    (recompile))))

(global-set-key (kbd "C-<f5>") 'compile-dwim)


(defun my-latex-mode ()
  (setq get-buffer-compile-command
	(lambda (file) (format "pdflatex %s" file))))
(add-hook 'latex-mode-hook 'my-latex-mode)

;; examples where `get-buffer-compile-command'
;; returns a cons cell (TEXT . CURSORPOS)

(defun my-c-mode ()
  (setq get-buffer-compile-command
	(lambda (file)
	  (cons (format "gcc -Wall  -o %s %s && ./%s"
			(file-name-sans-extension file)
			file
			(file-name-sans-extension file))
		11))))
(add-hook 'c-mode-hook 'my-c-mode)

(defun my-c++-mode ()
  (setq get-buffer-compile-command
	(lambda (file)
	  (cons (format "g++ -Wall  -o %s %s && ./%s"
			(file-name-sans-extension file)
			file
			(file-name-sans-extension file))
		11))))
(add-hook 'c++-mode-hook 'my-c++-mode)


(provide 'init-compilation)
