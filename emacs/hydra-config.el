(use-package hydra
  :ensure t)

(defhydra hydra-main (global-map "C-z")
  "Main menu"
  ("g" text-scale-increase "in")
  ("l" text-scale-decrease "out")
  ("s" save-buffer "Save")
  ("c" save-buffers-kill-terminal "Quit Emacs" :exit t)
  ("q" nil "quit"))
