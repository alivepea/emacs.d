
(setq speedbar-tag-hierarchy-method nil)
(setq speedbar-show-unknown-files t)
(setq sr-speedbar-skip-other-window-p t) ;awesome+sppedbar is better
(setq speedbar-show-unknown-files t)
(setq speedbar-use-images nil)

(add-hook
 'speedbar-timer-hook
 (lambda ()
   (save-excursion
     (set-buffer speedbar-buffer)
     (speedbar-expand-line))))

(defun my-imenu-to-menubar ()
  (imenu-add-menubar-index)
  (run-hooks 'menu-bar-update-hook)
  )

;; imenu
(require 'imenu)
(setq imenu-max-item-length 100)
(setq imenu-auto-rescan t)
(setq imenu-auto-rescan-maxout 600000)

(mapc (lambda (hook) (add-hook hook 'my-imenu-to-menubar))
      '(c-mode-hook)) ; <-- list like '(c-mode-hook c++-mode-hook java-mode-hook)


;; sr-speedbar
(add-to-list 'load-path "~/.emacs.d/sr-speedbar")
(require 'sr-speedbar)
(defun my-sr-speedbar ()
  "open sr-speedbar and select sr-speedbar"
  (interactive)
  (unless (sr-speedbar-exist-p)
    (sr-speedbar-open))
  (sr-speedbar-select-window))

(global-set-key (kbd "C-<f2>") 'my-sr-speedbar)
(setq sr-speedbar-width-x 60)
(setq sr-speedbar-max-width 80)
(setq sr-speedbar-skip-other-window-p t)
(setq sr-speedbar-right-side t)
(setq sr-speedbar-delete-window nil)


(provide 'init-speedbar)
