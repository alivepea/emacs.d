
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(setq ido-ubiquitous-mode t)
(require 'ido-ubiquitous)


(setq ido-max-prospects 24)

;; smex built on ido
(setq smex-prompt-string "M-x(smex) ")
(setq smex-save-file "~/.emacs.d/.smex.save")
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

;; avoid slow emacs
(ido-ubiquitous-disable-in gtags-find-tag)
(ido-ubiquitous-disable-in gtags-find-rtag)
(ido-ubiquitous-disable-in gtags-find-symbol)


(provide 'init-ido)
