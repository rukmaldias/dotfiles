(setq inhibit-startup-message t)
(setq package-check-signature nil)
(setq visible-bell t)

(add-hook 'window-setup-hook 'toggle-frame-maximized t)

(set-face-attribute 'default nil :height 114)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode -1)

(global-display-line-numbers-mode 1)
(setq column-number-mode t)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
(package-initialize)

(when (not package-archive-contents)
    (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(all-the-icons all-the-icons-completion all-the-icons-dired
		   all-the-icons-gnus all-the-icons-ibuffer
		   all-the-icons-ivy all-the-icons-ivy-rich
		   all-the-icons-nerd-fonts cape company company-box
		   consult corfu marginalia nerd-icons
		   nerd-icons-completion nerd-icons-corfu
		   nerd-icons-dired nerd-icons-grep nerd-icons-ibuffer
		   nerd-icons-ivy-rich nerd-icons-xref orderless
		   projectile treemacs-icons-dired undo-tree vertico)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Default undo-tree bindings:
;; C-/     - undo
;; C-?     - redo  
;; C-x u   - visualize undo tree
(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode 1))
(setq undo-tree-auto-save-history t)

(add-hook 'dired-mode-hook 'dired-hide-details-mode)

(use-package nerd-icons-dired
  :ensure t
  :hook (dired-mode . nerd-icons-dired-mode))

(use-package all-the-icons
  :ensure t
  :if (display-graphic-p)
  :config
  (when (not (find-font (font-spec :name "all-the-icons")))
    (all-the-icons-install-fonts t)))

(use-package which-key
  :ensure t
  :config
  ;;(which-key-setup-side-window-right)
  (which-key-mode))

;; Treemacs
(use-package treemacs
  :ensure t
  :defer t
  :config
  (setq treemacs-width 35)
  (setq treemacs-follow-mode t)
  (setq treemacs-filewatch-mode t)
  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t)
  :bind
  ("C-c t t" . treemacs)
  ("C-c t f" . treemacs-find-file)
  ("C-c t w" . treemacs-switch-workspace))

(use-package company
  :ensure t
  :init (global-company-mode)
  :config
  (setq company-idle-delay 0.2
        company-minimum-prefix-length 1
        company-tooltip-align-annotations t))

(use-package company-box
  :ensure t
  :hook (company-mode . company-box-mode))

;; Projectile
(use-package projectile
  :ensure t
  :config
  (define-key projectile-mode-map (kbd "C-x p") 'projectile-command-map)
  (projectile-mode +1))

(use-package savehist
  :init
  (savehist-mode))

;; Enable vertico
(use-package vertico
  :ensure t
  :custom
  (vertico-count 18)
  (vertico-resize t)
  :init (vertico-mode))

;; Enable rich annotations
(use-package marginalia
  :ensure t
  :init (marginalia-mode))

;; Fuzzy matching everywhere
(use-package orderless
  :ensure t
  :init
  (setq completion-styles '(orderless)
        completion-category-defaults nil))

;; In-buffer popup completion
(use-package corfu
  :ensure t
  :init
  (global-corfu-mode))

;; Extend completion-at-point (cape)
(use-package cape
  :ensure t
  :init
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev))

;; Powerful command interface (M-x, buffer switching, etc.)
(use-package consult
  :ensure t
  :bind (
    ("C-s" . consult-line)
    ("M-y" . consult-yank-pop)
    ("S-<iso-lefttab>" . consult-buffer)))


;; Functions
(defun my-swap-buffers-between-windows ()
  "Swap the buffers in the current window and the next window."
  (interactive)
  (let ((this-buffer (window-buffer))
        (next-buffer (window-buffer (next-window))))
    (set-window-buffer (selected-window) next-buffer)
    (set-window-buffer (next-window) this-buffer)))

(defun my-comment-or-uncomment ()
  "Comment or uncomment current line or region."
  (interactive)
  (if (region-active-p)
      (comment-or-uncomment-region (region-beginning) (region-end))
    (comment-or-uncomment-region (line-beginning-position) (line-end-position))))

;; Shortcuts
(global-set-key (kbd "C-`") 'my-swap-buffers-between-windows)
(global-set-key (kbd "C-c /") 'my-comment-or-uncomment)
(global-set-key (kbd "C-<tab>") 'other-window)
