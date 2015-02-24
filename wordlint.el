;;; wordlint.el --- minor mode for Wordlint prose redundancy proofing tool
;;; Author: GB Gardner
;;; Commentary:
;;; 
;;; This package provides an Emacs interface to the Wordlint program
;;; written in Haskell (https://github.com/gbgar/Wordlint). As such,
;;; the `wordlint` program must be installed to your system and
;;; located in Emacs' path. Installation instructions may be found on
;;; the github page.
;;;
;;; The minor mode `wordlint-mode' sets the file-local
;;; `compile-command' variable to use the `wordlint' program.  The
;;; `wordlint' executable path and a set of user-set default matching
;;; and filtering options may be specified using
;;; `wordlint-executable-path' and `wordlint-custom-args'
;;; respectively.
;;;
;;; Code:
(defgroup wordlint nil
  "Customization group for Wordlint redundancy checker interface."
  :group 'external)

(defcustom wordlint-executable-path "~/.cabal/bin/wordlint"
  "Executable path for external `wordlint' program."
  :group 'wordlint)

(defcustom wordlint-custom-args "~/.cabal/bin/wordlint"
  "Additonal arguments passed to `wordlint' when [re]compile is run.

The `--matchlength' flag; up to three linter options (`-w', `-l',
and/or `-p') or the `--all' output flag; and any combination of filter
functions are acceptable arguments.  See `wordlint --help', the
wordlint man page, or the wordlint README for a full list of available
options.

If this variable is changed while `wordlint-mode' is active, toggle
the mode off and on for the setting to take effect."
  :group 'wordlint)

(defvar wordlint-mode-old-compiler-settings nil
  "Saved compiler settings for restoration after wordlint-mode is disabled.")

(defun wordlint-mode-enable ()
  "Enable wordlint-mode minor mode."

      (progn
	(setq wordlint-mode-old-compiler-settings compile-command)
	(set (make-local-variable 'compile-command)
	     (concat wordlint-executable-path
		     " -s error -f "
		     (buffer-file-name)
		     " "
		     wordlint-custom-args))))

(defun wordlint-mode-disable ()
  "Disable wordlint-mode minor mode."
  (set (make-local-variable 'compile-command)
       (eval wordlint-mode-old-compiler-settings)))

;;;###autoload
(define-minor-mode wordlint-mode
  "Minor mode for 'compiling' prose with Wordlint redundancy checker.

The only feature of this minor mode is to provide an appropriate
setting for the `compile-command' variable.  Two variables allow for
rudimentary customization: `wordlint-executable-path' and
`wordlint-custom-args'. The former locates the `wordlint' command
while the latter provides user-specified matching and filtering
options to the `wordlint' program (see `wordlint --help', the wordlint
man page, or the wordlint README)."
  :init-value nil :ligher "" :global nil
  (cond
   (wordlint-mode
    (wordlint-mode-enable))
   ((not wordlint-mode)
    (wordlint-mode-disable))))

(provide 'wordlint)
;;; wordlint.el ends here
