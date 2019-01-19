(package-initialize)
(org-babel-load-file "~/.emacs.d/start.org")

;http://emacsblog.org/2008/12/06/quick-tip-detaching-the-custom-file/
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file 'noerror))
