;;     _         _             _       _____
;;    / \   _ __(_) __ _ _ __ ( )___  | ____|_ __ ___   __ _  ___ ___
;;   / _ \ | '__| |/ _` | '_ \|// __| |  _| | '_ ` _ \ / _` |/ __/ __|
;;  / ___ \| |  | | (_| | | | | \__ \ | |___| | | | | | (_| | (__\__ \
;; /_/   \_\_|  |_|\__,_|_| |_| |___/ |_____|_| |_| |_|\__,_|\___|___/

;;; Always have the server running
(use-package server
  :config
  (unless (server-running-p)
    (server-start)))

;; Use a separate file for custom behavior
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)	; Make sure it's there
  (load-file custom-file))

;; Add ./config/ folder to the `load-path'
(let ((config-path (expand-file-name "config" user-emacs-directory)))
  (add-to-list 'load-path config-path))

;; Load the configs
(require 'config-behavior)
(require 'config-haskell)
(require 'config-org)
(require 'config-appearance)
(require 'config-nixos)
