(require 'ibuf-ext)

;; replace buffer-menu
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

;; Use human readable Size column instead of original one
(define-ibuffer-column size-h
  (:name "Size" :inline t)
  (cond
   ((> (buffer-size) 1000) (format "%7.3fk" (/ (buffer-size) 1000.0)))
   ((> (buffer-size) 1000000) (format "%7.3fM" (/ (buffer-size) 1000000.0)))
   (t (format "%8d" (buffer-size)))))

;; Modify the default ibuffer-formats
(setq ibuffer-formats
      '((mark modified read-only " "
	      (name 18 18 :left :elide)
	      " "
	      (size-h 9 -1 :right)
	      " "
	      (mode 16 16 :left :elide)
	      " "
	      filename-and-process)))

;; Enable ibuffer-filter-by-filename to filter on directory names too.
(eval-after-load "ibuf-ext"
  '(define-ibuffer-filter filename
       "Toggle current view to buffers with file or directory name matching QUALIFIER."
     (:description "filename"
		   :reader (read-from-minibuffer "Filter by file/directory name (regexp): "))
     (ibuffer-awhen (or (buffer-local-value 'buffer-file-name buf)
			(buffer-local-value 'dired-directory buf))
       (string-match qualifier it))))



(provide 'init-buffer)
