
(add-hook 'gtags-select-mode-hook
  '(lambda ()
     (setq hl-line-face 'underline)
     (hl-line-mode 1)
))


(setq gtags-disable-pushy-mouse-mapping t)
(setq gtags-suggested-key-mapping t)


(provide 'init-tags)
