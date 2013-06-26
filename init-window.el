(global-set-key (kbd "C-<tab>") 'other-window)
(global-set-key (kbd "<C-S-iso-lefttab>") (lambda ()
				    (interactive)
				    (other-window -1)))

(windmove-default-keybindings 'shift)
(setq windmove-wrap-around t)

(winner-mode t)


(provide 'init-window)
