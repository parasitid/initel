(add-to-list 'load-path "/usr/share/emacs/site-lisp/org")
(add-to-list 'load-path "~/tools/org-mode/contrib/lisp" t)
(add-to-list 'load-path "~/tools/org-reveal" t)
;;(add-to-list 'load-path "~/tools/org-jira" t)

(setq jiralib-url "https://jira.numer.gy")

(require 'ox-reveal)
;;(require 'org-jira)

;;; turn on syntax highlighting
(global-font-lock-mode 1)

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/")
             )

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") )

(package-initialize)

(defvar my-packages '(starter-kit
                      starter-kit-lisp
                      starter-kit-bindings
                      starter-kit-eshell
                      clojure-mode
                      clojure-test-mode
                      magit
                      groovy-mode
                      expand-region
                      multiple-cursors
                      ace-jump-mode
                      scala-mode2
                      sbt-mode
                      cider
                      python-mode
                      ruby-mode
                      web-mode
                      blank-mode
                      multi-term
                      coffee-mode))

(dolist (p my-packages)
  (unless (package-installed-p p)
   (package-refresh-contents) (package-install p)))


(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

(global-set-key (kbd "C-=") 'er/expand-region)

(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(add-hook 'sbt-mode-hook '(lambda ()
  ;; compilation-skip-threshold tells the compilation minor-mode
  ;; which type of compiler output can be skipped. 1 = skip info
  ;; 2 = skip info and warnings.
  (setq compilation-skip-threshold 1)

  ;; Bind C-a to 'comint-bol when in sbt-mode. This will move the
  ;; cursor to just after prompt.
  (local-set-key (kbd "C-a") 'comint-bol)

  ;; Bind M-RET to 'comint-accumulate. This will allow you to add
  ;; more than one line to scala console prompt before sending it
  ;; for interpretation. It will keep your command history cleaner.
  (local-set-key (kbd "M-RET") 'comint-accumulate) 
))
(add-hook 'scala-mode-hook '(lambda ()
   ;; sbt-find-definitions is a command that tries to find (with grep)
   ;; the definition of the thing at point.
   (local-set-key (kbd "M-.") 'sbt-find-definitions)

   ;; use sbt-run-previous-command to re-compile your code after changes
   (local-set-key (kbd "C-x '") 'sbt-run-previous-command)
   ))
(global-set-key (kbd "M-'") 'next-error)

(setq nrepl-buffer-name-show-port t)
(setq cider-repl-print-length 100) 
;(set cider-interactive-eval-result-prefix ";; => ")
(setq nrepl-buffer-name-separator "-")
(setq multi-term-program "/bin/zsh")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Prevent the cursor from blinking
(blink-cursor-mode 0)
;; Don't use messages that you don't read
(setq initial-scratch-message "")
(setq inhibit-startup-message t)
;; Don't let Emacs hurt your ears
(setq visible-bell t)


;; Who use the bar to scroll?
(scroll-bar-mode 0)
(tool-bar-mode 0)
(menu-bar-mode 0)


;; Set the color of the fringe
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background "black" :foreground "grey"))))
 '(fringe ((t (:background "white"))))
 '(magit-item-highlight ((t nil))))



 
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values (quote ((encoding . utf-8) (whitespace-line-column . 80) (lexical-binding . t)))))

(autoload 'magit-status "magit" nil t)

;; The following lines are always needed.  Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode)) ; not needed since Emacs 22.2
(add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on


; Must have org-mode loaded before we can configure org-babel
(require 'org-install)

; Some initial langauges we want org-babel to support
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (sh . t)
   (python . t)
   (R . t)
   (ruby . t)
   (ditaa . t)
   (dot . t)
   (octave . t)
   (sqlite . t)
   (perl . t)
   ))

; Add short cut keys for the org-agenda
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)

(setq org-reveal-root "file:///home/yann/Tools/slides-template")
