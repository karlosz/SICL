(cl:in-package #:sicl-boot-phase-0)

(defun import-standard-common-lisp-functions (environment)
  (do-symbols (symbol (find-package '#:common-lisp))
    (when (fboundp symbol)
      (unless (special-operator-p symbol)
        (let ((definition (fdefinition symbol)))
          (when (functionp definition)
            (setf (sicl-genv:fdefinition symbol environment) definition)))))
    (when (fboundp `(setf ,symbol))
      (setf (sicl-genv:fdefinition `(setf ,symbol) environment)
            (fdefinition `(setf ,symbol))))))

(defun define-standard-common-lisp-variables (environment)
  (setf (sicl-genv:special-variable '*macroexpand-hook* environment t)
        *macroexpand-hook*))

(defun define-standard-common-lisp-special-operators (environment)
  (do-symbols (symbol (find-package '#:common-lisp))
    (when (special-operator-p symbol)
      (setf (sicl-genv:special-operator symbol environment) t))))

(defun define-cleavir-primops (environment)
  (do-symbols (symbol (find-package '#:cleavir-primop))
    (setf (sicl-genv:special-operator symbol environment) t)))

(defun import-from-cleavir-code-utilities (environment)
  (setf (sicl-genv:fdefinition 'cleavir-code-utilities:parse-macro environment)
        #'cleavir-code-utilities:parse-macro))

(defun import-macro-expanders (environment)
  (loop for name in '(sicl-data-and-control-flow:defun-expander
                      sicl-conditionals:or-expander
                      sicl-conditionals:and-expander
                      sicl-conditionals:cond-expander
                      sicl-conditionals:case-expander
                      sicl-conditionals:ecase-expander
                      sicl-conditionals:ccase-expander
                      sicl-conditionals:typecase-expander
                      sicl-conditionals:etypecase-expander
                      sicl-conditionals:ctypecase-expander
                      sicl-standard-environment-macros:defconstant-expander
                      sicl-standard-environment-macros:defvar-expander
                      sicl-standard-environment-macros:defparameter-expander
                      sicl-standard-environment-macros:deftype-expander
                      sicl-standard-environment-macros:define-compiler-macro-expander
                      sicl-evaluation-and-compilation:declaim-expander
                      sicl-loop:expand-body)
        do (setf (sicl-genv:fdefinition name environment)
                 (fdefinition name))))

(defun import-sicl-envrionment-functions (environment)
  (loop for name in '((setf sicl-genv:fdefinition)
                      (setf sicl-genv:function-type)
                      (setf sicl-genv:function-lambda-list)
                      sicl-genv:get-setf-expansion)
        do (setf (sicl-genv:fdefinition name environment)
                 (fdefinition name))))

(defun import-from-trucler (environment)
  (loop for name in '(trucler:global-environment
                      trucler:symbol-macro-expansion
                      trucler:macro-function)
        do (setf (sicl-genv:fdefinition name environment)
                 (fdefinition name))))

(defun import-from-host (environment)
  (host-load "Data-and-control-flow/defun-support.lisp")
  (host-load "Environment/macro-support.lisp")
  (import-standard-common-lisp-functions environment)
  (define-standard-common-lisp-variables environment)
  (define-standard-common-lisp-special-operators environment)
  (define-cleavir-primops environment)
  (import-from-cleavir-code-utilities environment)
  (import-macro-expanders environment)
  (import-sicl-envrionment-functions environment)
  (import-from-trucler environment))
