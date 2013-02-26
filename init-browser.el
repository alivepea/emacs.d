(goto-address-mode t)

(setq browse-url-browser-function '(("^mailto:" . browse-url-mail)
     				    ("." . browse-url-chromium)))

(or (eq window-system 'x)
    (setq browse-url-browser-function 'browse-url-w3))



(provide 'init-browser)


