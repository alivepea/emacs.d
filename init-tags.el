

;; (add-hook 'gtags-mode-hook
;;   '(lambda ()
;;      (define-key gtags-mode-map "\C-f" 'scroll-up)
;;      (define-key gtags-mode-map "\C-b" 'scroll-down)
;; ))


(add-hook 'gtags-select-mode-hook
  '(lambda ()
     (setq hl-line-face 'underline)
     (hl-line-mode 1)
))

(setq gtags-suggested-key-mapping t)


(provide 'init-tags)
