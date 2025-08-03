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
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)

;; jump N lines up/down with C-c j
(defun jump-n-lines (n)
  "Jump N lines. Negative to go up, positive to jump down."
  (interactive "nEnter number of lines to jump: ")
  (forward-line n))

(global-set-key (kbd "C-c j") 'jump-n-lines)


;; LSP configuration for C/C++
(use-package lsp-mode
  :hook ((c-mode c++-mode python-mode) . lsp)
  :commands lsp
  :config
  (setq lsp-prefer-flymake nil
        lsp-idle-delay 0.1                             ;; ⬅ reduces CPU load on typing
        lsp-completion-provider :capf
        lsp-completion-show-detail t                   ;; ⬅ extra info in completions
        lsp-completion-show-kind t
        lsp-headerline-breadcrumb-enable nil           ;; ⬅ disables top bar symbols
        lsp-enable-symbol-highlighting nil))           ;; ⬅ stops cursor highlight lag

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-sideline-enable nil                     ;; ⬅ kill noisy sideline popups
        lsp-ui-sideline-show-hover nil
        lsp-ui-sideline-show-code-actions nil
        lsp-ui-doc-enable nil))                        ;; ⬅ no floating doc popup lag

(use-package flycheck
  :init (global-flycheck-mode))

;; Completion
(use-package company
  :hook (after-init . global-company-mode)
  :config
  (setq company-minimum-prefix-length 2                ;; ⬅ require 2 chars before popup
        company-idle-delay 0.1                         ;; ⬅ wait a bit before popping up
        company-show-quick-access t))

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
 '(custom-enabled-themes '(gruber-darker))
 '(package-selected-packages
   '(blacken clang-format dap-mode flycheck gruber-darker-theme helm-lsp
	     helm-xref lsp-pyright lsp-ui magit projectile
	     tree-sitter-langs)))

(custom-set-faces)

;; Python development setup

(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp))))

(use-package blacken
  :hook (python-mode . blacken-mode)
  :config
  (setq blacken-line-length 88))

(setq python-shell-interpreter "python3")
(add-hook 'python-mode-hook 'company-mode)
