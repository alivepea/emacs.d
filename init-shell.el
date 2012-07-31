;; auto rename shell buffer
(defun shell-mode-auto-rename-buffer (text)
  (if (eq major-mode 'shell-mode)
      (rename-buffer  (concat "shell: " default-directory) t)))
(add-hook 'comint-output-filter-functions 'shell-mode-auto-rename-buffer)

;;; http://www.emacswiki.org/emacs/ShellPop/
(require 'shell-pop)
(shell-pop-set-internal-mode "shell")
(shell-pop-set-internal-mode-shell "/bin/bash")
(shell-pop-set-window-height 60) ;the number for the percentage of the selected window. if 100, shell-pop use the whole of selected window, not spliting.
(shell-pop-set-window-position "bottom") ;shell-pop-up position. You can choose "top" or "bottom". 
(global-set-key [f8] 'shell-pop)

;;; dirtrack
;;; PS1="|PrOmPt|\w|$PS1"
;; Now strip the goofy strings from the prompt before it gets into
;; the shell buffer.
(defun dirtrack-filter-out-pwd-prompt (string)
  "dirtrack-mode doesn't remove the PWD match from the prompt.  This does."
  (if (and (stringp string) (string-match (first dirtrack-list) string))
      (replace-match "" t t string 0)
    string))

(add-hook 'shell-mode-hook
          (lambda ()
            (setq dirtrack-list '("^|PrOmPt|\\([^|]*\\)|" 1 nil))
            (shell-dirtrack-mode nil)
            (dirtrack-mode 1)
            (add-hook 'comint-preoutput-filter-functions
                      'dirtrack nil t)
            (add-hook 'comint-preoutput-filter-functions
                      'dirtrack-filter-out-pwd-prompt t t)))



(provide 'init-shell)
