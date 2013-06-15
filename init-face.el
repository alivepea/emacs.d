;; initial appearance

;; theme
;; (color-theme-initialize)
;; (color-theme-classic)
(load-theme 'tango-dark t)

(set-face-attribute 'default nil
	       :height 120)

(setq inhibit-startup-message t) 
(set-scroll-bar-mode nil)
(tool-bar-mode -1)
(menu-bar-mode -1)
;; title
(setq frame-title-format
      '(buffer-file-name
        "%f"
        (dired-directory dired-directory "%b"))) ;display filename or buffer-name

(setq scroll-conservatively 101
      scroll-margin 2)
;; mouse
(blink-cursor-mode -1)
(mouse-avoidance-mode 'exile)
;; (toggle-cursor-type-when-idle 1)
;; modeline
(setq column-number-mode t
      line-number-mode t)

;; minibuffer
(fset 'yes-or-no-p 'y-or-n-p)

(show-paren-mode t)
(setq show-paren-style 'parenthesis)
(setq x-stretch-cursor t)
(setq-default show-trailing-whitespace t)

;; Setting English Font
(set-face-attribute
  'default nil :font "Dejavu Sans Mono 12")

;; Chinese Font
(dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font)
                      charset
                      (font-spec :family "WenQuanYi Micro Hei" :size 16)))

;; For Linux
(global-set-key (kbd "<C-mouse-4>") 'text-scale-increase)
(global-set-key (kbd "<C-mouse-5>") 'text-scale-decrease)

;; For Windows
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)


(provide 'init-face)
