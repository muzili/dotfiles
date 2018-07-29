(package-initialize)
(org-babel-load-file "~/.emacs.d/start.org")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-auto-save t t)
 '(TeX-clean-confirm nil t)
 '(TeX-command-list
   (quote
    (("LaTeXMK" "latexmk -synctex=1 -quiet -xelatex %s" TeX-run-compile nil t :help "Process file with xelatexmk")
     ("View" "%V" TeX-run-discard-or-function nil t :help "Run Viewer"))) t)
 '(TeX-electric-escape nil t)
 '(TeX-electric-math (quote ("\\(" . "\\)")) t)
 '(TeX-electric-sub-and-superscript t t)
 '(TeX-parse-self t t)
 '(TeX-source-correlate-method (quote synctex) t)
 '(TeX-source-correlate-mode t t)
 '(custom-safe-themes
   (quote
    ("c3d4af771cbe0501d5a865656802788a9a0ff9cf10a7df704ec8b8ef69017c68" default)))
 '(flymake-proc-compilation-prevents-syntax-check nil t)
 '(package-selected-packages
   (quote
    (monokai-theme ivy yasnippet-snippets whitespace-cleanup-mode which-key web-mode use-package tide projectile nodejs-repl markdown-preview-mode magit lsp-vue lsp-ui lsp-rust lsp-java helm-flx godoctor go-guru go-eldoc git-timemachine git-gutter ggtags exec-path-from-shell emmet-mode dumb-jump dockerfile-mode company-reftex company-math company-lsp company-irony company-go company-anaconda cdlatex benchmark-init auctex)))
 '(reftex-plug-into-AUCTeX t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
