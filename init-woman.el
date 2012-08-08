(global-set-key "\C-cw"
                (lambda ()
                  (interactive)
                  (let ((woman-use-topic-at-point t))
                    (woman))))

(provide 'init-woman)
