;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;; C-h for delete backword
(global-set-key "\C-h" 'delete-backward-char)
(global-set-key (kbd "\C-x v") 'multi-vterm)
;; comment out
(global-set-key "\C-c" 'comment-dwim)
;; treemacs
(global-set-key "\C-t" 'treemacs)
;; ctrl-z = undo
(global-unset-key "\C-z")
(global-set-key "\C-z" 'undo)

;; format code with prettier
(global-set-key (kbd "M-1") #'prettier-js)

;; magit
(global-set-key (kbd "M-RET") 'magit-status)
(with-eval-after-load 'magit
  ;; Magit バッファ内で alt+Enter を押すと閉じる
  (define-key magit-mode-map (kbd "M-RET") 'magit-mode-bury-buffer))

;; made fullscreen on startup
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; accept completion from copilot and fallback to company
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)))

(setq load-theme 'gruber-darker)

(setq display-line-numbers-type t)

;; Prettier configuration
(use-package! prettier-js
  :after add-node-modules-path
  :when (executable-find "prettier")
  :commands (prettier-js)
  :config
  (setq prettier-js-args '(
    "--trailing-comma" "all"
    "--bracket-spacing" "true"
  )))

(use-package! add-node-modules-path
  :hook (web-mode . add-node-modules-path))  

(use-package! fzf
  :config
  (setq fzf/args "-x --color bw --print-query --margin=1,0 --no-hscroll"
        fzf/executable "fzf"
        fzf/git-grep-args "-i --line-number %s"
        ;; command used for `fzf-grep-*` functions
        ;; example usage for ripgrep:
        ;; fzf/grep-command "rg --no-heading -nH"
        fzf/grep-command "grep -nrH"
        ;; If nil, the fzf buffer will appear at the top of the window
        fzf/position-bottom t
        fzf/window-height 15))
(after! rustic
  (setq rustic-format-on-save t))

;;; NeoTree の設定
(use-package! neotree
  :config
  ;; NeoTree を Ctrl + t でトグル
  (global-set-key (kbd "C-t") 'neotree-toggle)

  ;; NeoTree を現在のディレクトリで開く
  (setq neo-smart-open t)

  ;; ウィンドウの分割を維持
  (setq neo-window-fixed-size nil)
  (setq neo-window-width 30)

  ;; ファイルを現在のウィンドウで開く
  (setq neo-window-position 'left)

  ;; ファイルを開いた後に NeoTree を自動的に閉じる
  (defun my-neotree-enter-hide ()
    "ファイルを開き、NeoTree ウィンドウを閉じます。"
    (interactive)
    (let ((path (neo-buffer--get-filename-current-line)))
      (if (and path (not (file-directory-p path)))
          (progn
            (neotree-enter)
            (neotree-hide))
        (neotree-enter))))

  ;; NeoTree の Enter キーに関数をバインド
  (with-eval-after-load 'neotree
    (define-key neotree-mode-map (kbd "RET") 'my-neotree-enter-hide)
    ;; マウスクリックでも同様の動作をさせる場合
    (define-key neotree-mode-map [mouse-1] 'my-neotree-enter-hide))

  ;; アイコンを使用（all-the-icons をインストールしている場合）
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))
