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
(setq ace-jump-mode-gray-background nil)
(setq ace-jump-mode-scope 'frame)

;; recentf
(recentf-mode 1)
(setq recentf-max-saved-items 400)      ;最近打开文件的最大数量
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


(defun qiang-comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command.
If no region is selected and current line is not blank and we are not at the end of the line,
then comment current line.
Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))
(global-set-key "\M-;" 'qiang-comment-dwim-line)


(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)


(provide 'init-misc)
