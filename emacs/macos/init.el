;; ============================================================
;; LOAD PATH
;; ============================================================
(add-to-list 'load-path "~/.emacs.d/config/")

; ============================================================
;; BASIC UI & STARTUP
;; ============================================================
(setq inhibit-startup-message t)
(setq ring-bell-function 'ignore)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(set-fringe-mode 10)
(add-hook 'window-setup-hook 'toggle-frame-maximized t)
(set-face-attribute 'default nil :height 144)
(setq gc-cons-threshold (* 100 1024 1024))
(setq read-process-output-max (* 1024 1024))

;; ============================================================
;; MAC MODIFIER KEYS
;; ============================================================
(setq mac-option-modifier 'meta)
(setq mac-command-modifier 'super)
(setq mac-control-modifier 'control)
(setq mac-function-modifier 'hyper)

;; ============================================================
;; PACKAGE MANAGEMENT
;; ============================================================
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/") t)
(package-initialize)

;; ============================================================
;; LOAD CONFIG FILES
;; ============================================================
(load "~/.emacs.d/config/ui-config.el")
(load "~/.emacs.d/config/completion-config.el")
(load "~/.emacs.d/config/search-config.el")  
(load "~/.emacs.d/config/org-config.el")
(load "~/.emacs.d/config/languages-config.el")
(load "~/.emacs.d/config/lsp-config.el")
(load "~/.emacs.d/config/treemacs-config.el")
(load "~/.emacs.d/config/projects-config.el")
(load "~/.emacs.d/config/ai-config.el")
(load "~/.emacs.d/config/editing-config.el")
(load "~/.emacs.d/config/dashboard-config.el")
(load "~/.emacs.d/config/keybindings-config.el")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
