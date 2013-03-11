(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
(setq minibuffer-message-timeout 1)  
(setq enable-recursive-minibuffers t)

;; ido replace it
;; (iswitchb-mode)

(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)


(provide 'init-minibuffer)
