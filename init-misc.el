(setq make-backup-files nil)
(setq mouse-yank-at-point t)
(setq kill-ring-max 1024)
(setq message-log-max t)
(setq isearch-allow-scroll t)
(setq show-trailing-whitespace t)
(setq global-mark-ring-max 160)

(auto-compression-mode 1)

;; (global-set-key (kbd "C-.") 'set-mark-command)

;; jump-char
(require 'jump-char)
(global-set-key (kbd "C-;") 'jump-char-forward)
;; (global-set-key (kbd "C-S-;") 'jump-char-backward)

;; recentf
(recentf-mode 1)
(setq recentf-max-saved-items 100)      ;最近打开文件的最大数量
(setq recentf-auto-cleanup 300)         ;自动清理最近打开文件列表中重复或其他文件的时间间隔 (秒)
(defun recentf-ido-find-file ()
  "Find a recent file using Ido."
  (interactive)
  (let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
    (when file
      (find-file file))))
(global-set-key (kbd "<f12>") 'recentf-ido-find-file)


;;; ### Woman ###
;;; --- 手册查询
(setq woman-default-indent 7            ;缩进格式
      woman-fill-frame t                ;填充满屏幕
      woman-use-own-frame nil           ;同一个frame
      woman-cache-level 3)              ;缓存级别, 最快

;; occur
(define-key occur-mode-map "n" 'occur-next)
(define-key occur-mode-map "p" 'occur-prev)


(provide 'init-misc)
