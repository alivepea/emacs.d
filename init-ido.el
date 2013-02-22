
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-ubiquitous-mode t)
(ido-mode 1)

(setq ido-max-prospects 24)

;; smex built on ido
(setq smex-prompt-string "M-x(smex) ")
(setq smex-save-file "~/.smex.save")
(setq smex-history-length 14)
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

(defun smex-update-after-load (unused)
  (when (boundp 'smex-cache)
    (smex-update)))
(add-hook 'after-load-functions 'smex-update-after-load)


(provide 'init-ido)
