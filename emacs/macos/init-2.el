;; ============================================================
;; BASIC UI & STARTUP
;; ============================================================
(setq inhibit-startup-message t)
(setq vissible-bell t)
(setq ring-bell-function 'ignore)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1)

(add-hook 'window-setup-hook 'toggle-frame-maximized t)

(set-face-attribute 'default nil :height 144)

(setq gc-cons-threshold (* 100 1024 1024))
(setq read-process-output-max (* 1024 1024))

;; ============================================================
;; MAC MODIFIER KEYS
;; ============================================================
(setq mac-option-modifier 'meta)     ;; Option = Meta (Alt-like)
(setq mac-command-modifier 'super)   ;; Command = Super
(setq mac-control-modifier 'control) ;; Control stays Control
(setq mac-function-modifier 'hyper)  ;; Function = Hyper (optional)

;; ============================================================
;; LINE & COLUMN NUMBERS, PRINT MARGIN
;; ============================================================
(global-display-line-numbers-mode 1)
(setq line-number-mode t)
(setq column-number-mode t)

(setq-default fill-column 80)
(setq display-fill-column-indicator-character ?\│)

(defvar my-margin-modes
  '(emacs-lisp-mode python-mode c-mode c++-mode
    java-mode rust-mode sh-mode go-mode)
  "Modes that should show the 80-column fill indicator.")

(defun my-enable-fill-column-indicator ()
  "Enable 80-col indicator for coding buffers."
  (when (apply #'derived-mode-p my-margin-modes)
    (display-fill-column-indicator-mode 1)))

(dolist (mode my-margin-modes)
  (add-hook (intern (concat (symbol-name mode) "-hook"))
            #'my-enable-fill-column-indicator))

(set-face-attribute 'fill-column-indicator nil
                    :foreground "#e6e7e8"
                    :background 'unspecified)

;; ============================================================
;; PACKAGE MANAGEMENT
;; ============================================================
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
(package-initialize)

;; ============================================================
;; THEME
;; ============================================================
(use-package base16-theme
  :ensure t
  :config
  (load-theme 'base16-atelier-sulphurpool-light t)
  (custom-set-faces
   '(mode-line-buffer-id ((t (:foreground "white"))))))

;; ============================================================
;; MODELINE
;; ============================================================
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom-face
  (mode-line-active ((t (:background "#22242b"))))
  (mode-line-inactive ((t (:background "#dfe2f1")))))

;; ============================================================
;; WHICH-KEY
;; ============================================================
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; ============================================================
;; SAVEHIST
;; ============================================================
(use-package savehist
  :init
  (savehist-mode))

;; ============================================================
;; VERTICO
;; ============================================================
(use-package vertico
  :ensure t
  :custom
  (vertico-count 18)
  (vertico-resize t)
  :init
  (vertico-mode)
  :config
  (setq vertico-buffer-display-action
        '(display-buffer-in-side-window
          (side . right)
          (window-width . 0.33)))

  (setq vertico-multiform-commands
        '((consult-imenu       buffer indexed)
          (consult-imenu-multi buffer indexed)
          (consult-outline     buffer indexed)
          (consult-buffer      buffer)
          (consult-grep        buffer)
          (consult-ripgrep     buffer)))

  (vertico-multiform-mode 1))

;; ============================================================
;; MARGINALIA
;; ============================================================
(use-package marginalia
  :ensure t
  :config
  (marginalia-mode 1))

;; ============================================================
;; ICONS
;; ============================================================
(use-package nerd-icons-dired
  :ensure t
  :hook (dired-mode . nerd-icons-dired-mode))

(use-package all-the-icons
  :ensure t
  :if (display-graphic-p)
  :config
  (when (not (find-font (font-spec :name "all-the-icons")))
    (all-the-icons-install-fonts t)))

(use-package nerd-icons-completion
  :after marginalia
  :config
  (nerd-icons-completion-mode)
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

;; ============================================================
;; ORDERLESS
;; ============================================================
(use-package orderless
  :ensure t
  :init
  (setq completion-styles '(orderless)
        completion-category-defaults nil))

;; ============================================================
;; CONSULT
;; ============================================================
(use-package consult
  :bind (("C-c M-x" . consult-mode-command)
         ("C-c h" . consult-history)
         ("C-c k" . consult-kmacro)
         ("C-c m" . consult-man)
         ("C-c i" . consult-info)
         ([remap Info-search] . consult-info)
         ("C-x M-:" . consult-complex-command)
         ("C-x b" . consult-buffer)
         ("C-x 4 b" . consult-buffer-other-window)
         ("C-x 5 b" . consult-buffer-other-frame)
         ("C-x t b" . consult-buffer-other-tab)
         ("C-x r b" . consult-bookmark)
         ("C-x p b" . consult-project-buffer)
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)
         ("C-M-#" . consult-register)
         ("M-y" . consult-yank-pop)
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)
         ("M-g g" . consult-goto-line)
         ("M-g M-g" . consult-goto-line)
         ("M-g o" . consult-outline)
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ("M-s d" . consult-find)
         ("M-s c" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)
         ("M-s e" . consult-isearch-history)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         :map minibuffer-local-map
         ("M-s" . consult-history)
         ("M-r" . consult-history))

  :hook (completion-list-mode . consult-preview-at-point-mode)

  :init
  (advice-add #'register-preview :override #'consult-register-window)
  (setq register-preview-delay 0.5)
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  :config
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep consult-man
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   :preview-key '(:debounce 0.4 any))

  (setq consult-narrow-key "<"))

;; ============================================================
;; HISTORY & RECENT FILES
;; ============================================================
(savehist-mode 1)
(recentf-mode 1)

;; ============================================================
;; LANGUAGE MODES
;; ============================================================
(use-package go-mode
  :ensure t
  :hook (go-mode . (lambda ()
                     (setq tab-width 4)
                     (setq indent-tabs-mode t))))

(use-package rust-mode
  :ensure t
  :hook (rust-mode . (lambda ()
                       (setq indent-tabs-mode nil)
                       (setq tab-width 4))))

;; ============================================================
;; MINIBUFFER
;; ============================================================
(setq enable-recursive-minibuffers t)
(minibuffer-depth-indicate-mode 1)

;; ============================================================
;; VERTICO KEYMAP
;; ============================================================
(with-eval-after-load 'vertico
  (define-key vertico-map (kbd "C-<tab>") #'other-window))

;; ============================================================
;; ORG ROAM
;; ============================================================
;; (use-package org-roam
;;   :init
;;   :custom
;;   (org-roam-directory (file-truename "/Users/rukmaldias/Documents/Org/org-roam")))

(use-package org
  :ensure t
  :init
  ;; Load babel languages including ditaa
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((ditaa . t)
     (dot . t)
     (plantuml . t)
     (emacs-lisp . t)
     (shell . t)))
  
  :hook
  ;; Auto-refresh inline images after executing code blocks
  (org-babel-after-execute . org-redisplay-inline-images)
  
  :custom
  (org-roam-directory (file-truename "/Users/rukmaldias/Documents/Org/org-roam"))
  ;; ditaa jar path - adjust this to your actual path
  (org-ditaa-jar-path "~/Libraries/ditaa.jar")
  
  ;; Optional: ditaa options
  (org-ditaa-options "-r -s 0.8")  ; -r removes separation, -s scales
  
  ;; Don't ask for confirmation before evaluating ditaa blocks
  (org-confirm-babel-evaluate nil)
  
  ;; Other org settings
  (org-edit-src-content-indentation 0)
  (org-plantuml-jar-path "~/Libraries/plantuml.jar")
  
  ;; Enable inline image display
  (org-startup-with-inline-images t)
  
  ;; Configure image width
  ;;(org-image-actual-width '(600))
  (org-image-actual-width nil)
  
  ;; LaTeX process for SVG support
  (org-latex-pdf-process
   '("%latex -shell-escape -interaction nonstopmode -output-directory %o %f"
     "bibtex %b"
     "%latex -shell-escape -interaction nonstopmode -output-directory %o %f"
     "%latex -shell-escape -interaction nonstopmode -output-directory %o %f")))

;; Optional: Add keybindings for org-babel
(with-eval-after-load 'org
  (define-key org-mode-map (kbd "C-c C-v C-v") 'org-babel-execute-src-block)
  (define-key org-mode-map (kbd "C-c C-v C-b") 'org-babel-execute-buffer)
  (define-key org-mode-map (kbd "C-c C-x C-v") 'org-toggle-inline-images))

;; ============================================================
;; KEYBINDINGS
;; ============================================================
(global-set-key (kbd "s-<down>") #'my/forward-10-lines)
(global-set-key (kbd "s-<up>")   #'my/backward-10-lines)
(global-set-key (kbd "M-<up>")   'beginning-of-buffer)
(global-set-key (kbd "M-<down>") 'end-of-buffer)
(global-set-key (kbd "C-<tab>")  'other-window)
(global-set-key (kbd "C-`")      'my-swap-buffers-between-windows)
(global-set-key (kbd "C-c /")    'my-comment-or-uncomment)
(global-set-key (kbd "C-SPC")    'execute-extended-command)
(global-set-key (kbd "S-<tab>")  'consult-buffer)

;; ============================================================
;; CUSTOM FUNCTIONS
;; ============================================================
(defun my/forward-10-lines ()
  (interactive)
  (forward-line 10))

(defun my/backward-10-lines ()
  (interactive)
  (forward-line -10))

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

(defun my/toggle-consult-buffer ()
  "Toggle consult-buffer side window."
  (interactive)
  (if (get-buffer-window "*vertico-buffer*")
      (delete-window (get-buffer-window "*vertico-buffer*"))
    (consult-buffer)))

;; ============================================================
;; GARBAGE COLLECTOR MAGIC-HACK
;; ============================================================
(use-package gcmh
  :ensure t
  :config
  (gcmh-mode 1))

;; ============================================================
;; CUSTOM SET (managed by Emacs — do not edit manually)
;; ============================================================
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(all-the-icons base16-theme cape catppuccin-theme consult corfu
		   denote doom-modeline doom-themes embark
		   embark-consult gcmh go-mode marginalia
		   nano-modeline nerd-icons-completion
		   nerd-icons-corfu nerd-icons-dired nerd-icons-grep
		   nerd-icons-ibuffer nerd-icons-ivy-rich
		   nerd-icons-xref nerdtab orderless org-roam-ui
		   rust-mode tokyo-night treemacs undo-tree vertico)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line-buffer-id ((t (:foreground "white")))))
