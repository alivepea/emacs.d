
(setq speedbar-tag-hierarchy-method nil)
(setq speedbar-show-unknown-files t)
(setq sr-speedbar-skip-other-window-p t) ;awesome+sppedbar is better
(setq speedbar-show-unknown-files t)

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


(provide 'init-speedbar)
