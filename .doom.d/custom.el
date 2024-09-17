(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(gruber-darker))
 '(custom-safe-themes
   '("e27c9668d7eddf75373fa6b07475ae2d6892185f07ebed037eedf783318761d7" "ba4ab079778624e2eadbdc5d9345e6ada531dc3febeb24d257e6d31d5ed02577" default))
 '(magit-todos-insert-after '(bottom) nil nil "Changed by setter of obsolete option `magit-todos-insert-at'")
 '(package-selected-packages
   '(neotree all-the-icons multi-vterm battle-haxe obsidian auto-complete-clang-async tree-sitter-langs tree-sitter company-irony irony company-go react-snippets magit web-mode tide leaf-keywords hydra gruber-darker-theme el-get blackout))
 '(zoom-mode t)
 '(zoom-size '(0.618 . 0.618)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; generic emacs settings
(progn
  (setq display-time-interval 1)
  (setq display-time-string-forms
	'((format "%s:%s:%s" 24-hours minutes seconds)))
  (setq display-time-day-and-date t)
  (display-time-mode t)
  (nyan-mode)
  (beacon-mode)
  (multi-vterm))
(put 'customize-themes 'disabled nil)

;; flash when trying to save files
(add-hook 'after-save-hook
	  (lambda ()
            (let ((orig-fg (face-background 'mode-line)))
	      (set-face-background 'mode-line "dark green")
	      (run-with-idle-timer 0.4 nil
				   (lambda (fg) (set-face-background 'mode-line fg))
				   orig-fg))))


;; C-x C-t fix into M-n|p
(progn
  (defun dusdanig-aprox-begin-of-line ()
    "Check whether I am on the begin or end of a line"
    (< (- (point) (line-beginning-position))
       (- (line-end-position) (point))))
  (defun dusdanig-move-line-up ()
    "Move up the current line."
    (interactive)
    (transpose-lines 1)
    (forward-line -2)
    (indent-according-to-mode)
    (beginning-of-line))
  (defun dusdanig-move-line-down ()
    "Move down the current line."
    (interactive)
    (forward-line 1)
    (transpose-lines 1)
    (forward-line -1)
    (indent-according-to-mode)
    (end-of-line))
  (global-set-key (kbd "M-n") 'dusdanig-move-line-down)
  (global-set-key (kbd "M-p") 'dusdanig-move-line-up))
  
;; slime
(progn
  (setq inferior-lisp-program "sbcl"))

;; dired
(progn
  (setq dired-dwim-target t)
  (setq dired-recursive-copies 'always)
  (setq dired-isearch-filenames t))

;; recentf
;;(progn
  ;;(setq recentf-max-saved-items 2000)
  ;;(setq recentf-auto-cleanup 'never)
  ;;(setq recentf-exclude '("/recentf" "COMMIT_EDITMSG" "/.?TAGS" "^/sudo:" "/\\.emacs\\.d/games/*-scores" "/\\.emacs\\.d/\\.cask/"))
  ;;(setq recentf-auto-save-timer (run-with-idle-timer 30 t 'recentf-save-list))
  ;;(recentf-mode 1)
  ;;(global-set-key (kbd "\C-x p") 'helm-recentf))

;;;; fzf
(progn
  (global-set-key (kbd "\C-x f") 'fzf))
