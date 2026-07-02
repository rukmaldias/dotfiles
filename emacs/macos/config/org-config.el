;; ============================================================
;; IMAGEMAGICK
;; ============================================================
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))
(setq org-image-actual-width '(600))

;; ============================================================
;; ORG
;; ============================================================
(use-package org
  :ensure t
  :init
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((ditaa      . t)
     (dot        . t)
     (plantuml   . t)
     (emacs-lisp . t)
     (shell      . t)
     (python     . t)))
  :hook
  (org-babel-after-execute . org-redisplay-inline-images)
  :custom
  (org-roam-directory
   (file-truename "/Users/rukmaldias/Documents/Org/org-roam"))
  (org-ditaa-jar-path      "~/Libraries/ditaa.jar")
  (org-ditaa-options       "-r -s 0.8")
  (org-confirm-babel-evaluate nil)
  (org-edit-src-content-indentation 0)
  (org-plantuml-jar-path   "~/Libraries/plantuml.jar")
  (org-startup-with-inline-images nil)
  (org-image-actual-width  '(600))
  (org-latex-pdf-process
   '("%latex -shell-escape -interaction nonstopmode -output-directory %o %f"
     "bibtex %b"
     "%latex -shell-escape -interaction nonstopmode -output-directory %o %f"
     "%latex -shell-escape -interaction nonstopmode -output-directory %o %f")))

(with-eval-after-load 'org
  ;; Keybindings
  (define-key org-mode-map (kbd "C-c C-v C-v") 'org-babel-execute-src-block)
  (define-key org-mode-map (kbd "C-c C-v C-b") 'org-babel-execute-buffer)
  (define-key org-mode-map (kbd "C-c C-x C-v") 'org-toggle-inline-images)

  ;; Images - open in macOS Preview
  (add-to-list 'org-file-apps '("\\.png\\'"  . "open %s"))
  (add-to-list 'org-file-apps '("\\.jpg\\'"  . "open %s"))
  (add-to-list 'org-file-apps '("\\.jpeg\\'" . "open %s"))
  (add-to-list 'org-file-apps '("\\.svg\\'"  . "open %s"))
  (add-to-list 'org-file-apps '("\\.gif\\'"  . "open %s"))

  ;; PDF and HTML - open in browser
  (add-to-list 'org-file-apps '("\\.pdf\\'"  . browse-url))
  (add-to-list 'org-file-apps '("\\.html\\'" . browse-url)))

;; ============================================================
;; ORG BABEL PYTHON
;; ============================================================
(setq org-confirm-babel-evaluate nil)
(setq org-babel-python-command
      "/Users/rukmaldias/.venvs/diagrams/bin/python3")

(defun my/org-babel-diagrams-display ()
  (when (string= (org-element-property
                  :language (org-element-at-point)) "python")
    (org-display-inline-images)))

(add-hook 'org-babel-after-execute-hook
          'my/org-babel-diagrams-display)

;; ============================================================
;; ORG ROAM FILE SERVER
;; ============================================================
(defun my/start-org-file-server ()
  "Serve org-roam directory on port 8099."
  (unless (get-process "org-file-server")
    (start-process "org-file-server" nil
                   "python3" "-m" "http.server" "8099"
                   "--directory"
                   "/Users/rukmaldias/Scientists/Org/org-roam")))

(add-hook 'org-roam-ui-mode-hook #'my/start-org-file-server)

;; ============================================================
;; AGENDA FILES
;; ============================================================
;; Every file listed here is scanned by org-agenda, dashboard's
;; Agenda widget, and org-refile targets below.
;; inbox.org / work.org / diary.org don't need to exist yet --
;; org-capture will create them on first use.
(setq org-agenda-files
      '("~/Documents/Org/organizer/projects.org"
        "~/Documents/Org/organizer/inbox.org"
        "~/Documents/Org/organizer/work.org"
	"~/Documents/Org/organizer/learning.org"))

;; ============================================================
;; TODO KEYWORDS (GTD workflow, per cachestocaches.com/Bernt Hansen)
;; ============================================================
;; NOTE: this supersedes the simpler org-todo-keywords that used
;; to live in projects-config.el -- that line has been removed
;; from there to avoid the two definitions fighting each other.
;;
;; TODO      - task/project not yet started
;; NEXT      - the immediate next actionable step in a project
;; WAITING   - blocked on someone else (prompts for a note via the @ flag)
;; INACTIVE  - parked idea/project, revisit later
;; MEETING   - heading used for meeting notes
;; DONE      - complete
;; CANCELLED - abandoned (prompts for a note via the @ flag)
(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "WAITING(w@)" "INACTIVE(i)" "MEETING(m)"
                  "|" "DONE(d)" "CANCELLED(c@)")))

(setq org-todo-keyword-faces
      '(("TODO"      . "#e06c75")
        ("NEXT"      . "#61afef")
        ("WAITING"   . "#e5c07b")
        ("INACTIVE"  . "#5c6370")
        ("MEETING"   . "#c678dd")
        ("DONE"      . "#98c379")
        ("CANCELLED" . "#5c6370")))

;; ============================================================
;; AGENDA VIEW
;; ============================================================
(setq org-agenda-span 'day
      org-agenda-start-with-log-mode t
      org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done t)

;; ============================================================
;; AUTOMATIC CLOCKING
;; ============================================================
;; C-c C-x C-i to clock in, C-c C-x C-o to clock out (built-in
;; org bindings, no need to rebind). Capture templates below
;; also auto clock-in/resume so switching tasks via capture
;; doesn't lose time tracking on what you were doing.
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)
(setq org-clock-in-resume t)
(setq org-clock-into-drawer t)

;; Column view: Task | Total clocked time | Last timestamp
;; Activate with C-c C-x C-c on a top-level heading, q to exit.
(setq org-columns-default-format
      "%50ITEM(Task) %10CLOCKSUM %16TIMESTAMP_IA")

;; ============================================================
;; CAPTURE
;; ============================================================
;; C-c c to capture from anywhere (bound in keybindings-config.el
;; or below if not already present).
(setq org-default-notes-file "~/Documents/Org/organizer/inbox.org")

(setq org-capture-templates
      '(("t" "TODO" entry (file org-default-notes-file)
         "* TODO %?\n%u\n%a\n" :clock-in t :clock-resume t)
        ("m" "Meeting" entry (file org-default-notes-file)
         "* MEETING with %? :MEETING:\n%t" :clock-in t :clock-resume t)
        ("d" "Diary" entry (file+datetree "~/Documents/Org/organizer/diary.org")
         "* %?\n%U\n" :clock-in t :clock-resume t)
        ("i" "Idea" entry (file org-default-notes-file)
         "* %? :IDEA:\n%t" :clock-in t :clock-resume t)
        ("n" "Next Task" entry (file+headline org-default-notes-file "Tasks")
         "** NEXT %?\nDEADLINE: %t")))

(global-set-key (kbd "C-c c") #'org-capture)

;; ============================================================
;; REFILE
;; ============================================================
;; C-c C-w on any heading to move it -- completes against every
;; heading (up to 9 levels deep) in the current buffer AND every
;; file in org-agenda-files.
(setq org-refile-targets
      '((nil :maxlevel . 9)
        (org-agenda-files :maxlevel . 9)))
(setq org-refile-use-outline-path 'file
      org-outline-path-complete-in-steps nil)

(provide 'org-config)
