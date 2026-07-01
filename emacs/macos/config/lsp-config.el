;; ============================================================
;; JAVA
;; ============================================================
(use-package lsp-java
  :ensure t
  :after lsp-mode
  :hook (java-mode . (lambda () (require 'lsp-java) (lsp)))
  :config
  ;; JDT Language Server path
  (setq lsp-java-server-install-dir
        (expand-file-name "~/.emacs.d/jdtls/"))

  ;; Use config_mac for macOS Intel
  ;; Use config_mac_arm for Apple Silicon (M1/M2/M3)
  (setq lsp-java-jdt-ls-config
        (expand-file-name "~/.emacs.d/jdtls/config_mac/"))

  ;; Java runtime
  (setq lsp-java-java-path
        "/usr/local/opt/openjdk@21/bin/java")

  ;; Project settings
  (setq lsp-java-import-gradle-enabled t)
  (setq lsp-java-import-maven-enabled  t)

  ;; Format settings
  (setq lsp-java-format-on-type-enabled t)

  ;; Code lens
  (setq lsp-java-code-lens-enabled              t)
  (setq lsp-java-references-code-lens-enabled   t)

  ;; Completion import order - use vector of strings
  (setq lsp-java-completion-import-order
        ["java" "javax" "org" "com"])

  ;; JVM args for better performance
  (setq lsp-java-vmargs
        '("-XX:+UseParallelGC"
          "-XX:GCTimeRatio=4"
          "-XX:AdaptiveSizePolicyWeight=90"
          "-Dsun.zip.disableMemoryMapping=true"
          "-Xmx2G"
          "-Xms100m")))

(use-package lsp-mode
  :ensure t
  :commands lsp
  :hook ((rust-mode       . lsp)
         (go-mode         . lsp)
         (c-mode          . lsp)
         (c++-mode        . lsp)
         (kotlin-mode     . lsp)
         (java-mode       . lsp)
         (dockerfile-mode . lsp)
         (lsp-mode        . lsp-enable-which-key-integration))
  :init
  (setq lsp-keymap-prefix "C-c l"))

(provide 'lsp)
