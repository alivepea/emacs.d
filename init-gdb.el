(setq gud-gdb-command-name "gdb -i=mi --annotate=1")
(gud-tooltip-mode t)
(setq gdb-show-main t)
(setq gdb-show-changed-values t)
(setq gdb-use-colon-colon-notation t)

;; layout
(add-hook 'gdb-mode-hook '(lambda ()
			    (gdb-frame-breakpoints-buffer) ; Adapt tiling WM
			    (gdb-frame-stack-buffer)
			    (gdb-frame-locals-buffer)))

(provide 'init-gdb)
