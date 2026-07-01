;; ============================================================
;; LINE & COLUMN NUMBERS, PRINT MARGIN
;; ============================================================
(global-display-line-numbers-mode 1)
(setq line-number-mode t)
(setq column-number-mode t)

(setq-default fill-column 80)
(setq display-fill-column-indicator-character ?\│)

(defvar my-margin-modes
  '(emacs-lisp-mode
    python-mode
    c-mode c++-mode
    java-mode
    rust-mode
    sh-mode
    go-mode)
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
;; Theme
;; ============================================================
(use-package leuven-theme
  :ensure t
  :config
  (load-theme 'leuven t))

;; ============================================================
;; MODELINE
;; ============================================================
;; (use-package doom-modeline
;;   :ensure t
;;   :init (doom-modeline-mode 1)
;;   :custom-face
;;   (mode-line-active ((t (:background "#22242b"))))
;;   (mode-line-inactive ((t (:background "#dfe2f1")))))

;; ============================================================
;; Icons
;; ============================================================
(use-package nerd-icons
  :ensure t
  :config
  (when (not (find-font (font-spec :name "Symbols Nerd Font Mono")))
    (nerd-icons-install-fonts t)))

;;Dired icons
(use-package nerd-icons-dired
  :ensure t
  :after nerd-icons
  :hook (dired-mode . nerd-icons-dired-mode))

;; ============================================================
;; SAVEHIST
;; ============================================================
(use-package savehist
  :init
  (savehist-mode))

;; ============================================================
;; HISTORY & RECENT FILES
;; ============================================================
(savehist-mode 1)
(recentf-mode 1)

(setq recentf-exclude
      '("\\.emacs\\.d/\\.cache/treemacs-persist\\'"
        "\\.emacs\\.d/bookmarks\\'"
        "/\\.git/.*\\'"
        "\\.gz\\'"))

;; ============================================================
;; MINIBUFFER
;; ============================================================
(setq enable-recursive-minibuffers t)
(minibuffer-depth-indicate-mode 1)

;; ============================================================
;; GARBAGE COLLECTOR MAGIC-HACK
;; ============================================================
(use-package gcmh
  :ensure t
  :config
  (gcmh-mode 1))

(provide 'ui)
