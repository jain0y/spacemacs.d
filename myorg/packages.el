;;; packages.el --- myorg Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2014 Sylvain Benner
;; Copyright (c) 2014-2015 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; List of all packages to install and/or initialize. Built-in packages
;; which require an initialization must be listed explicitly in the list.
(setq myorg-packages
      '(
        ;; package names go here
        org
        ))

;; List of packages to exclude.
(setq myorg-excluded-packages '())

;; For each package, define a function myorg/init-<package-name>
;;
;; (defun myorg/init-my-package ()
;;   "Initialize my package"
;;   )
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package

(defun myorg/post-init-org ()
  (myorg/init-myorg-capture)
  (myorg/init-myorg-export-pdf)
  (myorg/init-myorg-publish)
  )

(defun myorg/init-myorg-export-pdf ()
  (progn
    "Org export to pdf"
    (setq org-latex-pdf-process
          '(
            "xelatex -interaction nonstopmode -output-directory %o %f"
            "xelatex -interaction nonstopmode -output-directory %o %f"
            "xelatex -interaction nonstopmode -output-directory %o %f"
            "rm -fr %b.out %b.log %b.tex auto"))

    (add-to-list 'org-latex-classes
                 '("ctexart" 
                   "\\documentclass[11pt]{
                 [NO-DEFAULT-PACKAGES]
                 \\usepackage[utf8]{inputenc}
                 \\usepackage[T1]{fontenc}
                 \\usepackage{fixltx2e}
                 \\usepackage{graphicx}
                 \\usepackage{longtable}
                 \\usepackage{float}
                 \\usepackage{wrapfig}
                 \\usepackage{rotating}
                 \\usepackage[normalem]{ulem}
                 \\usepackage{amsmath}
                 \\usepackage{textcomp}
                 \\usepackage{marvosym}
                 \\usepackage{wasysym}
                 \\usepackage{amssymb}
                 \\usepackage{booktabs}
                 \\usepackage[colorlinks,linkcolor=black,anchorcolor=black,citecolor=black]{hyperref}
                 \\tolerance=1000
                 \\usepackage{listings}
                 \\usepackage{xcolor}
                 \\lstset{
                 %�к�
                 numbers=left,
                 %������
                 framexleftmargin=10mm,
                 frame=none,
                 %����ɫ
                 %backgroundcolor=\\color[rgb]{1,1,0.76},
                 backgroundcolor=\\color[RGB]{245,245,244},
                 %��ʽ
                 keywordstyle=\\bf\\color{blue},
                 identifierstyle=\\bf,
                 numberstyle=\\color[RGB]{0,192,192},
                 commentstyle=\\it\\color[RGB]{0,96,96},
                 stringstyle=\\rmfamily\\slshape\\color[RGB]{128,0,0},
                 %��ʾ�ո�
                 showstringspaces=false
                 }
                 "
                   ("\\section{%s}" . "\\section*{%s}")
                   ("\\subsection{%s}" . "\\subsection*{%s}")
                   ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                   ("\\paragraph{%s}" . "\\paragraph*{%s}")
                   ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
    (setq org-latex-default-class "ctexart")

    (setq org-latex-listings t)

    ;; Options for \lset command��reference to listing Manual)
    (setq org-latex-listings-options
          '(
            ("basicstyle" "\\color{foreground}\\small\\mono")           ; Դ����������ʽ
            ("keywordstyle" "\\color{function}\\bfseries\\small\\mono") ; �ؼ���������ʽ
            ("identifierstyle" "\\color{doc}\\small\\mono")
            ("commentstyle" "\\color{comment}\\small\\itshape")         ; ��ע��ʽ
            ("stringstyle" "\\color{string}\\small")                    ; �ַ�����ʽ
            ("showstringspaces" "false")                                ; �ַ����ո���ʾ
            ("numbers" "left")                                          ; �к���ʾ
            ("numberstyle" "\\color{preprocess}")                       ; �к���ʽ
            ("stepnumber" "1")                                          ; �кŵ���
            ("backgroundcolor" "\\color{background}")                   ; ����򱳾�ɫ
            ("tabsize" "4")                                             ; TAB��Ч�ո���
            ("captionpos" "t")                                          ; ����λ�� top or buttom(t|b)
            ("breaklines" "true")                                       ; �Զ�����
            ("breakatwhitespace" "true")                                ; ֻ�ڿո����
            ("showspaces" "false")                                      ; ��ʾ�ո�
            ("columns" "flexible")                                      ; ����ʽ
            ("frame" "single")                                          ; �������Ӱ��
            ("frameround" "tttt")                                       ; ����� Բ��
            ("framesep" "0pt")
            ("framerule" "8pt")
            ("rulecolor" "\\color{background}")
            ("fillcolor" "\\color{white}")
            ("rulesepcolor" "\\color{comdil}")
            ("framexleftmargin" "10mm")
            )))
  )

(defun myorg/init-myorg-publish ()
  (progn
    "Org publish project"
    (setq org-publish-project-alist
          '(("note-org"
             :base-directory "E:/Mine//Documents/notes/src"
             :publishing-directory "E:/Mine/Documents/notes/publish"
             :base-extension "org"
             :recursive t
             :publishing-function org-publish-org-to-html
             :auto-index t
             :index-filename "index.org"
             :index-title "index"
             :link-home "index.html"
             :section-numbers t
             :style "<link rel=\"stylesheet\" href=\"./wheer.css\" type=\"text/css\"/>")
            ("note-static"
             :base-directory "~/Documents/notes/org/src"
             :publishing-directory "~/Documents/notes/publish"
             :recursive t
             :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|swf\\|zip\\|gz\\|txt\\|el"
             :publishing-function org-publish-attachment)
            ("note" 
             :components ("note-org" "note-static")
             :author "jain_y@126.com"
             )))
    (setq org-export-htmlize-output-type 'inline-css)
    )
  )

(defun myorg/init-myorg-capture ()
  (progn
    "Org capture templates"
    ;; org-capture-templates
    (setq org-capture-templates
          '(("t" "Todo" entry (file+headline "E:/Company/TODO/gtd.org" "Tasks")
             "* TODO %?\n  %i" :prepend t)

            ("j" "Journal" entry (file+datetree "E:/Mine/Documents/notes/src/notes/journal.org" "Journal")
             "* %?\nEntered on %U\n %i\n %a" :prepend t :empty-lines 1)

            ("w" "WorkNote" entry (file+headline "E:/Mine/Documents/notes/src/notes/worknotes.org" "WorkNotes")
             "* %U %?\n\n  %i" :prepend t :empty-lines 1)

            ("l" "LifeNote" entry (file+headline "E:/Mine/Documents/notes/src/notes/liftnotes.org" "LiftNotes")
             "* %U %?\n\n  %i" :prepend t :empty-lines 1)

            ("s" "StudyNot" entry (file+headline "E:/Mine/Documents/notes/src/notes/studynotes.org" "StudyNotes")
             "* %U %?\n\n  %i" :prepend t :empty-lines 1)
            ))

    (setq org-agenda-files (list  "E:/Company/TODO/gtd.org"
                                  "E:/Mine/Documents/notes/src/notes/liftnotes.org"
                                  "E:/Mine/Documents/notes/src/notes/journal.org"
                                  "E:/Mine/Documents/notes/src/notes/worknotes.org"
                                  "E:/Mine/Documents/notes/src/notes/studynotes.org")))
  )
