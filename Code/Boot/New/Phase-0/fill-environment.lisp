(cl:in-package #:sicl-boot-phase-0)

(defun fill-environment (client environment)
  (declare (ignore client))
  (import-from-host environment)
  (define-defmacro environment)
  (define-backquote-macros environment)
  (define-default-setf-expander environment)
  (define-setf-macro-function environment)
  ;; Load a file containing a definition of the macro LAMBDA.  This
  ;; macro is particularly simple, so it doesn't really matter how
  ;; it is expanded.  This is fortunate, because at the time this
  ;; file is loaded, the definition of DEFMACRO is still one we
  ;; created "manually" and which uses the host compiler to compile
  ;; the macro function in the null lexical environment.  We define
  ;; the macro LAMBDA before we redefine DEFMACRO as a target macro
  ;; because PARSE-MACRO returns a LAMBDA form, so we need this
  ;; macro in order to redefine DEFMACRO.
  (load-file "Evaluation-and-compilation/lambda.lisp" environment)
  ;; Load a file containing the definition of the macro
  ;; MULTIPLE-VALUE-BIND.  We need it early because it is used in the
  ;; expansion of SETF, which we also need early for reasons explained
  ;; below.
  (load-file "Environment/multiple-value-bind.lisp" environment))
