;;; extensions.el --- vbnet Layer extensions File for Spacemacs
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

(setq vbnet-pre-extensions
      '(
        ;; pre extension names go here
        vbnet-mode
        ))

(setq vbnet-post-extensions
      '(
        ;; post extension names go here
        ))

;; For each extension, define a function vbnet/init-<extension-name>
;;
;; (defun vbnet/init-my-extension ()
;;   "Initialize my extension"
;;   )
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package


(defun vbnet/init-vbnet-mode ()
  "Init vbnet mode"
  (use-package vbnet-mode
    :init
    (progn
      (autoload 'vbnet-mode "vbnet-mode" "Mode for editing VB.NET code." t)
      (setq auto-mode-alist (append '(("\\.\\(frm\\|bas\\|cls\\|vb\\)$" .
                                       vbnet-mode)) auto-mode-alist))
      )
    :config
    (progn
      (defun my-vbnet-mode-fn ()
        "My hook for VB.NET mode"
        (interactive)
        (turn-on-font-lock)
        (turn-on-auto-revert-mode)
        (setq indent-tabs-mode nil)
        (setq vbnet-mode-indent 4)
        (setq vbnet-want-imenu t)
        (require 'flymake)
        ;; (flymake-mode 1)
        (ggtags-mode 1)
        )
      (add-hook 'vbnet-mode-hook 'my-vbnet-mode-fn))
    )
  )
