(add-hook 'gtags-select-mode-hook
  '(lambda ()
     (setq hl-line-face 'underline)
     (hl-line-mode 1)))


(setq gtags-disable-pushy-mouse-mapping t)
(setq gtags-suggested-key-mapping t)

;; avoid slow emacs
(ido-ubiquitous-disable-in gtags-find-tag)
(ido-ubiquitous-disable-in gtags-find-rtag)
(ido-ubiquitous-disable-in gtags-find-symbol)
(ido-ubiquitous-disable-in gtags-find-file)


(provide 'init-tags)
