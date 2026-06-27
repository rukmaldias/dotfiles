;; ============================================================
;; WHICH-KEY
;; ============================================================
(use-package which-key
  :ensure t
  :config (which-key-mode))

;; ============================================================
;; VERTICO
;; ============================================================
(add-to-list 'display-buffer-alist
             '("\\*vertico-buffer\\*"
               (display-buffer-in-side-window)
               (side . right)
               (window-width . 0.33)))

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

  ;; ONLY consult-buffer in buffer mode - remove all others
  (setq vertico-multiform-commands
        '((consult-buffer      buffer)
          (my/consult-buffer-vertical buffer)))

  (vertico-multiform-mode 1)
  (advice-add #'vertico-multiform--toggle :around
              (lambda (fn &rest args)
                (unless (> (minibuffer-depth) 1)
                  (apply fn args)))))

;; ============================================================
;; VERTICO KEYMAP
;; ============================================================
(with-eval-after-load 'vertico
  (define-key vertico-map (kbd "C-<tab>") #'other-window))

;; ============================================================
;; MARGINALIA
;; ============================================================
(use-package marginalia
  :ensure t
  :config
  (marginalia-mode 1))

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

;; Prevents bookmark corruptions
(setq bookmark-save-flag 1)
(setq bookmark-default-file "~/.emacs.d/bookmarks")

;; ============================================================
;; COMPANY
;; ============================================================
(use-package company
  :ensure t
  :hook (after-init . global-company-mode)
  :bind (:map company-active-map
         ("TAB"       . company-complete-common-or-cycle)
         ("<backtab>" . company-select-previous))
  :config
  (setq company-idle-delay 0.2
        company-minimum-prefix-length 1
        company-tooltip-align-annotations t))

(global-set-key (kbd "C-c c") 'company-complete)

;; Start treemacs on boot
;;(treemacs-start-on-boot)

(with-eval-after-load 'treemacs
  (define-key treemacs-mode-map [mouse-1] #'treemacs-single-click-expand-action))

(provide 'completion)
