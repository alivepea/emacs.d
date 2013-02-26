
(setq-default major-mode 'text-mode)

(electric-pair-mode t)

(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)

(setq kill-read-only-ok t)
(setq kill-do-not-save-duplicates t)


(provide 'init-edit)
