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
  (define-key org-mode-map (kbd "C-c C-v C-v") 'org-babel-execute-src-block)
  (define-key org-mode-map (kbd "C-c C-v C-b") 'org-babel-execute-buffer)
  (define-key org-mode-map (kbd "C-c C-x C-v") 'org-toggle-inline-images)
  (add-to-list 'org-file-apps '("\\.png\\"  . "open %s"))
  (add-to-list 'org-file-apps '("\\.jpg\\"  . "open %s"))
  (add-to-list 'org-file-apps '("\\.svg\\"  . "open %s"))
  (add-to-list 'org-file-apps '("\\.html\\'" . browse-url))
  (add-to-list 'org-file-apps '("\\.pdf\\'"  . browse-url)))

(setq org-confirm-babel-evaluate nil)
(setq org-babel-python-command
      "/Users/rukmaldias/.venvs/diagrams/bin/python3")

(defun my/org-babel-diagrams-display ()
  (when (string= (org-element-property
                  :language (org-element-at-point)) "python")
    (org-display-inline-images)))

(add-hook 'org-babel-after-execute-hook
          'my/org-babel-diagrams-display)

(defun my/start-org-file-server ()
  (unless (get-process "org-file-server")
    (start-process "org-file-server" nil
                   "python3" "-m" "http.server" "8099"
                   "--directory"
                   "/Users/rukmaldias/Documents/Org/org-roam")))

(add-hook 'org-roam-ui-mode-hook #'my/start-org-file-server)

(provide 'org-config)
