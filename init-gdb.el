(setq gud-gdb-command-name "gdb -i=mi --annotate=1")
(gud-tooltip-mode t)
(setq gdb-show-main t)
(setq gdb-show-changed-values t)
(setq gdb-use-colon-colon-notation t)

;; Force gdb-mi to not dedicate any windows
(defadvice gdb-display-buffer (after undedicate-gdb-display-buffer)
  (set-window-dedicated-p ad-return-value nil))
(ad-activate 'gdb-display-buffer)

(defadvice gdb-set-window-buffer (after undedicate-gdb-set-window-buffer (name &optional ignore-dedi window))
  (set-window-dedicated-p window nil))
(ad-activate 'gdb-set-window-buffer)


;; layout
(add-hook 'gdb-mode-hook '(lambda ()
			    ))

(provide 'init-gdb)
