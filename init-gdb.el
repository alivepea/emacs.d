(setq gud-gdb-command-name "gdb -i=mi --annotate=1")
(setq gdb-many-windows t)
(gud-tooltip-mode t)
(setq gdb-show-main t)
(setq gdb-use-colon-colon-notation t)


(add-hook 'gdb-mode-hook '(lambda ()
                            (define-key c-mode-base-map [(f5)] 'gud-go)
                            (define-key c-mode-base-map [(f7)] 'gud-step)
                            (define-key c-mode-base-map [(f8)] 'gud-next)))


(provide 'init-gdb)
