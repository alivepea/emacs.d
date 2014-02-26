
(autoload 'flymake-find-file-hook "flymake" "" t)
(add-hook 'find-file-hook 'flymake-find-file-hook)
(setq flymake-gui-warnings-enabled nil)
(setq flymake-log-level 1)

;; clang
(defun flymake-clang-init ()
 (let* ((temp-file (flymake-init-create-temp-buffer-copy
 'flymake-create-temp-inplace))
 (local-file (file-relative-name
 temp-file
 (file-name-directory buffer-file-name))))
 (list "clang" (list "-fsyntax-only" "-fno-color-diagnostics" local-file))))

(defun flymake-clang-load ()
  (interactive)
  (message "hello")
  (unless (eq buffer-file-name nil)
    (add-to-list 'flymake-allowed-file-name-masks
		 '("\\.c\\'" flymake-clang-init))
    (add-to-list 'flymake-allowed-file-name-masks
		 '("\\.cpp\\'" flymake-clang-init))
    (add-to-list 'flymake-allowed-file-name-masks
		 '("\\.cc\\'" flymake-clang-init))
    (add-to-list 'flymake-allowed-file-name-masks
		 '("\\.h\\'" flymake-clang-init))
    (flymake-mode t)))

(add-hook 'c-mode-common-hook 'flymake-clang-load)


;;; Flymake Shell mode
(defcustom flymake-shell-of-choice
  "/bin/bash"
  "Path of shell.")

(defcustom flymake-shell-arguments
  (list "-n")
  "Shell arguments to invoke syntax checking.")

(defconst flymake-allowed-shell-file-name-masks
  '(("\\.sh$" flymake-shell-init))
  "Filename extensions that switch on flymake-shell mode syntax checks.")

(defcustom flymake-shell-err-line-pattern-re
  '(("^\\(.+\\): line \\([0-9]+\\): \\(.+\\)$" 1 2 nil 3))
  "Regexp matching JavaScript error messages.")

(defun flymake-shell-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
		     'flymake-create-temp-inplace))
	 (local-file (file-relative-name
		      temp-file
		      (file-name-directory buffer-file-name))))
    (list flymake-shell-of-choice (append flymake-shell-arguments (list local-file)))))

(defun flymake-shell-load ()
  (setq flymake-allowed-file-name-masks (append flymake-allowed-file-name-masks flymake-allowed-shell-file-name-masks))
  (setq flymake-err-line-patterns (append flymake-err-line-patterns flymake-shell-err-line-pattern-re))
  (flymake-mode t)
  (local-set-key (kbd "C-c d") 'flymake-display-err-menu-for-current-line))
(add-hook 'sh-mode-hook 'flymake-shell-load)

;; erlang
(defun flymake-erlang-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
		     'flymake-create-temp-inplace))
	 (local-file (file-relative-name temp-file
		(file-name-directory buffer-file-name))))
    (list "path_to_eflymake_script" (list local-file))))

(add-to-list 'flymake-allowed-file-name-masks '("\\.erl\\'" flymake-erlang-init))


;; elisp
(defun flymake-elisp-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "elisplint" (list local-file))))
(push '("\\.el$" flymake-elisp-init) flymake-allowed-file-name-masks)
(add-hook 'emacs-lisp-mode-hook
          ;; workaround for (eq buffer-file-name nil)
          (function (lambda () (if buffer-file-name (flymake-mode)))))


(provide 'init-flymake)
