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
   ;; org mode
 '(org-hide-emphasis-markers t)
 '(org-src-fontify-natively t)
 '(org-support-shift-select 'always)
 
  ;; visual
 '(tool-bar-mode nil)
 '(global-visual-line-mode t)
 '(global-hl-line-mode t)
 '(display-line-numbers t)
 '(window-divider-mode t)
 '(inhibit-startup-screen t) ;; hide startup 
 '(frame-title-format "%b - Emacs") ;; Notepad++ title is more complicated than that but I couldn't be bothered
   ;; tab bar
 '(tab-bar-mode t)
 '(tab-bar-new-tab-to 'rightmost)
 '(tab-bar-format '(tab-bar-format-history tab-bar-format-tabs tab-bar-separator))
 
 ;; modeline
 '(mode-line-position-line-format nil)
 '(mode-line-percent-position nil)
 '(mode-line-compact 'long)
)

;; improved notepad++ functionality that CUA doesn't have
;;

;; newline - insert a new line and do a relative indent
(defun better-newline ()
	(interactive)
	(newline)
	(indent-relative-maybe)
)
(global-set-key (kbd "RET") 'better-newline)

;; backspace - actually remove character (Emacs by default doesn't actually delete the character, if it's a tab it untabifies it)
(global-set-key (kbd "<backspace>") 'backward-delete-char)

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
(defun duplicate-line ()
	(interactive)
	(let ((initial-position (point)))
		(kill-whole-line)
		(yank)
		(yank)
		(goto-char initial-position)
	)
)
(global-set-key (kbd "C-d") 'duplicate-line)

;; ctrl + f - searching

;; ctrl + a - select whole buffer (needs some work to do)
(global-set-key (kbd "C-a") 'mark-whole-buffer)
