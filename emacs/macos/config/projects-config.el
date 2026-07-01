;; ============================================================
;; PROJECTS
;; ============================================================
(use-package projectile
  :ensure t
  :init (projectile-mode 1)
  :config
  (setq projectile-project-search-path '(("~/Projects/" . 0)
                                         ("~/Repos/" . 0)
                                         ("~/Workspaces" . 2))
        projectile-completion-system 'auto))

(use-package consult-projectile
  :ensure t
  :after (consult projectile)
  :config
  (global-unset-key (kbd "C-c p"))
  :bind
  ("M-o" . consult-projectile))

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(provide 'projects)
