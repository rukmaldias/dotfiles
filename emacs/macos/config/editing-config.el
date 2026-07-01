;; undo-tree
(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode)
  (setq undo-tree-auto-save-history t)
  (setq undo-tree-history-directory-alist
        '(("." . "~/.emacs.d/undo-tree-history/")))

  ;; Suppress read errors silently
  (setq undo-tree-load-history-hook
        (lambda ()
          (ignore-errors
            (undo-tree-load-history)))))

;; multiple-cursors
(use-package multiple-cursors
  :ensure t
  :bind
  (("C->"     . mc/mark-next-like-this)
   ("C-<"     . mc/mark-previous-like-this)
   ("C-c C-<" . mc/mark-all-like-this)
   ("C-c m"   . mc/edit-lines)))

;; expand-region
(use-package expand-region
  :ensure t
  :bind ("C-=" . er/expand-region))

;; smartparens
(use-package smartparens
  :ensure t
  :hook (prog-mode . smartparens-mode)
  :config (require 'smartparens-config))

;; aggressive-indent
(use-package aggressive-indent
  :ensure t
  :hook (prog-mode . aggressive-indent-mode))

;; goto-chg
(use-package goto-chg
  :ensure t
  :bind
  (("C-c g ." . goto-last-change)
   ("C-c g ," . goto-last-change-reverse)))

;; string-inflection
(use-package string-inflection
  :ensure t
  :bind ("C-c i" . string-inflection-cycle))

;; move-text
(use-package move-text
  :ensure t
  :bind
  (("M-S-<up>"   . move-text-up)
   ("M-S-<down>" . move-text-down)))

;; hungry-delete
(use-package hungry-delete
  :ensure t
  :config (global-hungry-delete-mode))

;; duplicate-thing
(use-package duplicate-thing
  :ensure t
  :bind ("C-c C-d" . duplicate-thing))

;; rainbow-delimiters
(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

;; symbol-overlay
(use-package symbol-overlay
  :ensure t
  :hook (prog-mode . symbol-overlay-mode)
  :bind
  (("M-i" . symbol-overlay-put)
   ("M-n" . symbol-overlay-jump-next)
   ("M-p" . symbol-overlay-jump-prev)))

;; highlight-indent-guides
(use-package highlight-indent-guides
  :ensure t
  :hook (prog-mode . highlight-indent-guides-mode)
  :config
  (setq highlight-indent-guides-method 'character))

;; whitespace cleanup
(use-package whitespace-cleanup-mode
  :ensure t
  :hook (prog-mode . whitespace-cleanup-mode))

(provide 'editing)
