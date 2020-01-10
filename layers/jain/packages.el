
;;; packages.el --- jain Layer packages File for Spacemacs
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
(setq jain-packages
      '(
        ;; package names go here
        web-mode
        ;; impatient-mode
        php
        ;; company-php
        ;; ac-php
        geben
        codebug
        (doxymacs :location local)
        sql
        ))

;; List of packages to exclude.
(setq jain-excluded-packages '())

;; For each package, define a function jain/init-<package-name>
;;
;; (defun jain/init-my-package ()
;;   "Initialize my package"
;;   )
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package

;; Fix youdao-dictionary-search `Invalid date:'
(defun url-cookie-expired-p (cookie)
  "Return non-nil if COOKIE is expired."
  (let ((exp (url-cookie-expires cookie)))
    (and (> (length exp) 0)
         (condition-case ()
             (> (float-time) (float-time (date-to-time exp)))
           (error nil)))))

(defun jain/post-init-web-mode ()
  "Initialize my package"
  (if (spacemacs/system-is-mswindows)
      (setq tern-command (cons (executable-find "tern") '()))
    )
  (add-hook 'web-mode-hook 'tern-mode)
  (push '(company-tern) company-backends-web-mode))

(defun jain/init-impatient-mode ()
  "Initialize impatient-mode"
  (use-package impatient-mode
    :defer t
    )
  )

(defun jain/post-init-sql ()
  (use-package format-sql
    :defer t
    )
  )

(defun jain/post-init-php ()
  (when (spacemacs/system-is-mswindows)
    (add-to-list 'load-path "~/.emacs.d/.cache/quelpa/build/php-extras")
    (require 'php-extras)
    )
  )

(defun jain/init-ac-php ()
  (add-hook 'php-mode-hook '(lambda ()
                              (require 'ac-php)
                              (define-key php-mode-map  (kbd "C-.") 'ac-php-find-symbol-at-point)   ;goto define
                              (define-key php-mode-map  (kbd "C-,") 'ac-php-location-stack-back   ) ;go back
                              ))
  (use-package ac-php
    :defer t
    )
  )

(defun jain/init-geben ()
  (use-package geben
    :defer t
    )
  )

(defun jain/init-codebug ()
  (use-package codebug
    :defer t
    )
  )

(defun jain/init-doxymacs ()
  "Initialize doxymacs"
  (use-package doxymacs
    :init
    (progn
      (add-hook 'c-mode-common-hook 'doxymacs-mode)
      (add-hook 'php-mode-common-hook 'doxymacs-mode))
    :config
    (progn
      (defun my-doxymacs-font-lock-hook ()
        (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode) (eq major-mode 'php-mode))
            (doxymacs-font-lock)))
      (add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook)
      (spacemacs|hide-lighter doxymacs-mode))))
