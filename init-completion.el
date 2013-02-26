;; Filtering Completion Candidates [C-s]


(require 'auto-complete-config)
(ac-config-default)

(add-to-list 'ac-modes 'text-mode)

(setq ac-use-quick-help t
      ac-quick-help-delay 2)

(setq ac-auto-start 4)
(ac-set-trigger-key "TAB")
(setq ac-fuzzy-enable t)

(add-to-list 'ac-user-dictionary-files "~/.emacs.d/.dict")

(ac-flyspell-workaround)		;Auto completion will not be started in a buffer flyspell-mode enabled

(setq ac-sources '(ac-source-yasnippet
		   ac-source-gtags
		   ac-source-functions
		   ac-source-imenu
		   ac-source-filename
		   ac-source-words-in-buffer
		   ac-source-words-in-same-mode-buffers
		   ac-source-words-in-all-buffer
		   ac-source-abbrev
		   ac-source-dictionary))

(setq ac-modes
      (append ac-modes '(org-mode objc-mode jde-mode sql-mode
                                  change-log-mode text-mode
                                  makefile-gmake-mode makefile-bsdmake-mo
                                  autoconf-mode makefile-automake-mode)))


(setq yas/prompt-functions '(yas/ido-prompt
			     yas/dropdown-prompt
			     yas/x-prompt
			     yas/completing-prompt
			     yas/no-prompt))


(provide 'init-completion)
