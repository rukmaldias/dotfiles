;; ============================================================
;; LANGUAGE MODES
;; ============================================================
(use-package rust-mode
  :ensure t
  :hook (rust-mode . (lambda ()
                       (setq indent-tabs-mode nil)
                       (setq tab-width 4))))

(use-package kotlin-mode
  :ensure t
  :mode "\\.kt\\'"
  :hook (kotlin-mode . lsp))

(use-package go-mode
  :ensure t
  :hook (go-mode . (lambda ()
                     (setq tab-width 4)
                     (setq indent-tabs-mode t))))

(use-package dockerfile-mode
  :ensure t
  :mode ("Dockerfile\\'" . dockerfile-mode))

;; Docker compose support
(use-package docker-compose-mode
  :ensure t
  :mode ("docker-compose\\.yml\\'" . docker-compose-mode))

;; Docker management UI (optional)
(use-package docker
  :ensure t
  :bind ("C-c d" . docker))

(provide 'languages)
