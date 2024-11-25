(load-theme 'gruvbox t)
(add-hook 'org-mode-hook
	  'turn-on-visual-line-mode)
;; (add-hook 'org-mode-hook
;; 	  'org-indent-mode)
;; (add-hook 'org-mode-hook
;; 	  'org-modern-mode)
(add-hook  'markdown-mode-hook
	   (lambda()
	     (turn-on-visual-line-mode)
	     (outline-hide-body)))
(add-hook 'markdown-mode-hook
	  'spell-fu-mode)
(add-hook 'prog-mode-hook
	  'display-line-numbers-mode)
(add-hook 'prog-mode-hook
	  (lambda ()
	    (rainbow-delimiters-mode)
	    (company-mode)))


(add-hook 'TeX-mode-hook
  (lambda ()
    (setq TeX-command-extra-options "-shell-escape")
    (display-line-numbers-mode)
    (company-mode 1)
  )
  )

(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
;; (add-hook 'TeX-mode-hook
;; 	  'display-line-numbers-mode)
;; (add-hook 'TeX-mode-hook
;; 	  '(company-mode 1))
(emms-all)
(setq emms-player-list '(emms-player-mpv)
      emms-info-functions '(emms-info-native)
      emms-source-file-default-directory '"/mnt/WDRed/Music")
(global-set-key (kbd "C-c C-d C-e") 'emms-myplaylist)

(defun emms-myplaylist ()
(interactive)
(emms-play-playlist "~/.emacs.d/playlist")
(tab-new)
(emms))

(vertico-mode nil)
(marginalia-mode nil)
(which-key-mode 1)
(yas-global-mode 1)
(openwith-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("4fe4a418bb02cda8df3fe5dad1c1d177fd517c1ea20871a2e8fce329edd3952d" "e0c83f70bf0fcac1e47c7cafc8defc258be5e90b2b9b7668741c150aa7be1326" "553a6676b68142a652c034cfe2179a2271240bc1e33611c2de3a7207ce7608ca" "7b8f5bbdc7c316ee62f271acf6bcd0e0b8a272fdffe908f8c920b0ba34871d98" "2ff9ac386eac4dffd77a33e93b0c8236bb376c5a5df62e36d4bfa821d56e4e20" "b1a691bb67bd8bd85b76998caf2386c9a7b2ac98a116534071364ed6489b695d" default))
 '(elfeed-feeds
   '("https://protesilaos.com/master.xml" "https://www.opennet.ru/opennews/opennews_all.rss" "https://www.linux.org.ru/section-rss.jsp?section=1"))
 '(org-agenda-files '("~/FreeBSD_Sync/plans.org")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fixed-pitch-serif ((t (:background "gray22" :family "Iosevka Nerd Font"))))
 '(link ((t (:foreground "medium turquoise" :underline t))))
 '(markdown-code-face ((t (:height 0.9 :family "Iosevka"))))
 '(org-block ((t (:extend t :background "#32302f" :height 0.8 :family "Iosevka"))))
 '(org-block-begin-line ((t (:extend t :background "#3c3836" :height 0.8))))
 '(org-block-end-line ((t (:extend t :background "#3c3836" :height 0.8))))
 '(org-level-1 ((t (:extend nil :foreground "goldenrod"))))
 '(org-link ((t (:foreground "light salmon" :underline t :height 0.9 :family "Iosevka"))))
 '(org-quote ((t (:height 0.8 :family "Liberation Mono"))))
 '(outline-1 ((t (:extend t :foreground "#d3869b" :weight bold :family "FantasqueSansMono Nerd Font Mono"))))
 '(variable-pitch ((t (:family "Ubuntu"))))
 '(variable-pitch-text ((t (:inherit variable-pitch :family "Ubuntu")))))

(setq org-ellipsis "…")
(set-face-attribute 'org-ellipsis nil :inherit 'default :box nil)


(customize-set-variable
 'display-buffer-alist
 '(("\\*elfeed-entry\\*"
    (display-buffer-below-selected display-buffer-at-bottom)
    (window-height . even))
   ("\\*mastodon-home\\*"
    (display-buffer-below-selected display-buffer-at-bottom)
    (window-height . even))
    ("\\*new toot\\*"
    (display-buffer-below-selected display-buffer-at-bottom)
    (window-height . even))
   ))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))    

