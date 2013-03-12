(setq-default major-mode 'text-mode)
(electric-pair-mode t)
(setq kill-read-only-ok t)
(setq kill-do-not-save-duplicates t)

(global-set-key (kbd "C-w") 'backward-kill-word)
(global-set-key (kbd "C-x C-w") 'kill-region)

;; [M-q] fill-paragrah
(setq-default fill-column 76)
(auto-fill-mode t)
;;设置 sentence-end 可以识别中文标点。不用在 fill 时在句号后插入两个空
;;格。
(setq sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
(setq sentence-end-double-space nil)

(defun copy-above-to-char (arg char)
  "Copy all characters from the previous line beginning with the
character currently above the cursor up to the ARGth occurrence
of CHAR."
  (interactive "p\ncCopy to char: ")
  (let* ((col (current-column))
         (n (save-excursion
              (forward-line -1)
              (move-to-column col)
              (search-forward (char-to-string char)
                              (line-end-position) nil arg)
              (- (current-column) col))))
    (copy-from-above-command n)))


(autoload 'copy-from-above-command "misc"
  "Copy characters from previous nonblank line, starting just above point.
  \(fn &optional arg)"
  'interactive)

(global-set-key (kbd "C-<up>")
		(lambda ()
		  (interactive)
		  (copy-from-above-command 1)))


(provide 'init-edit)
