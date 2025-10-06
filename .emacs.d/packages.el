;;; packages.el

;;; package system bootstrap
(setq package-archives
      '(("gnu"   . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))

(require 'package)
(setq package-enable-at-startup nil)

(unless (bound-and-true-p esup-child-process)
  (unless (file-exists-p (expand-file-name "archives/melpa" package-user-dir))
    (package-refresh-contents)))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t
      use-package-always-defer t
      use-package-verbose nil)

;;; theme (load immediately, avoid recursive load)
(use-package gruber-darker-theme
  :ensure t
  :init (load-theme 'gruber-darker t))

;;; general utility
(use-package esup
  :commands esup
  :init (setq esup-depth 0
              esup-user-init-file (expand-file-name "init.el" user-emacs-directory)))

(use-package magit
  :commands magit-status
  :bind ("C-x g" . magit-status))

(use-package which-key
  :defer 0
  :config (which-key-mode 1))

(use-package elcord
  :commands elcord-mode
  :init (which-key-add-key-based-replacements "C-c d" "discord")
  :bind (("C-c d t" . elcord-mode)))

;;; note-taking (org-roam)
(use-package org-roam
  :commands (org-roam-node-find org-roam-node-insert org-roam-capture org-roam-buffer-toggle)
  :init (setq org-roam-v2-ack t)
  :custom (org-roam-directory "~/org-roam")
  :config (org-roam-db-autosync-mode))

;;; core programming & ide
(use-package company
  :hook (prog-mode . company-mode)
  :config (setq company-idle-delay 0.2
                company-minimum-prefix-length 1))

(use-package flycheck
  :hook (prog-mode . flycheck-mode))

(use-package lsp-mode
  :commands lsp
  :hook (prog-mode . lsp-deferred)
  :init (setq lsp-prefer-flymake nil)
  :config (setq lsp-log-io nil
                lsp-idle-delay 0.5
                lsp-enable-symbol-highlighting nil
                lsp-headerline-breadcrumb-enable nil))

(use-package lsp-ui
  :commands lsp-ui-mode
  :hook (lsp-mode . lsp-ui-mode)
  :config (setq lsp-ui-doc-enable t
                lsp-ui-doc-position 'at-point
                lsp-ui-sideline-enable t))

(use-package quickrun
  :commands quickrun
  :bind ("C-c C-r" . quickrun))

;;; language-specific
;; python
(use-package blacken
  :hook (python-mode . blacken-mode))

(use-package lsp-pyright
  :after lsp-mode
  :commands lsp-pyright-enable)

;; rust
(use-package rust-mode
  :mode "\\.rs\\'"
  :config (setq rust-format-on-save t)
  :hook (rust-mode . (lambda () (setq lsp-rust-server 'rust-analyzer))))
