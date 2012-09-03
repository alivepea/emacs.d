(add-hook 'c-mode-hook
   '(lambda ()
      (gtags-mode 1)
))

(add-hook 'gtags-select-mode-hook
          '(lambda ()
             (setq hl-line-face 'underline)
             (hl-line-mode t)))

(setq gtags-suggested-key-mapping t)

;;; ido make gtags slow too much
(ido-ubiquitous-disable-in gtags-find-tag)
(ido-ubiquitous-disable-in gtags-find-rtag)
(ido-ubiquitous-disable-in gtags-find-file)
(ido-ubiquitous-disable-in gtags-find-symbol)
(ido-ubiquitous-disable-in gtags-find-idutils)

(provide 'init-gtags)
