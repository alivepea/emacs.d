;; Function used to add fields of struct into a dot file (for Graphviz).
;; http://tubocurarine.is-programmer.com/posts/27164.html

(defconst yyc/dot-head "subgraph cluster_%s {
    node [shape=record fontsize=12 fontname=Courier style=filled];
    color = lightgray;
    style=filled;
    label = \"Struct %s\";
    edge[color=\"#2e3436\"];"
  "Header part of dot file.")
(defconst yyc/dot-tail "
}"
  "Tail part of dot")
(defconst yyc/dot-node-head
  "
    node_%s[shape=record
            label=\"<f0>*** STRUCT %s ***|\\"
  "Format of node.")
(defconst yyc/dot-node-tail "
\"];"
  "Format of node.")

(defconst r_attr_str "[ \t]+\\(.*+\\)[ \t]+\\(.*?\\);\\([ \t]*/[/\\*].*\\)?$"
  "Regular expression for matching struct fields.")

(defconst r_name "\\_<\\(typedef[ \t]+\\)?struct[ \t]+\\(.*\\)?[ \t]*{"
  "Regular expression for mating struct name")

(defconst r_func_l "\(.*"
  "Regular expression to match a function")
(defconst r_func_r ".*\)"
  "Regular expression to match a function")

(defconst r_comments "^[ \t/\\*][/\\*]+"
  "Regular expression to match a commentted field.")

(defconst attr_str "
<f%d>+%s : %s\\l|\\" "nil")

(defconst attr_func "
<f%d>-%s : %s\\l|\\" "nil")

(defun yyc/datastruct-to-dot (start end)
  "generate c++ function definition and insert it into `buffer'"
  (interactive "rp")
  (setq var-defination (buffer-substring-no-properties start end))
  (let* ((tmp_str "")
         (var-name "")
         (var-type "")
         (counter 0)
         (struct-name "")
         (header-str "")
         (next-begin 0)
         )
    (defun iter (pos)
      (if (string-match r_name var-defination pos)
          (progn
            (setq counter (+ counter 1))
            (setq struct-name
                  (match-string 2 var-defination))
            (setq header-str
                  (format yyc/dot-head struct-name struct-name))
            (setq tmp_str
                  (format yyc/dot-node-head struct-name struct-name))
            (iter (match-end 0)))
        (if (string-match r_attr_str var-defination pos)
            (progn
              (setq var-type
                    (match-string 1 var-defination))
              (setq var-name
                    (match-string 2 var-defination))
              (setq next-begin (match-end 0))
              (if (or
                   (string-match r_func_l var-type 0) ;Skip function.
                   (string-match r_func_r var-name 0)
                   (string-match r_comments var-type 0) ;Comments
                   )
                  nil
                (progn
                  (setq counter (+ counter 1))
                  (setq tmp_str
                        (concat tmp_str
                                (format attr_str
                                        counter var-name var-type)))))
              (iter next-begin))
          nil)))
    (save-excursion
      (iter 0)
      (set-buffer (get-buffer-create "tmp.dot"))
      (graphviz-dot-mode)
      (setq pos (point-max))
      (insert  header-str tmp_str )
      (goto-char (point-max))
      (delete-char -1)
      (insert "<f999>\\"yyc/dot-node-tail yyc/dot-tail)
      )
    (if (one-window-p)
        (split-window-vertically))
    (switch-to-buffer-other-window "tmp.dot")
    (goto-char (point-min))
    )
  (message "Finished, please see *tmp.dot* buffer."))

(provide 'datastruct-to-dot)
