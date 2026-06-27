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
(global-set-key (kbd "S-<tab>") #'consult-buffer)
(global-set-key (kbd "C-,") 'previous-buffer)
(global-set-key (kbd "C-.") 'next-buffer)

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

(provide 'keybindings)
