;; Emacs++
;; https://github.com/Losiel/EmacsPlusPlus

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
 '(package-archives
   (("gnu" . "https://elpa.gnu.org/packages/")
    ("nongnu" . "https://elpa.nongnu.org/nongnu/")
    ("melpa" . "https://melpa.org/packages/"))
  )
 
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
(package-initialize)

;; notepad++ like theme
(custom-set-faces
 '(font-lock-comment-face ((t (:foreground "forest green"))))
 '(font-lock-keyword-face ((t (:foreground "Blue1"))))
 '(font-lock-function-name-face ((t (:foreground "Purple"))))
 '(hl-line ((t (:background "lavender"))))
 '(region ((t (:background "gray"))))
 '(cursor ((t (:background "light slate blue"))))
 '(line-number ((t (:background "gainsboro" :inherit (shadow default)))))
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

;; indentation
(defun select-line (initial-point)
	;; https://emacs.stackexchange.com/a/22166
	(interactive "d")
	(beginning-of-line)
	(setq this-command-keys-shift-translated t)
	(call-interactively 'end-of-line)
)
(defun select-lines-in-region (beg end)
"Selects every line in the region. For example: If the region starts at the middle of the line and ends at the start of another line, this function will make the region start at the beginning of that line to the end of that line"
	(interactive "r")
	(let (
		(should-exchange-point-and-mark (= (point) beg))
		(line-beginning (progn (goto-char beg) (move-beginning-of-line nil)))
		)
		(goto-char end)
		(move-end-of-line nil)
		(set-mark line-beginning)
		(when should-exchange-point-and-mark (exchange-point-and-mark))
	)
)
(defun better-tab (beg end)
	(interactive "*r")
	(if (not (use-region-p))
		;; just put a tab if the region is not active
		(tab-to-tab-stop)

		;; indent region
		(select-lines-in-region beg end)
		(indent-rigidly-right-to-tab-stop (region-beginning) (region-end)) ;; todo: make so you can easily switch from tabs to spaces
		(setq deactivate-mark nil)
	)
)

(defun decrease-line-indent (beg end)
	(interactive "*r")
	(if (use-region-p)
		(select-lines-in-region beg end)
		(select-line (point))
	)

	(indent-rigidly-left-to-tab-stop (region-beginning) (region-end)) ;; todo: make so you can easily switch from tabs to spaces
	(setq deactivate-mark nil)
)

(global-set-key "\t" 'better-tab)
(global-set-key (kbd "<backtab>") 'decrease-line-indent)

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
