;;; init.el

;; disable toolbar GUI initialization
(add-to-list 'default-frame-alist '(tool-bar-lines . 0))
(add-to-list 'default-frame-alist '(menu-bar-lines . 0))
(add-to-list 'default-frame-alist '(vertical-scroll-bars . nil))

(setq tool-bar-mode nil)

;; delay gc
(setq gc-cons-threshold 100000000) ;; 100mb
(add-hook 'emacs-startup-hook
          (lambda () (setq gc-cons-threshold 800000)))

(setq initial-buffer-choice "~")

;; load packages
(add-hook 'emacs-startup-hook
          (lambda ()
            (load (expand-file-name "packages.el" user-emacs-directory))))

;; ui
(column-number-mode 1)

;; highlight matching parenthesis
(show-paren-mode 1)
(setq show-paren-delay 0)

;; line numbers
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)

;; default font size (20pt)
(add-hook 'emacs-startup-hook
          (lambda ()
            (when (display-graphic-p)
              (set-face-attribute 'default nil :family "Fira Code" :height 200))))


;; Disable splash screen and startup message
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

;; auto clang-format on save for c/c++ buffers
(defun my/clang-format-buffer ()
  "Format the current buffer with clang-format if it's C/C++."
  (when (derived-mode-p 'c-mode 'c++-mode)
    (clang-format-buffer)))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("ee447a6dd4b28851f7cd66f881396ef7cc2169a55d5292fd727f4d3ce783a1ec"
     default)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
