
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
(setq minibuffer-message-timeout 1)  

;; ido replace it
;; (iswitchb-mode)

;; smex build on ido
;; This delays initializing smex until it’s needed
(global-set-key [(meta x)] (lambda ()
                             (interactive)
                             (or (boundp 'smex-cache)
                                 (smex-initialize))
                             (global-set-key [(meta x)] 'smex)
                             (smex)))

(global-set-key [(shift meta x)] (lambda ()
                                   (interactive)
                                   (or (boundp 'smex-cache)
                                       (smex-initialize))
                                   (global-set-key [(shift meta x)] 'smex-major-mode-commands)
                                   (smex-major-mode-commands)))

(setq smex-prompt-string "M-x(smex) ")

(defun smex-update-after-load (unused)
  (when (boundp 'smex-cache)
    (smex-update)))
(add-hook 'after-load-functions 'smex-update-after-load)

(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)


(provide 'init-minibuffer)
