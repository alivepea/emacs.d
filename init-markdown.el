(autoload 'markdown-mode "markdown-mode" "Mode for editing Markdown documents" t)
(setq auto-mode-alist
      (cons '("\\.\\(md\\|markdown\\)$" . markdown-mode) auto-mode-alist))
(setq markdown-command "markdown2")
(add-hook 'markdown-mode-hook '(lambda () (auto-fill-mode -1)))

(provide 'init-markdown)
