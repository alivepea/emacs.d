(add-hook 'c-mode-hook '(lambda () (gtags-mode t)))
(add-hook 'gtags-select-mode-hook
          '(lambda ()
             (setq hl-line-face 'underline)
             (hl-line-mode t)))

(defvar gtags-prefix-key "\C-g")

(if gtags-mode
   (progn
      ; Current key mapping.
      (define-key gtags-mode-map (concat gtags-prefix-key "h") 'gtags-display-browser)
      (define-key gtags-mode-map (concat gtags-prefix-key "T") 'gtags-find-tag-from-here)
      (define-key gtags-mode-map (concat gtags-prefix-key "p") 'gtags-pop-stack)
      (define-key gtags-mode-map (concat gtags-prefix-key "P") 'gtags-find-file)
      (define-key gtags-mode-map (concat gtags-prefix-key "f") 'gtags-parse-file)
      (define-key gtags-mode-map (concat gtags-prefix-key "g") 'gtags-find-with-grep)
      (define-key gtags-mode-map (concat gtags-prefix-key "I") 'gtags-find-with-idutils)
      (define-key gtags-mode-map (concat gtags-prefix-key "s") 'gtags-find-symbol)
      (define-key gtags-mode-map (concat gtags-prefix-key "r") 'gtags-find-rtag)
      (define-key gtags-mode-map (concat gtags-prefix-key "t") 'gtags-find-tag)
      (define-key gtags-mode-map (concat gtags-prefix-key "d") 'gtags-find-tag)
      (define-key gtags-mode-map (concat gtags-prefix-key "v") 'gtags-visit-rootdir)
      ; common
      (define-key gtags-mode-map "\C-x4." 'gtags-find-tag-other-window)
      (if gtags-disable-pushy-mouse-mapping nil
        (define-key gtags-mode-map [mouse-3] 'gtags-pop-stack)
        (define-key gtags-mode-map [mouse-2] 'gtags-find-tag-by-event)))
)

;;; ido make gtags slow too much
(ido-ubiquitous-disable-in gtags-find-tag)
(ido-ubiquitous-disable-in gtags-find-rtag)
(ido-ubiquitous-disable-in gtags-find-file)
(ido-ubiquitous-disable-in gtags-find-symbol)
(ido-ubiquitous-disable-in gtags-find-idutils)

(provide 'init-gtags)
