;; ============================================================
;; SEARCH TOOLS
;; ============================================================

;; ripgrep - fast project search
(use-package rg
  :ensure t
  :bind
  (("C-c s p" . rg-project)
   ("C-c s s" . rg)
   ("C-c s d" . rg-dwim)))

;; wgrep - edit search results inline
(use-package wgrep
  :ensure t
  :config
  (setq wgrep-auto-save-buffer t))

;; avy - jump anywhere visible
(use-package avy
  :ensure t
  :bind
  (("C-;"   . avy-goto-char-2)
   ("M-g f" . avy-goto-line)
   ("M-g w" . avy-goto-word-1)))

;; anzu - show search count in modeline
(use-package anzu
  :ensure t
  :config (global-anzu-mode 1)
  :bind
  (("M-%"   . anzu-query-replace)
   ("C-M-%" . anzu-query-replace-regexp)))

(provide 'search-config)
