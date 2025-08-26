;;; packages.el

;; package system (melpa & gnu)
(require 'package)
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
  :commands esup)

;; gruber-darker theme
(use-package gruber-darker-theme
  :ensure t
  :defer t
  :init
  (add-hook 'emacs-startup-hook
            (lambda ()
              (load-theme 'gruber-darker t))))

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

