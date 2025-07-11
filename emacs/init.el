(setq inhibit-startup-message t)

(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode -1)

(setq visible-bell t)

(set-face-attribute 'default nil :height 144)

;; macOS-specific modifier key settings
(setq mac-option-modifier 'meta)     ;; Option = Meta (Alt-like)
(setq mac-command-modifier 'super)   ;; Command = Super
(setq mac-control-modifier 'control) ;; Control stays Control
(setq mac-function-modifier 'hyper)  ;; Function = Hyper (optional)

;; Enable both line and column numbers
(setq line-number-mode t)
;(setq column-number-mode t)

;;; Add MELPA as a package source
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(load "~/.emacs.d/hydra-config.el")

(global-display-line-numbers-mode t)

(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(setq custom-safe-themes t)
(load-theme 'doom-tokyo-night)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("8c7e832be864674c220f9a9361c851917a93f921fedb7717b1b5ece47690c098"
     "fd22a3aac273624858a4184079b7134fb4e97104d1627cb2b488821be765ff17"
     "4594d6b9753691142f02e67b8eb0fda7d12f6cc9f1299a49b819312d6addad1d"
     "0f1341c0096825b1e5d8f2ed90996025a0d013a0978677956a9e61408fcd2c77"
     "d97ac0baa0b67be4f7523795621ea5096939a47e8b46378f79e78846e0e4ad3d"
     "0c83e0b50946e39e237769ad368a08f2cd1c854ccbcd1a01d39fdce4d6f86478"
     "72d9086e9e67a3e0e0e6ba26a1068b8b196e58a13ccaeff4bfe5ee6288175432"
     "4d714a034e7747598869bef1104e96336a71c3d141fa58618e4606a27507db4c"
     "452068f2985179294c73c5964c730a10e62164deed004a8ab68a5d778a2581da"
     "7de64ff2bb2f94d7679a7e9019e23c3bf1a6a04ba54341c36e7cf2d2e56e2bcc"
     "b5fd9c7429d52190235f2383e47d340d7ff769f141cd8f9e7a4629a81abc6b19"
     "014cb63097fc7dbda3edf53eb09802237961cbb4c9e9abd705f23b86511b0a69"
     "276228257774fa4811da55346b1e34130edb068898565ca07c2d83cfb67eb70a"
     "d2ab3d4f005a9ad4fb789a8f65606c72f30ce9d281a9e42da55f7f4b9ef5bfc6"
     "c20728f5c0cb50972b50c929b004a7496d3f2e2ded387bf870f89da25793bb44"
     "daa27dcbe26a280a9425ee90dc7458d85bd540482b93e9fa94d4f43327128077"
     "76ddb2e196c6ba8f380c23d169cf2c8f561fd2013ad54b987c516d3cabc00216"
     "04aa1c3ccaee1cc2b93b246c6fbcd597f7e6832a97aaeac7e5891e6863236f9f"
     default))
 '(package-selected-packages
   '(abyss-theme airline-themes all-the-icons-completion
		 all-the-icons-dired all-the-icons-gnus
		 all-the-icons-ibuffer all-the-icons-ivy
		 all-the-icons-ivy-rich all-the-icons-nerd-fonts
		 catppuccin-theme consult dired-hide-dotfiles
		 doom-modeline doom-themes embark embark-consult
		 evil-mu4e ewal-doom-themes kanagawa-themes magit
		 marginalia material-theme memory-usage
		 minibuffer-line mu4e-alert mu4easy nerd-icons
		 nerd-icons-completion nerd-icons-corfu
		 nerd-icons-dired nerd-icons-grep nerd-icons-ibuffer
		 nerd-icons-ivy-rich nerd-icons-xref nord-theme
		 orderless org-gtd rust-mode spaceline-all-the-icons
		 symbols-outline undo-tree vdiff vertico wgrep
		 wgrep-ack wgrep-ag wgrep-deadgrep wgrep-helm wgrep-pt)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; 'mode-line', 'mode-line-inactive'
(set-face-attribute 'mode-line nil
		    :background "#362c4a"
		    :foreground "#e0af68"
		    :box "#4d3479"
		    )

(set-face-attribute 'mode-line-inactive nil
		    :background "gray15"
		    :foreground "#bb9af7"
		    :box "gray18"
		    )
       
(defun my/forward-10-lines ()
  (interactive)
  (forward-line 10))

(defun my/backward-10-lines ()
  (interactive)
  (forward-line -10))

(global-set-key (kbd "s-<down>") #'my/forward-10-lines)
(global-set-key (kbd "s-<up>") #'my/backward-10-lines)

;; Go to beginning of buffer with C-,
(global-set-key (kbd "M-<up>") 'beginning-of-buffer)

;; Go to end of buffer with C-.
(global-set-key (kbd "M-<down>") 'end-of-buffer)

(add-hook 'dired-mode-hook 'dired-hide-details-mode)
(global-set-key (kbd "C-c .") 'dired-hide-dotfiles-mode)
(global-set-key (kbd "S-<tab>") 'other-window)

;; Custom function that works on line or region
(defun my-comment-or-uncomment ()
  "Comment or uncomment current line or region."
  (interactive)
  (if (region-active-p)
      (comment-or-uncomment-region (region-beginning) (region-end))
    (comment-or-uncomment-region (line-beginning-position) (line-end-position))))

(global-set-key (kbd "C-c /") 'my-comment-or-uncomment)

(global-set-key (kbd "s-b") 'consult-buffer)

;; Install undo-tree package first
;; Default undo-tree bindings:
;; C-/     - undo
;; C-?     - redo  
;; C-x u   - visualize undo tree
(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode 1))

;; Enable Vertico.
(use-package vertico
  :custom
  ;; (vertico-scroll-margin 0) ;; Different scroll margin
  (vertico-count 20) ;; Show more candidates
  ;; (vertico-resize t) ;; Grow and shrink the Vertico minibuffer
  ;; (vertico-cycle t) ;; Enable cycling for `vertico-next/previous'
  :init
  (vertico-mode))

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

;; Emacs minibuffer configurations.
(use-package emacs
  :custom
  ;; Enable context menu. `vertico-multiform-mode' adds a menu in the minibuffer
  ;; to switch display modes.
  (context-menu-mode t)
  ;; Support opening new minibuffers from inside existing minibuffers.
  (enable-recursive-minibuffers t)
  ;; Hide commands in M-x which do not work in the current mode.  Vertico
  ;; commands are hidden in normal buffers. This setting is useful beyond
  ;; Vertico.
  (read-extended-command-predicate #'command-completion-default-include-p)
  ;; Do not allow the cursor in the minibuffer prompt
  (minibuffer-prompt-properties
   '(read-only t cursor-intangible t face minibuffer-prompt)))

(use-package marginalia
  :ensure t
  :config
  (marginalia-mode 1))

(use-package nerd-icons-completion
  :after marginalia
  :config
  (nerd-icons-completion-mode)
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

;; Optionally use the `orderless' completion style.
(use-package orderless
  :custom
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch))
  ;; (orderless-component-separator #'orderless-escapable-split-on-space)
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

;; (use-package consult
;;   :ensure t
;;   :bind (;; A recursive grep
;;          ("M-s M-g" . consult-grep)
;;          ;; Search for files names recursively
;;          ("M-s M-f" . consult-find)
;;          ;; Search through the outline (headings) of the file
;;          ("M-s M-o" . consult-outline)
;;          ;; Search the current buffer
;;          ("M-s M-l" . consult-line)
;;          ;; Switch to another buffer, or bookmarked file, or recently
;;          ;; opened file.
;;          ("M-s M-b" . consult-buffer)))

(use-package embark
  :ensure t
  :bind (("C-." . embark-act)
         :map minibuffer-local-map
         ("C-c C-c" . embark-collect)
         ("C-c C-e" . embark-export)))

(use-package embark-consult
  :ensure t)

(use-package wgrep
  :ensure t
  :bind ( :map grep-mode-map
          ("e" . wgrep-change-to-wgrep-mode)
          ("C-x C-q" . wgrep-change-to-wgrep-mode)
          ("C-c C-c" . wgrep-finish-edit)))

;; Example configuration for Consult
(use-package consult
  ;; Replace bindings. Lazily loaded by `use-package'.
  :bind (;; C-c bindings in `mode-specific-map'
         ("C-c M-x" . consult-mode-command)
         ("C-c h" . consult-history)
         ("C-c k" . consult-kmacro)
         ("C-c m" . consult-man)
         ("C-c i" . consult-info)
         ([remap Info-search] . consult-info)
         ;; C-x bindings in `ctl-x-map'
         ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ("C-x t b" . consult-buffer-other-tab)    ;; orig. switch-to-buffer-other-tab
         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ;; M-g bindings in `goto-map'
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ;; M-s bindings in `search-map'
         ("M-s d" . consult-find)                  ;; Alternative: consult-fd
         ("M-s c" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)                 ;; orig. next-matching-history-element
         ("M-r" . consult-history))                ;; orig. previous-matching-history-element

  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  ;; The :init configuration is always executed (Not lazy)
  :init

  ;; Tweak the register preview for `consult-register-load',
  ;; `consult-register-store' and the built-in commands.  This improves the
  ;; register formatting, adds thin separator lines, register sorting and hides
  ;; the window mode line.
  (advice-add #'register-preview :override #'consult-register-window)
  (setq register-preview-delay 0.5)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config

  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key "M-.")
  ;; (setq consult-preview-key '("S-<down>" "S-<up>"))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep consult-man
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   ;; :preview-key "M-."
   :preview-key '(:debounce 0.4 any))

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; "C-+"

  ;; Optionally make narrowing help available in the minibuffer.
  ;; You may want to use `embark-prefix-help-command' or which-key instead.
  ;; (keymap-set consult-narrow-map (concat consult-narrow-key " ?") #'consult-narrow-help)
)

(savehist-mode 1)
(recentf-mode 1)

(use-package nerd-icons-dired
  :ensure t
  :hook (dired-mode . nerd-icons-dired-mode))

(use-package all-the-icons
  :ensure t
  :if (display-graphic-p)
  :config
  (when (not (find-font (font-spec :name "all-the-icons")))
    (all-the-icons-install-fonts t)))

;; Opens directories or files in RHS buffer
;; (defun my/dired-open-file-in-right-window ()
;;   "In Dired, open the file at point in the right window, reusing it if it exists."
;;   (interactive)
;;   (let ((file (dired-get-file-for-visit))
;;         (dired-win (selected-window)))
;;     ;; If there's only one window, split right first
;;     (unless (window-in-direction 'right)
;;       (split-window-right))
;;     ;; Switch to the right window
;;     (select-window (window-in-direction 'right))
;;     (find-file file)
;;     ;; Return focus to dired window
;;     (select-window dired-win)))

;; (with-eval-after-load 'dired
;;   (define-key dired-mode-map (kbd "RET") #'my/dired-open-file-in-right-window))

;; (defun my/dired-smart-open ()
;;   "In Dired:
;; - If it's a directory, open it in the same buffer.
;; - If it's a file, open it in the right window, reusing it."
;;   (interactive)
;;   (let* ((item (dired-get-file-for-visit))
;;          (is-dir (file-directory-p item))
;;          (dired-win (selected-window)))
;;     (if is-dir
;;         ;; Open directories in same buffer (default behavior)
;;         (find-alternate-file item)
;;       ;; Else, open file in right window
;;       (progn
;;         ;; Split right only if needed
;;         (unless (window-in-direction 'right)
;;           (split-window-right))
;;         ;; Switch to right window and open file
;;         (select-window (window-in-direction 'right))
;;         (find-file item)
;;         ;; Optional: return to Dired
;;         (select-window dired-win)))))

;; (with-eval-after-load 'dired
;;   (put 'dired-find-alternate-file 'disabled nil) ;; Needed for `find-alternate-file`
;;   (define-key dired-mode-map (kbd "RET") #'my/dired-smart-open))

; Displays a counter showing the number of the current and total 
(setq isearch-lazy-count t)
(setq lazy-count-prefix-format "(%s/%s) ")
(setq lazy-count-suffix-format nil)

(setq search-whitespace-regexp ".*?")
(setq delete-by-moving-to-trash t)



(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))(require 'doom-modeline)
(doom-modeline-mode 1)

(setq doom-modeline-height 22)
(setq doom-modeline-bar-width 4)
(setq doom-modeline-hud nil)
(setq doom-modeline-window-width-limit 85)
(setq doom-modeline-spc-face-overrides nil)

;; How to detect the project root.
;; nil means to use `default-directory'.
;; The project management packages have some issues on detecting project root.
;; e.g. `projectile' doesn't handle symlink folders well, while `project' is unable
;; to hanle sub-projects.
;; You can specify one if you encounter the issue.
(setq doom-modeline-project-detection 'auto)

(setq doom-modeline-icon t)
(setq doom-modeline-major-mode-icon t)
(setq doom-modeline-major-mode-color-icon t)
(setq doom-modeline-buffer-state-icon t)
(setq doom-modeline-buffer-modification-icon t)
(setq doom-modeline-lsp-icon t)
(setq doom-modeline-time-icon t)
(setq doom-modeline-time-live-icon t)
(setq doom-modeline-time-analogue-clock t)
(setq doom-modeline-time-clock-size 0.7)
(setq doom-modeline-unicode-fallback nil)
(setq doom-modeline-buffer-name t)
(setq doom-modeline-highlight-modified-buffer-name t)

;; When non-nil, mode line displays column numbers zero-based.
;; See `column-number-indicator-zero-based'.
(setq doom-modeline-column-zero-based t)

(setq doom-modeline-percent-position '(-3 "%p"))
(setq doom-modeline-position-line-format '("L%l"))
;; Format used to display column numbers in the mode line.
;; See `mode-line-position-column-format'.
(setq doom-modeline-position-column-format '("C%c"))

(setq doom-modeline-position-column-line-format '("%l:%c"))

;; Whether display the minor modes in the mode-line.
(setq doom-modeline-minor-modes nil)

(setq doom-modeline-enable-word-count nil)
;; Major modes in which to display word count continuously.
;; Also applies to any derived modes. Respects `doom-modeline-enable-word-count'.
;; If it brings the sluggish issue, disable `doom-modeline-enable-word-count' or
;; remove the modes from `doom-modeline-continuous-word-count-modes'.
(setq doom-modeline-continuous-word-count-modes '(markdown-mode gfm-mode org-mode))

(setq doom-modeline-buffer-encoding t)
(setq doom-modeline-indent-info nil)
(setq doom-modeline-total-line-number nil)
(setq doom-modeline-vcs-icon t)

;; The maximum displayed length of the branch name of version control.
(setq doom-modeline-vcs-max-length 15)
;; The function to display the branch name.
(setq doom-modeline-vcs-display-function #'doom-modeline-vcs-name)

;; Alist mapping VCS states to their corresponding faces.
;; See `vc-state' for possible values of the state.
;; For states not explicitly listed, the `doom-modeline-vcs-default' face is used.
(setq doom-modeline-vcs-state-faces-alist
      '((needs-update . (doom-modeline-warning bold))
        (removed . (doom-modeline-urgent bold))
        (conflict . (doom-modeline-urgent bold))
        (unregistered . (doom-modeline-urgent bold))))

;; Whether display the icon of check segment. It respects option `doom-modeline-icon'.
(setq doom-modeline-check-icon t)

;; If non-nil, only display one number for check information if applicable.
(setq doom-modeline-check-simple-format nil)

;; Whether display the project name. Non-nil to display in the mode-line.
(setq doom-modeline-project-name t)

;; Whether display the workspace name. Non-nil to display in the mode-line.
(setq doom-modeline-workspace-name t)

;; Whether display the perspective name. Non-nil to display in the mode-line.
(setq doom-modeline-persp-name t)

;; If non nil the default perspective name is displayed in the mode-line.
(setq doom-modeline-display-default-persp-name nil)

;; If non nil the perspective name is displayed alongside a folder icon.
(setq doom-modeline-persp-icon t)

;; Whether display the `lsp' state. Non-nil to display in the mode-line.
(setq doom-modeline-lsp t)

;; Whether display the GitHub notifications. It requires `ghub' package.
(setq doom-modeline-github nil)

;; The interval of checking GitHub.
(setq doom-modeline-github-interval (* 30 60))

;; Whether display the modal state.
;; Including `evil', `overwrite', `god', `ryo' and `xah-fly-keys', etc.
(setq doom-modeline-modal t)

;; Whether display the modal state icon.
;; Including `evil', `overwrite', `god', `ryo' and `xah-fly-keys', etc.
(setq doom-modeline-modal-icon t)

;; Whether display the modern icons for modals.
(setq doom-modeline-modal-modern-icon t)

;; When non-nil, always show the register name when recording an evil macro.
(setq doom-modeline-always-show-macro-register nil)

;; Whether display the battery status. It respects `display-battery-mode'.
(setq doom-modeline-battery t)

;; ;; Show time in mode-line
;; (setq display-time-24hr-format nil)
;; (setq display-time-day-and-date nil)
;; ;; Disable load average display
;; (setq display-time-default-load-average nil)
;; (display-time-mode 1)
;; ;; Whether display the time. It respects `display-time-mode'.
;; (setq doom-modeline-time t)

;; Whether display the misc segment on all mode lines.
;; If nil, display only if the mode line is active.
(setq doom-modeline-display-misc-in-all-mode-lines t)

;; The function to handle `buffer-file-name'.
(setq doom-modeline-buffer-file-name-function #'identity)

;; The function to handle `buffer-file-truename'.
(setq doom-modeline-buffer-file-truename-function #'identity)

;; Whether display the environment version.
(setq doom-modeline-env-version t)
;; Or for individual languages
(setq doom-modeline-env-enable-python t)
(setq doom-modeline-env-enable-ruby t)
(setq doom-modeline-env-enable-perl t)
(setq doom-modeline-env-enable-go t)
(setq doom-modeline-env-enable-elixir t)
(setq doom-modeline-env-enable-rust t)
