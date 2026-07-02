;; ============================================================
;; AGENDA CUSTOM COMMANDS
;; ------------------------------------------------------------
;; Both views are defined here in ONE org-agenda-custom-commands
;; so they don't collide. This file must load AFTER org-config.el,
;; and org-config.el must NOT also set org-agenda-custom-commands
;; (that definition has been removed from there).
;;
;;   C-c a d  -> Daily Agenda   (compact: Today / Next / Waiting)
;;   C-c a a  -> My Agenda      (full block view, 4 sections)
;;
;; Both are views, not files -- they read live from every file in
;; org-agenda-files (inbox / learning / projects / work).
;; ============================================================
(setq org-agenda-custom-commands
      '(;; ==========================================================
        ;; "d"  Daily Agenda  -- quick compact glance
        ;; ==========================================================
        ("d" "Daily Agenda"
         ((agenda "" ((org-agenda-span 'day)
                      (org-agenda-overriding-header "Today")))
          (todo "NEXT" ((org-agenda-overriding-header "Next Actions")))
          (todo "WAITING" ((org-agenda-overriding-header "Waiting On")))))

        ;; ==========================================================
        ;; "a"  My Agenda  -- full block view (cachestocaches layout)
        ;; ==========================================================
        ("A" "My Agenda"
         (;; --- 1. Today's Schedule -----------------------------
          (agenda ""
                  ((org-agenda-overriding-header "Today's Schedule:")
                   (org-agenda-span 'day)
                   (org-agenda-start-day "+0d")
                   (org-agenda-todo-ignore-deadlines nil)))

          ;; --- 2. Next Tasks -----------------------------------
          (todo "NEXT"
                ((org-agenda-overriding-header "Next Tasks:")
                 (org-agenda-prefix-format "  %-12:c ")))

          ;; --- 3. Week at a Glance -----------------------------
          (agenda ""
                  ((org-agenda-overriding-header "Week at a Glance:")
                   (org-agenda-span 'week)
                   (org-agenda-start-on-weekday 0)   ;; 0 = Sunday
                   (org-agenda-start-day "-0d")
                   (org-agenda-time-grid nil)))

          ;; --- 4. Remaining Project Tasks (projects.org only) --
          (alltodo ""
                   ((org-agenda-overriding-header "Remaining Project Tasks:")
                    (org-agenda-files
                     '("~/Documents/Org/organizer/projects.org"))
                    (org-agenda-prefix-format "  %-12:c "))))

         ;; view-wide settings applied to all four blocks
         ((org-agenda-block-separator ?━)
          (org-agenda-compact-blocks nil)))))

;; ------------------------------------------------------------
;; Agenda color coding: deadlines red, scheduled blue
;; ------------------------------------------------------------
(with-eval-after-load 'org
  (set-face-attribute 'org-warning nil
                      :foreground "#e06c75" :weight 'bold)   ;; overdue / due-now deadline
  (set-face-attribute 'org-upcoming-deadline nil
                      :foreground "#e06c75")                  ;; approaching deadline
  (set-face-attribute 'org-scheduled nil
                      :foreground "#61afef")                  ;; scheduled
  (set-face-attribute 'org-scheduled-today nil
                      :foreground "#61afef" :weight 'bold))   ;; scheduled for today

(global-set-key (kbd "C-c a") #'org-agenda)

(provide 'agenda-config)
