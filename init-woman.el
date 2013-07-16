;;; ### Woman ###
;;; --- 手册查询
(setq woman-default-indent 7            ;缩进格式
      woman-fill-frame t                ;填充满屏幕
      woman-use-own-frame nil           ;同一个frame
      woman-cache-level 3)              ;缓存级别, 最快


;; word at point
(global-set-key "\C-cw"
		(lambda ()
		  (interactive)
		  (let ((woman-use-topic-at-point t))
		    (woman))))


(provide 'init-woman)
