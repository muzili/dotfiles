(package-initialize)
(org-babel-load-file "~/.emacs.d/start.org")

;http://emacsblog.org/2008/12/06/quick-tip-detaching-the-custom-file/
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)
