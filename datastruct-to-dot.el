;;; NOTE: Refer to https://github.com/yangyingchao/tubo-env/blob/master/.emacs.d/rc/01-rc-functions.el for newer version. 
;; Function used to add fields of struct into a dot file (for Graphviz).

;;;;; Dot templates

(defconst yc/dot-head "subgraph cluster_%s {
    node [shape=record fontsize=12 fontname=Courier style=filled];
    color = lightgray;
    style=filled;
    label = \"%s %s\";
    edge[color=\"brown\"];"
  "Header part of dot file.")
(defconst yc/dot-tail "
}"
  "Tail part of dot")
(defconst yc/dot-node-head
  "node_%s[shape=record
            label=\"{<f0>*** %s %s ***|\\"
  "Format of node.")
(defconst yc/dot-node-tail "
}\"];"
  "Format of node.")

(defconst attr_str "
<f%d>+%s : %s\\l|\\" "nil")

(defconst attr_func "
-%s() : %s\\l\\" "nil")

;;;;; Regular expressions to match a field of a struct.
(defconst r_attr_str
  (rx bow (group (+ (or alnum "_" blank "*"))) (one-or-more blank)
      (group (+ alnum) (+? ascii)) ";")
  "Regular expression for matching struct fields.")
(defconst r_name
  (rx (zero-or-one "typedef") (zero-or-more blank)
      (group (or "class" "struct")) (zero-or-more blank)
      (zero-or-one (group (+? (or alnum "_" )))) (zero-or-more blank)
      (zero-or-one ":" (+? (or alnum "_" blank)))
      (zero-or-more "
") (zero-or-more blank) "{"
(1+ anything) "}" (zero-or-more blank)
(zero-or-one (group (zero-or-more not-newline)) ";")
)
"Regular expression for mating struct name")

(defconst r_func_l "\(.*"
  "Regular expression to match a function")
(defconst r_func_r ".*\)"
  "Regular expression to match a function")


(defconst r_comments
  (rx line-start (zero-or-more blank) (or "//" "/*")
      (zero-or-more anything) line-end)
  "Regular expression to match a commentted field.")

(defconst r_struct_func
  "^[ \t]*\\(.+?\\)[ \t]*\(\\*\\(.*?\\)\)[ \t]*(\\(?:.\\|\\)*?);"
  "Regular expression to match a function decleration in a struct.")

(defconst r_match_semicol
  (rx (+? anything) ";"))

(defconst r_match_attr
  (rx (+? (not (any "(" ")" "{" "}"))) ";"))

(defconst r_match_func
  (rx (zero-or-more blank) (zero-or-one (group (+? (or alnum "_" blank)))) (one-or-more blank)
      (group (+? (or alnum "_")))
      (zero-or-more blank) "(" (*? anything) ");"))

(defconst r_match_tag
  (rx (zero-or-more blank) (zero-or-one "typedef" (one-or-more  blank))
      (or "struct" "class") (zero-or-more (or alnum "_" ":" blank))
      (zero-or-one "
") (zero-or-more blank) "{" ))

(defconst r_c_comment
  (rx "/*" (*? anything) "*/")
  "Regular expression to match comment of C style.")
(defconst r_cpp_comment
  (rx "//" (*? not-newline) line-end)
  "Regular expression to match comment of C style.")

(defun clean_c_comment (a)
  "Function to remove all comments, both C style and C++ style."
  (let ((all-clean nil)
        (result nil)
        (tmp 0))

    (while (not all-clean)
      (setq result
            (if (string-match r_c_comment a)
                (progn
                  (cons (match-beginning 0)
                        (match-end 0)))
              nil))
      (if result
          (progn
            (setq tmp (car result))
            (while (< tmp (cdr result))
              (aset a tmp ? )
              (setq tmp (1+ tmp))))
        (setq all-clean t)))

    (setq all-clean nil)
    (setq result nil)

    (while (not all-clean)
      (setq result (if (string-match r_cpp_comment a)
                       (progn
                         (cons (match-beginning 0)
                               (match-end 0)))
                     nil))
      (if result
          (progn
            (princ result)
            (setq tmp (car result))
            (while (< tmp (cdr result))
              (aset a tmp ? )
              (setq tmp (1+ tmp))))
        (setq all-clean t)
        )))
  (replace-regexp-in-string " +" " " a))


(defun get_struct_tag (decleration)
  "Abstract decleration from a string"
  (message decleration)
  (if (string-match r_name decleration 0)
      (progn
        (cons (match-string 1 decleration)
              (if (and (match-string 3 decleration)
                       (> (length (match-string 3 decleration)) 0))
                  (match-string 3 decleration)
                (if (match-string 2 decleration)
                    (match-string 2 decleration)
                  "nil"))))
    '("struct" . "nil")))

(defun skip(msg x)
  (if x
      (message (format "Skip invalid syntax for function: %s." msg))
    (message (format "Skip invalid syntax for struct field: %s." msg))
    )
  )

(defun yc/struct-to-dot (start end)
  "generate c++ function definition and insert it into `buffer'"
  (interactive "rp")
  (let* (
         (var-name "")
         (var-type "")
         (counter 0)
         (pos-end 0)
         (var-defination (buffer-substring-no-properties start end))
         (item_str "")
         (tmp-item nil)
         (attr-list '())
         (func-list '())
         (tag-info nil)
         (item-iter 0)
         )
    (defun iter (pos)
      (if (string-match r_match_tag var-defination pos) ;; Declerad a struct
          (progn
            (setq pos-end (match-end 0))
            (setq tag-info (get_struct_tag var-defination))
            (princ tag-info)
            (iter (1+ pos-end)))
        (progn
          (if (string-match r_match_semicol var-defination pos)
              (progn
                (setq pos-end (match-end 0))
                (setq item_str (substring var-defination pos pos-end))
                (if (string-match r_match_func item_str 0) ;; Function
                    (progn
                      (setq var-type
                            (if (match-string 1 item_str)
                                (match-string 1 item_str)
                              " "))
                      (setq var-name
                            (match-string 2 item_str))
                      (add-to-list 'func-list (cons var-type var-name)))
                  (progn
                    (if (equal (string-match r_match_attr item_str 0) 0)
                        (progn
                          (if (string-match r_attr_str item_str 0)
                              (progn
                                (setq var-type
                                      (match-string 1 item_str))
                                (setq var-name
                                      (match-string 2 item_str))
                                (add-to-list 'attr-list (cons var-type var-name)))
                            (skip item_str nil)))
                      (skip item_str nil))))
                (iter pos-end))))))
    (save-excursion
      (setq var-defination (clean_c_comment var-defination))
      (iter 0)
      (set-buffer (get-buffer-create "tmp.dot"))
      (graphviz-dot-mode)
      (erase-buffer)

      (goto-char (point-max))
      (insert (format yc/dot-node-head
                      (cdr tag-info)
                      (car tag-info)
                      (cdr tag-info)))

      (setq item-iter (1- (length attr-list)))
      (while (>= item-iter 0)
        (setq counter (+ counter 1))
        (setq tmp-item (nth item-iter attr-list))
        (insert (format attr_str  counter
                        (cdr tmp-item)
                        (car tmp-item)))
        (setq item-iter (1- item-iter)))

      (if func-list
          (progn
            (setq item-iter (1- (length func-list)))
            (while (>= item-iter 0)
              (setq counter (+ counter 1))
              (setq tmp-item (nth item-iter func-list))
              (insert (format attr_func
                              (cdr tmp-item)
                              (car tmp-item)))
              (setq item-iter (1- item-iter)))
            (insert "
|\\"))
        )


      (goto-char (point-max))
      (delete-char -1)
      (insert "<f999>\\" yc/dot-node-tail))
    (if (one-window-p)
        (split-window-vertically))
    (switch-to-buffer-other-window "tmp.dot")
    (kill-ring-save (point-min) (point-max))
    (goto-char (point-min))
    )
  (message "Finished, node copied to killing-ring."))


(provide 'datastruct-to-dot)
