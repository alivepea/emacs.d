;; Filtering Completion Candidates [C-s]

(require 'auto-complete-config)
(ac-config-default)

(add-to-list 'ac-modes 'text-mode)

(setq ac-use-quick-help t
      ac-quick-help-delay 1)

(ac-set-trigger-key "TAB")
(setq ac-auto-start 4)
(setq ac-fuzzy-enable nil)
(setq ac-delay 1)
(setq ac-auto-show-menu 1)
(setq ac-expand-on-auto-complete t)
(setq ac-show-menu-immediately-on-auto-complete t)
(setq ac-candidate-limit 400)

(ac-flyspell-workaround)		;Auto completion will not be started in a buffer flyspell-mode enabled

(add-to-list 'ac-sources 'ac-source-words-in-same-mode-buffers)
(add-to-list 'ac-dictionary-directories "/usr/share/emacs/etc/auto-complete/dict/")

(setq ac-modes
      (append ac-modes '(org-mode objc-mode sql-mode
                                  change-log-mode text-mode
                                  makefile-gmake-mode makefile-bsdmake-mo
                                  autoconf-mode makefile-automake-mode)))


(setq yas/prompt-functions '(yas/ido-prompt
			     yas/dropdown-prompt
			     yas/x-prompt
			     yas/completing-prompt
			     yas/no-prompt))


(provide 'init-completion)
