Wordlint.el provides an Emacs interface to the Wordlint program
written in Haskell
([https://github.com/gbgar/Wordlint](https://github.com/gbgar/Wordlint)).

The minor mode `wordlint-mode` sets the file-local `compile-command`
variable to use the `wordlint` program.  The `wordlint` executable
path and a set of user-set default matching and filtering options may
be specified using `wordlint-executable-path` and
`wordlint-custom-args` respectively.

#Installation

#Prerequisites

This minor mode relies on an external tool, `wordlint`, which must be
installed to your system and locatable by Emacs. Installation
instructions may be found on the
[github page](https://github.com/gbgar/Wordlint).

##Manual

Retrieve wordlint.el and copy it to your emacs plugin directory, i.e.
~/.emacs.d/plugs/, which is available in your load-path.

Add

	(require 'wordlint)

to your Emacs init file, and activate wordlint-mode by hand

	M-x wordlint-mode RET

or add hooks to your preferred prose-oriented major modes.


##Set wordlint-custom-args (Optional)

If you wish, use Emacs' built-in customization facilities or
add something like the following to your Emacs init file:

	(setq wordlint-cusom-args "-w 50 --nopunct")

#Use

Activate `wordlint-mode`, and when ready, run the command

	M-x compile RET

runs `wordlint` with user-specified options on the current file,
returning matching words as errors in the compilation-mode buffer. If
Emacs fails to find the executable, ensure the variable
`wordlint-executable-path` is properly set.


