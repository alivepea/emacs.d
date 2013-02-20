
(setq speedbar-tag-hierarchy-method nil)
(setq speedbar-show-unknown-files t)
(setq sr-speedbar-skip-other-window-p t) ;awesome+sppedbar is better

(defun my-imenu-to-menubar ()
  (imenu-add-menubar-index)
  (run-hooks 'menu-bar-update-hook)
  )

(require 'imenu)
(mapc (lambda (hook) (add-hook hook 'my-imenu-to-menubar))
      '(c-mode-hook)) ; <-- list like '(c-mode-hook c++-mode-hook java-mode-hook)


(provide 'init-speedbar)
