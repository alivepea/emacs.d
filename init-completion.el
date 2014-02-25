;; Filtering Completion Candidates [C-s]

;; (require 'auto-complete-config)
(require 'auto-complete-clang)

;; (ac-config-default)

(setq ac-use-quick-help t
      ac-quick-help-delay 1)

(ac-set-trigger-key "TAB")
(setq ac-auto-start 4)
(setq ac-fuzzy-enable nil)
(setq ac-delay 1)
(setq ac-auto-show-menu 1)
(setq ac-expand-on-auto-complete t)
(setq ac-show-menu-immediately-on-auto-complete t)
(setq ac-candidate-limit 2000)
(setq ac-ignore-case 'nil)

(ac-flyspell-workaround)		;Auto completion will not be started in a buffer flyspell-mode enabled

;;auto-complete-mode tries to reduce a cost of computation of columns to
;;show completion menu correctly by using a optimized function at the
;;expense of accuracy. However, it probably causes a menu to be disrupted.
(setq popup-use-optimized-column-computation nil)


(setq-default ac-sources '(ac-source-filename
			   ac-source-abbrev
			   ac-source-dictionary
			   ac-source-words-in-same-mode-buffers))
(add-to-list 'ac-dictionary-directories "/usr/share/emacs/etc/auto-complete/dict/")

(global-auto-complete-mode t)
(setq ac-modes
      (append ac-modes '(text-mode
			 change-log-mode)))

;; yasnippet
(setq yas/prompt-functions '(yas/ido-prompt
			     yas/dropdown-prompt
			     yas/x-prompt
			     yas/completing-prompt
			     yas/no-prompt))


(defun my-ac-cc-mode-setup ()
  (add-to-list 'ac-sources 'ac-source-clang)
  (setq ac-clang-flags
	(mapcar (lambda (item)(concat "-I" item))
		(split-string
		 "
 /usr/lib/gcc/x86_64-pc-linux-gnu/4.8.2/include/g++-v4
 /usr/lib/gcc/x86_64-pc-linux-gnu/4.8.2/include/g++-v4/x86_64-pc-linux-gnu
 /usr/lib/gcc/x86_64-pc-linux-gnu/4.8.2/include/g++-v4/backward
 /usr/lib/gcc/x86_64-pc-linux-gnu/4.8.2/include
 /usr/lib/gcc/x86_64-pc-linux-gnu/4.8.2/include-fixed
 /usr/include
"
		 )))
  )

(add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)

(provide 'init-completion)
