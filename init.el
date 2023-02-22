;; Emacs++
;; https://github.com/Losiel/EmacsPlusPlus

;; customization
(custom-set-variables
 ;; usability 
 '(cua-mode t)
 '(cua-keep-region-after-copy t)
 '(electric-indent-mode nil)
 '(context-menu-mode t)
 '(ido-mode 'both)
 '(ido-everywhere t)
 '(make-backup-files nil) ;; not make backup files
 '(use-short-answers t) ;; replaces 'yes-or-no' to 'y-or-n'
 '(recentf-mode t)
 '(backward-delete-char-untabify-method nil) ;; make Emacs not convert tabs to spaces when pressing backspace
   ;; org mode
 '(org-hide-emphasis-markers t)
 '(org-src-fontify-natively t)
 '(org-support-shift-select 'always)
   ;; desktop save mode
 '(desktop-save-mode t)
 '(desktop-path ("~/.emacs.d/" "~"))
 '(desktop-save t)
 
  ;; visual
 '(tool-bar-mode nil)
 '(global-visual-line-mode t)
 '(global-hl-line-mode t)
 '(display-line-numbers t)
 '(window-divider-mode t)
 '(inhibit-startup-screen t) ;; hide startup 
 '(frame-title-format "%b - Emacs") ;; Notepad++ title is more complicated than that but I couldn't be bothered
 '(cursor-type 'bar)
   ;; tab bar
 '(tab-bar-mode t)
 '(tab-bar-new-tab-to 'rightmost)
 '(tab-bar-format '(tab-bar-format-history tab-bar-format-tabs tab-bar-separator))
 
 ;; modeline
 '(mode-line-position-line-format nil)
 '(mode-line-percent-position nil)
 '(mode-line-compact 'long)
)

;; notepad++ like theme
(custom-set-faces
 '(font-lock-comment-face ((t (:foreground "forest green"))))
 '(font-lock-keyword-face ((t (:foreground "Blue1"))))
 '(font-lock-function-name-face ((t (:foreground "Purple"))))
 '(hl-line-face ((t (:background "lavender"))))
 '(region-face ((t (:background "gray"))))
 '(cursor-face ((t (:background "light slate blue"))))
 '(line-numbers-face ((t (:background "gainsboro" :inherit (shadow default)))))
)

;; We need melpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; improved notepad++ functionality that CUA doesn't have
;;

;; newline - insert a new line and do a relative indent
(defun better-newline ()
	(interactive)
	(newline)
	(indent-relative-maybe)
)
(global-set-key (kbd "RET") 'better-newline)

;; tab - actually insert tab
(global-set-key "\t" 'tab-to-tab-stop)

;; alt + f4 - close emacs
(global-set-key (kbd "M-<f4>") 'save-buffers-kill-terminal)

;; ctrl + y - redo
(global-set-key (kbd "C-y") 'undo-redo)

;; ctrl + w - close tab
(global-set-key (kbd "C-w") 'tab-close)

;; ctrl + s - saving
(global-set-key (kbd "C-s") 'save-buffer)

;; ctrl + d - duplicate line
(defun duplicate-line (initial-position)
	(interactive "*d")
	(kill-whole-line)
	(yank)
	(yank)
	(goto-char initial-position)
)
(global-set-key (kbd "C-d") 'duplicate-line)

;; ctrl + f - searching

;; ctrl + a - select whole buffer (needs some work to do)
(global-set-key (kbd "C-a") 'mark-whole-buffer)
