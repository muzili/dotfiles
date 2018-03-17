(package-initialize)
(org-babel-load-file "~/.emacs.d/start.org")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (rust-mode go-guru godoctor go-eldoc yasnippet-snippets whitespace-cleanup-mode web-mode use-package tide projectile nodejs-repl markdown-preview-mode magit lsp-vue lsp-ui helm-mu helm-flx git-timemachine git-gutter exec-path-from-shell emmet-mode dockerfile-mode company-lsp company-irony company-go company-anaconda benchmark-init))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-mode-line-clock ((t (:foreground "red" :box (:line-width -1 :style released-button)))) t))
