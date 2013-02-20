;; Filtering Completion Candidates [C-s]


(require 'auto-complete-config)
(ac-config-default)

(add-to-list 'ac-modes 'text-mode)

(setq ac-use-quick-help t
      ac-quick-help-delay 2)

(setq ac-auto-start 4)
(ac-set-trigger-key "TAB")
(setq ac-fuzzy-enable t)

(add-to-list 'ac-user-dictionary-files "~/.dict")

(ac-flyspell-workaround)		;Auto completion will not be started in a buffer flyspell-mode enabled


(provide 'init-completion)
