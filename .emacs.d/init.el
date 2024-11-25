(setq warning-minimum-level :emergency)
;; Elpaca init
(defvar elpaca-installer-version 0.8)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil
                              :files (:defaults (:exclude "extensions"))
                              :build (:not elpaca--activate-package)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-repos-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (condition-case-unless-debug err
        (if-let ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                 ((zerop (call-process "git" nil buffer t "clone"
                                       (plist-get order :repo) repo)))
                 ((zerop (call-process "git" nil buffer t "checkout"
                                       (or (plist-get order :ref) "--"))))
                 (emacs (concat invocation-directory invocation-name))
                 ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                       "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                 ((require 'elpaca))
                 ((elpaca-generate-autoloads "elpaca" repo)))
            (kill-buffer buffer)
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (load "./elpaca-autoloads")))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

(setq default-input-method "russian-computer") 
(setq user-full-name "Romaha"
      user-mail-address "romwhite@gmail.com")
(setq calendar-week-start-day 1)
(setq-default cursor-type 'bar)

(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.saves/"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 3
   kept-old-versions 2
   version-control t)       ; use versioned backups

;; Install use-package support
(elpaca elpaca-use-package
;; Enable :elpaca use-package keyword.
  (elpaca-use-package-mode)
;; Assume :elpaca t unless otherwise specified.
  (setq elpaca-use-package-by-default t))

;; Block until current queue processed.
(elpaca-wait)

;; My packkages use-package section
(use-package gcmh
  :ensure t
  :diminish gcmh-mode
  :custom
  (gcmh-mode 1)
  (gcmh-idle-delay 10)
  (gcmh-high-cons-threshold (* 32 1024 1024))
  (gc-cons-percentage 0.8))
(use-package gruvbox-theme)
(use-package transpose-frame)
(use-package jinx
  :ensure t
  :defer t
  :hook ((text-mode-hook prog-mode-hook) . jinx-mode)
  :config (setq jinx-languages "ru_RU en_EN")
  :bind
  (("C-x C-;" . jinx-languages)
   ("C-=" . jinx-correct)))

(use-package auto-sudoedit)
(use-package fb2-reader
  :custom
  ;; This mode renders book with fixed width, adjust to your preferences.
  (fb2-reader-page-width 80)
  (fb2-reader-image-max-width 400)
  (fb2-reader-image-max-height 400))
(use-package markdown-mode)
(use-package haskell-mode)
(use-package consult)
(use-package vertico)
(use-package marginalia)
(use-package pdf-tools)
(use-package olivetti)
(use-package seq)
(use-package emms
  :config
  (setq emms-browser-covers #'emms-browser-cache-thumbnail-async)
  (setq emms-browser-thumbnail-small-size 64)
  (setq emms-browser-thumbnail-medium-size 128)
  (setq emms-source-file-default-directory '"/mnt/WDRed/Music"))
(use-package elpher)
(use-package which-key)
(use-package company)
(use-package all-the-icons)
(use-package all-the-icons-dired)
(use-package company-fuzzy)
(use-package yasnippet)
(use-package ef-themes)
(use-package treemacs
  :ensure t
  :defer t
  :config (progn
	    (treemacs-follow-mode t)
	    (treemacs-filewatch-mode t)
	    (treemacs-fringe-indicator-mode 'only-when-focused))
  )
(elpaca (tp :repo "/home/romaha/Downloads/tp"))
(elpaca (transient :repo "/home/romaha/Downloads/transient/"))
(use-package mastodon
  :ensure t
  :config
 (setq mastodon-instance-url "https://mk.phreedom.club"
       mastodon-active-user "romwhite")
 :bind
 ("C-c m" . mastodon))

(use-package mixed-pitch)
(use-package rainbow-delimiters)
;;(use-package lua-mode)
;;(use-package magit)
;; Configure Elfeed
  (use-package elfeed
    :ensure t
    :config
    (setq elfeed-db-directory (expand-file-name "elfeed" user-emacs-directory)
          elfeed-show-entry-switch 'display-buffer)
    :bind
    ("C-x w" . elfeed ))


(use-package org
  :demand t
  :config
  (setq org-confirm-babel-evaluate nil)
  (setq org-M-RET-may-split-line nil)
  (setq org-fontify-quote-and-verse-blocks t)
  (setq org-capture-templates
	'(("t" "ТODO Work" entry (file+headline "~/FreeBSD_Sync/plans.org" "Текучка")
           "* TODO %t %?\n ")
          ("j" "Journal" entry (file+datetree "~/FreeBSD_Sync/journal.org")
           "* %?\nEntered on %U\n ")))
  :hook (org-mode . org-modern-mode)
  (org-mode . org-indent-mode)
  )

(use-package org-modern
  :ensure t
  :defer t
  :custom
  (org-modern-table nil)
  (org-modern-star 'replace)
  :hook ((org-mode-hook . org-modern-mode)
	 (org-agenda-finalize-hook . org-modern-agenda)))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(partial-completion orderless flex))
  (completion-category-overrides '((file (styles  partial-completion)))))

(use-package marginalia
  :ensure t
  :config
  (marginalia-mode))

(use-package embark
  :ensure t

  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

  :init

  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)

  ;; Show the Embark target at point via Eldoc. You may adjust the
  ;; Eldoc strategy, if you want to see the documentation from
  ;; multiple providers. Beware that using this can be a little
  ;; jarring since the message shown in the minibuffer can be more
  ;; than one line, causing the modeline to move up and down:

  ;; (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target)
  ;; (setq eldoc-documentation-strategy #'eldoc-documentation-compose-eagerly)

  :config

  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

;; Consult users will also want the embark-consult package.
(use-package embark-consult
  :ensure t ; only need to install it, embark loads it after consult if found
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

;; (use-package nano-emacs
;;   :elpaca (
;; 	 nano-emacs
;;  	 :host github
;;  	 :repo "rougier/nano-emacs"
;;  	 :branch "master"
;;    ))
;;Turns off elpaca-use-package-mode current declartion
;;Note this will cause the declaration to be interpreted immediately (not deferred).
;;Useful for configuring built-in emacs features.
(use-package emacs :elpaca nil :config (setq ring-bell-function #'ignore))


;; Customization Section
;;(set-frame-font '"Liberation Mono  18")
;;(set-frame-font '"Fantasque Sans Mono 18")
;;(set-face-attribute 'default nil :height 180)

(defun my/set-font ()
  (when (find-font (font-spec :family "FantasqueSansM Nerd Font"))
    (set-face-attribute 'default nil
        :family "FantasqueSansM Nerd Font"
        :weight 'normal
	:height 140)))
(my/set-font)

(add-hook 'after-make-frame-functions
          (defun my/set-new-frame-font (frame)
            (with-selected-frame frame
              (my/set-font))))
(server-start)
(tool-bar-mode -1)
(menu-bar-mode -1)
(global-visual-line-mode 1)
(pixel-scroll-precision-mode 1)
(set-mouse-color "white")
(winner-mode 1)
(setq sentence-end-double-space nil)
;;(setq telega-server-libs-prefix "/usr/local")
;; File with varaibles that must set after packages loaded
(setq user-emacs-directory '"/home/romaha/.emacs.d")
(setq custom-file (expand-file-name "customs.el" user-emacs-directory))
(add-hook 'elpaca-after-init-hook (lambda () (load custom-file 'noerror)))

;; Spell-checking section
;; (add-hook 'spell-fu-mode-hook
;;   (lambda ()
;;     (spell-fu-dictionary-add (spell-fu-get-ispell-dictionary "en_US"))
;;     (spell-fu-dictionary-add (spell-fu-get-ispell-dictionary "ru-yo"))
;;     ))
;; (setq default-input-method "russian-computer")
;; (setq ispell-program-name "/usr/bin/aspell")
;; (setq ispell-dictionary "ru-yo")

;; Set history
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(global-set-key "\C-x\ \C-r" 'consult-recent-file)

;; Key-customization functions
(global-set-key "\C-x\ g" 'end-of-buffer)
(global-set-key (kbd "M-<tab>") #'other-window)
(global-set-key (kbd "C-h") #'delete-backward-char)
;;(global-set-key (kbd "C-=") #'ispell-word)
(global-set-key (kbd "C-c \]") #'org-capture)
(global-set-key (kbd "C-c d l") #'display-line-numbers-mode)
(global-set-key (kbd "C-c s") #'jinx-mode)
(global-set-key (kbd "C->") #'winner-redo)
(global-set-key (kbd "C-<") #'winner-undo)
(global-set-key (kbd "s-=") #'text-scale-increase)
(global-set-key (kbd "s--") #'text-scale-decrease)
(global-set-key (kbd "C-c o") #'olivetti-mode)
(global-set-key (kbd "C-x b") #'consult-buffer)


(defun new-line-bellow ()
  "Add new blank line bellow point"
  (interactive)
  (save-excursion
    (end-of-line)
    (newline-and-indent)))

(defun new-line-above ()
  "Add new blank line above point"
  (interactive)
  (save-excursion
    (beginning-of-line)
    (newline-and-indent)))

;; My experiments
(defun init-file-open ()
  (interactive)
  (find-file '"~/.emacs.d/init.el"))
;; (display-buffer "journal.org" '(display-buffer-same-window)))

(set-register ?z '(file . "~/FreeBSD_Sync/tink.org"))

(global-set-key (kbd "s-o") #'init-file-open)
(global-set-key (kbd "M-]") #'new-line-bellow)
(global-set-key (kbd "M-[") #'new-line-above)
(global-set-key (kbd "C-M-]") #'forward-paragraph)
(global-set-key (kbd "C-M-[") #'backward-paragraph)

(global-set-key (kbd "C-w") #'backward-kill-word)
(global-set-key (kbd "C-c C-w") #'kill-region)

;; Custom variables sets by Emacs
(custom-set-variables

 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("2ff9ac386eac4dffd77a33e93b0c8236bb376c5a5df62e36d4bfa821d56e4e20" "b1a691bb67bd8bd85b76998caf2386c9a7b2ac98a116534071364ed6489b695d" default)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; (customize-set-variable
;;  'display-buffer-base-action
;;  '((display-buffer-below-selected display-buffer-at-bottom)
;;     (inhibit-same-window . t)
;;     (window-height . fit-window-to-buffer) (reusable-frames . 0))
;;  )


