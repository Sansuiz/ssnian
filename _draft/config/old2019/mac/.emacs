;;hy's emacs on mac

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))

(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))

(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
                           ("melpa" . "http://elpa.emacs-china.org/melpa/")))
(package-initialize) ;; You might already have this line


(add-to-list 'load-path "~/.emacs.d/lisp")
(let ((default-directory  "~/.emacs.d/lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

;; general config
;;关闭出错提示声
(setq visible-bell t)
;; 显示行号
(setq column-number-mode t)
(setq line-number-mode t)
;; 显示时间
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(display-time)
;; 关闭启动画面
(setq inhibit-startup-message t)
;;设置大的kill ring
(setq kill-ring-max 150)
;; 去掉工具栏
(tool-bar-mode 0)

(setq make-backup-files 0);不产生备份文件
(global-font-lock-mode t);语法高亮
(auto-image-file-mode t);打开图片显示功能
(fset 'yes-or-no-p 'y-or-n-p);以 y/n代表 yes/no
(column-number-mode t);显示列号
(show-paren-mode t);显示括号匹配
(scroll-bar-mode 0);去掉滚动条
(mouse-avoidance-mode 'animate);光标靠近鼠标指针时，让鼠标指针自动让开
(setq mouse-yank-at-point t);支持中键粘贴
(transient-mark-mode t);允许临时设置标记
(setq x-select-enable-clipboard t);支持emacs和外部程序的粘贴
(setq frame-title-format '("" buffer-file-name "@emacs" ));在标题栏显示buffer名称
;;unicode
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;;auctex
(load "auctex.el" nil t t)

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

;;color-theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")     
(load-theme 'solarized t)
(set-frame-parameter nil 'background-mode 'dark)
(enable-theme 'solarized)

;;ess R
(require 'ess-site)
(setq-default inferior-R-program-name "/usr/local/bin/R")
;;markdown
(autoload 'markdown-mode "markdown-mode"
	"Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))


;;fonts
(set-language-environment 'UTF-8)
(set-locale-environment "UTF-8")
(set-default-font "Monaco 16")
(if (and (fboundp 'daemonp) (daemonp))
	  (add-hook 'after-make-frame-functions
				(lambda (frame)
				  (with-selected-frame frame
					(set-fontset-font "fontset-default"
									  'unicode "黑体 16"))))
(set-fontset-font "fontset-default" 'unicode "黑体 16"))


;;
(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil))) 


;;yasnippet
;(add-to-list 'load-path
;              "~/.emacs.d/lisp/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)


;;scheme
(setq scheme-program-name  "/usr/local/bin/mit-scheme")

;;python
(require 'elpy)
(elpy-enable)

(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)       

;; 自动完成：company
(require 'company)
(add-hook 'after-init-hook 'global-company-mode); 全局开启
(setq company-show-numbers t); 显示序号
(setq company-idle-delay 0.2); 菜单延迟
(setq company-minimum-prefix-length 1); 开始补全字数

;; 语法检查：flycheck
(add-hook 'after-init-hook #'global-flycheck-mode);全局开启
; 关闭flymake，使用flycheck
(when (require 'flycheck nil t)
  (setq elpy-modules(delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

