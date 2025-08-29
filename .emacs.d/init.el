;;; init.el

;; load packages
(load (expand-file-name "packages.el" user-emacs-directory))

;; ui
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(column-number-mode 1)

;; highlight matching parenthesis
(show-paren-mode 1)
(setq show-paren-delay 0)

;; line numbers
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)

;; default font size (20pt)
(when (and (fboundp 'set-face-attribute) (display-graphic-p))
  (set-face-attribute 'default nil :family "Fira Code" :height 200))

;; disable splash screen and startup message
(setq inhibit-startup-screen t
      initial-scratch-message nil)

;; disable the annoying bell
(setq ring-bell-function 'ignore)

;; smooth scrolling
(setq scroll-step 1
      scroll-conservatively 10000)

;; disable backup files and .#lock files
(setq auto-save-default t
      make-backup-files nil
      create-lockfiles nil)

;; spaces instead of tabs
(setq-default indent-tabs-mode nil
              tab-width 4)

;; auto clang-format on save for c/c++ buffersx
(defun my/clang-format-buffer ()
  "Format the current buffer with clang-format if it's C/C++."
  (when (derived-mode-p 'c-mode 'c++-mode)
    (clang-format-buffer)))

(add-hook 'before-save-hook #'my/clang-format-buffer)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
