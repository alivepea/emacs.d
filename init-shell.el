;; auto rename shell buffer
(defun shell-mode-auto-rename-buffer (text)
  (if (eq major-mode 'shell-mode)
      (rename-buffer  (concat "shell: " default-directory) t)))
(add-hook 'comint-output-filter-functions 'shell-mode-auto-rename-buffer)

(provide 'init-shell)
