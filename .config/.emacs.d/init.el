;;; init.el --- Emacs configuration for C/C++ development

;; Package setup
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Theme: Gruber Darker
(use-package gruber-darker-theme
  :config
  (load-theme 'gruber-darker t))

;; Font: Iosevka
(defun rc/get-default-font ()
  (when (eq system-type 'gnu/linux)
    "Iosevka-20"))

(set-frame-font (rc/get-default-font) t t)

;; word wrap
(defun rc/enable-word-wrap ()
  (interactive)
  (toggle-word-wrap 1))

(add-hook 'markdown-mode-hook 'rc/enable-word-wrap)

;; Enable relative line numbers with absolute current line number
(setq display-line-numbers-type 'relative) ; use relative numbers

;; Turn on relative line numbers globally
(global-display-line-numbers-mode t)

;; LSP configuration for C/C++
(use-package lsp-mode
  :hook ((c-mode c++-mode) . lsp)
  :commands lsp
  :config
  (setq lsp-prefer-flymake nil))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-sideline-enable t
        lsp-ui-sideline-show-hover t
        lsp-ui-sideline-show-code-actions t))

(use-package flycheck
  :init (global-flycheck-mode))

;; Completion
(use-package company
  :hook (after-init . global-company-mode)
  :config
  (setq company-minimum-prefix-length 1
        company-idle-delay 0.0))

;; LSP + Company integration
(with-eval-after-load 'lsp-mode
  (setq lsp-completion-provider :capf))

;; Snippets
(use-package yasnippet
  :init (yas-global-mode 1))

;; Clang-format on save
(use-package clang-format
  :commands (clang-format-region clang-format-buffer))

(defun my-c-format-before-save ()
  (when (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
    (clang-format-buffer)))

(add-hook 'before-save-hook #'my-c-format-before-save)

;; Tree-sitter for better syntax parsing
(use-package tree-sitter
  :hook ((c-mode c++-mode) . tree-sitter-mode))

(use-package tree-sitter-langs)

;; Git integration
(use-package magit
  :commands magit-status
  :bind ("C-x g" . magit-status))

;; Helpful key discovery
(use-package which-key
  :init (which-key-mode))

;; Theme setting via Custom
(custom-set-variables
 '(custom-enabled-themes '(gruber-darker)))

(custom-set-faces)
