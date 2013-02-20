
(if (fboundp 'normal-top-level-add-to-load-path)
    (let* ((my-lisp-dir "~/_emacs/site-lisp/")
           (default-directory my-lisp-dir))
      (progn
        (setq load-path
              (append
               (loop for dir in (directory-files my-lisp-dir)
                     unless (string-match "^\\." dir)
                     collecting (expand-file-name dir))
               load-path)))))


(provide 'init-site-lisp)
