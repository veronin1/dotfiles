;;; packages.el

;; package system (melpa & gnu)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu"   . "https://elpa.gnu.org/packages/")))

;; use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;;; PACKAGES

;; magit
(use-package magit
  :commands magit-status
  :bind ("C-x g" . magit-status))

;; which-key
(use-package which-key
  :config
  (which-key-mode))

;; esup (startup profiling)
(use-package esup
  :commands (esup)
  :defer t)

;; gruber-darker theme
(use-package gruber-darker-theme
  :ensure t
  :init
  (add-hook 'emacs-startup-hook
            (lambda ()
              (load-theme 'gruber-darker t))))

;; elcord
(use-package elcord
  :commands elcord-mode
  :init
  (which-key-add-key-based-replacements "C-c d" "discord")
  :bind (("C-c d t" . elcord-mode)))
  

;; ide features for c/c++

;; company (autocompletion)
(use-package company
  :commands company-mode
  :hook (c-mode-common . company-mode)
  :config
  (setq company-idle-delay 0.2
        company-minimum-prefix-length 1))

;; flycheck (syntax checking)
(use-package flycheck
  :commands flycheck-mode
  :hook (c-mode-common . flycheck-mode))

;; lsp mode (language server support)
(use-package lsp-mode
  :commands lsp
  :hook ((c-mode c++-mode) . lsp)
  :init
  (setq lsp-prefer-flymake nil))

;; lsp-ui (enhanced ui)
(use-package lsp-ui
  :commands lsp-ui-mode
  :after lsp-mode
  :hook ((c-mode c++-mode) . lsp-ui-mode)
  :config
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-position 'at-point
        lsp-ui-sideline-enable t))

;; quickrun (run code)
(use-package quickrun
  :commands quickrun
  :bind ("C-c C-r" . quickrun))


;;; Python development

;; Python mode (built-in, no extra loading)
(use-package python
  :ensure nil
  :defer t
  :hook ((python-mode . lsp-deferred)
         (python-mode . flycheck-mode)
         (python-mode . company-mode)
         (python-mode . lsp-ui-mode)))

;; blacken (auto-format with Black)
(use-package blacken
  :defer t
  :hook (python-mode . blacken-mode)
  :config
  (setq blacken-allow-py36 t))

;; lsp-pyright (Python LSP)
(use-package lsp-pyright
  :defer t
  :hook (python-mode . lsp-deferred))

;; Rust development
(use-package rust-mode
  :mode "\\.rs\\'"
  :config
  (setq rust-format-on-save t))

(use-package lsp-mode
  :hook (rust-mode . lsp-deferred)
  :config
  (setq lsp-rust-server 'rust-analyzer
        lsp-log-io nil
        lsp-idle-delay 0.5
        lsp-enable-symbol-highlighting nil
        lsp-headerline-breadcrumb-enable nil))

(use-package lsp-ui
  :after lsp-mode
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-delay 0.2
        lsp-ui-doc-position 'at-point
        lsp-ui-sideline-enable nil
        lsp-ui-imenu-enable nil))
