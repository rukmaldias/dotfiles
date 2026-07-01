;; ============================================================
;; DASHBOARD
;; ============================================================
(use-package dashboard
  :ensure t
  :init
  ;; Banner (swap path for your own image, centered both ways)
  (setq dashboard-startup-banner "~/.emacs.d/images/logo.png")
  (setq dashboard-center-content t)
  (setq dashboard-vertically-center-content t)

  ;; Icons — reuse nerd-icons since it's already in ui-config.el
  (setq dashboard-icon-type 'nerd-icons)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)

  ;; Sections: name, count, and single-key shortcut
  (setq dashboard-items '((recents   . 5)
			  (agenda    . 5)
			  (projects  . 5)
			  (bookmarks . 5)))

  (setq dashboard-item-shortcuts '((recents   . "r")
				   (agenda    . "a")
				   (projects  . "p")
				   (bookmarks . "m")))

  ;; Section headings (defaults are close, but pin them explicitly)
  (setq dashboard-item-names '(("Recent Files:" . "Recent Files:")
			       ("Agenda for today:" . "Agenda:")
			       ("Projects:" . "Projects:")
			       ("Bookmarks:" . "Bookmarks:")))

  ;; Empty-state text — matches your mockup exactly
  (setq dashboard-no-items-text "-- No items --")

  ;; Projects section needs to know which backend
  (setq dashboard-projects-backend 'projectile)

  ;; Agenda: show top items, not a full week view
  (setq dashboard-week-agenda nil)
  (setq dashboard-agenda-release-buffers t)
  (setq dashboard-agenda-sort-strategy '(time-up))

  ;; Footer — mimic the "Doom loaded N packages..." line
  (setq dashboard-set-footer t)

  :config
  (defun my/dashboard-footer-message ()
    (list (format "Emacs loaded %d packages in %.3fs"
		  (length package-activated-list)
		  (float-time (time-subtract after-init-time before-init-time)))))

  (with-eval-after-load 'dashboard
    (set-face-attribute 'dashboard-no-items-face nil
			:underline nil))

  (setq dashboard-startupify-list '(dashboard-insert-banner
				    dashboard-insert-newline
				    dashboard-insert-banner-title
				    dashboard-insert-newline
				    dashboard-insert-navigator
				    dashboard-insert-newline
				    dashboard-insert-items
				    dashboard-insert-newline
				    dashboard-insert-footer))

  ;; Recompute footer after everything's actually loaded, then refresh
  (add-hook 'emacs-startup-hook
	    (lambda ()
	      (setq dashboard-footer-messages (my/dashboard-footer-message))
	      (when (get-buffer dashboard-buffer-name)
		(dashboard-refresh-buffer))))

  (dashboard-setup-startup-hook))
