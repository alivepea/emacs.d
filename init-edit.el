
(setq-default major-mode 'text-mode)

(electric-pair-mode t)

(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)


(provide 'init-edit)
