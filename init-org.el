(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.note$" . org-mode))
;; (global-set-key (kbd "C-c a" 'org-agenda)

;; Various preferences
(setq org-log-done t
      org-completion-use-ido t
      org-edit-timestamp-down-means-later t
      org-agenda-start-on-weekday nil
      org-agenda-span 14
      org-agenda-include-diary t
      org-agenda-window-setup 'current-window
      org-fast-tag-selection-single-key 'expert
      org-export-kill-product-buffer-when-displayed t
      org-tags-column 80
      org-startup-indented t)


; Refile targets include this file and any file contributing to the agenda - up to 5 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 5) (org-agenda-files :maxlevel . 5))))
; Targets start with the file name - allows creating level 1 tasks
(setq org-refile-use-outline-path (quote file))
; Targets complete in steps so we start with filename, TAB shows the next level of targets etc
(setq org-outline-path-complete-in-steps t)


(setq org-todo-keywords
      (quote ((sequence "TODO(t!)" "STARTED(s!)" "|" "DONE(d!/!)")
              (sequence "WAITING(w@/!)" "SOMEDAY(S)" "PROJECT(P@)" "|" "CANCELLED(c@/!)"))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org clock
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Save the running clock and all clock history when exiting Emacs, load it on startup
(setq org-clock-persistence-insinuate t)
(setq org-clock-persist t)
(setq org-clock-in-resume t)

;; Change task state to STARTED when clocking in
(setq org-clock-in-switch-to-state "STARTED")
;; Save clock data and notes in the LOGBOOK drawer
(setq org-clock-into-drawer t)
;; Removes clocked tasks with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t)

;; Show the clocked-in task - if any - in the header line
(defun sanityinc/show-org-clock-in-header-line ()
  (setq-default header-line-format '((" " org-mode-line-string " "))))

(defun sanityinc/hide-org-clock-from-header-line ()
  (setq-default header-line-format nil))

(add-hook 'org-clock-in-hook 'sanityinc/show-org-clock-in-header-line)
(add-hook 'org-clock-out-hook 'sanityinc/hide-org-clock-from-header-line)
(add-hook 'org-clock-cancel-hook 'sanityinc/hide-org-clock-from-header-line)

(eval-after-load 'org-clock
  '(progn
     (define-key org-clock-mode-line-map [header-line mouse-2] 'org-clock-goto)
     (define-key org-clock-mode-line-map [header-line mouse-1] 'org-clock-menu)))


;; ;; Show iCal calendars in the org agenda
;; (when *is-a-mac*
;;   (eval-after-load "org"
;;     '(if *is-a-mac* (require 'org-mac-iCal)))
;;   (setq org-agenda-include-diary t)

;;   (setq org-agenda-custom-commands
;;         '(("I" "Import diary from iCal" agenda ""
;;            ((org-agenda-mode-hook
;;              (lambda ()
;;                (org-mac-iCal)))))))

;;   (add-hook 'org-agenda-cleanup-fancy-diary-hook
;;             (lambda ()
;;               (goto-char (point-min))
;;               (save-excursion
;;                 (while (re-search-forward "^[a-z]" nil t)
;;                   (goto-char (match-beginning 0))
;;                   (insert "0:00-24:00 ")))
;;               (while (re-search-forward "^ [a-z]" nil t)
;;                 (goto-char (match-beginning 0))
;;                 (save-excursion
;;                   (re-search-backward "^[0-9]+:[0-9]+-[0-9]+:[0-9]+ " nil t))
;;                 (insert (match-string 0)))))
;;   )


(eval-after-load 'org
  '(progn
     (require 'org-exp)
     (require 'org-clock)
     ;;(require 'org-checklist)
     ;; (require 'org-fstree)
     ))

(add-hook 'org-mode-hook 'inhibit-autopair)

(setq org-directory "/home/db/Dropbox/org")
(setq org-default-notes-file (concat org-directory "/misc.org"))
(define-key global-map "\C-cc" 'org-capture)

;;; crypt
(require 'org-crypt)
(org-crypt-use-before-save-magic)
(setq org-tags-exclude-from-inheritance (quote ("crypt")))

(setq org-crypt-key nil)
;; GPG key to use for encryption
;; Either the Key ID or set to nil to use symmetric encryption.

(setq auto-save-default nil)
;; Auto-saving does not cooperate with org-crypt.el: so you need
;; to turn it off if you plan to use org-crypt.el quite often.
;; Otherwise, you'll get an (annoying) message each time you
;; start Org.

;; To turn it off only locally, you can insert this:
;;
;; # -*- buffer-auto-save-file-name: nil; -*-


;;; templates
(setq org-capture-templates
      '(("J" "Personal Journal" entry (file+datetree (concat org-directory "/PJournal.org"))
         "* %?\nCreated: %T\n	%i\n")
        ("j" "Journal" entry (file+datetree (concat org-directory "/dairy.org"))
         "* %?\nCreated: %T\n	%i\n")
        ("t" "TODO" entry (file+headline (concat org-directory "/todo.org") "Tasklist")
         "* TODO %?\n%U\n\n")
        ("n" "Take a note" entry (file (concat org-directory "/notes.org"))
         "* %?\n%U\n")
        ))

(add-hook 'org-mode-hook
          (lambda () (imenu-add-to-menubar "Imenu")))
;; By default the index is two levels deep--you can modify the depth
;; using the option `org-imenu-depth'.

(setq org-use-speed-commands t)

;;(setq org-agenda-file-regexp "\\`[^.].*\\.org|prj\\'")
(setq org-agenda-files   (quote ("/home/db/Dropbox/org")))

;;; conflict packages
(add-hook 'org-shiftup-final-hook 'windmove-up)
(add-hook 'org-shiftleft-final-hook 'windmove-left)
(add-hook 'org-shiftdown-final-hook 'windmove-down)
(add-hook 'org-shiftright-final-hook 'windmove-right)

; (add-hook 'org-mode-hook
          ; (lambda ()
            ; (org-set-local 'yas/trigger-key [tab])
            ; (define-key yas/keymap [tab] 'yas/next-field-or-maybe-expand)))

(setq org-tags-column -77)
(setq org-pretty-entities t)

(provide 'init-org)
