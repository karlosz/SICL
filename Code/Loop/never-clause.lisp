;;;; Copyright (c) 2014
;;;;
;;;;     Robert Strandh (robert.strandh@gmail.com)
;;;;
;;;; all rights reserved. 
;;;;
;;;; Permission is hereby granted to use this software for any 
;;;; purpose, including using, modifying, and redistributing it.
;;;;
;;;; The software is provided "as-is" with no warranty.  The user of
;;;; this software assumes any responsibility of the consequences. 

(cl:in-package #:sicl-loop)

(defclass never-clause (termination-test-clause form-mixin) ())

(defmethod accumulation-variables ((clause never-clause))
  `((nil always/never t)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Parsers.

(define-parser never-clause-parser
  (consecutive (lambda (never form)
		 (declare (ignore never))
		 (make-instance 'never-clause
		   :form form))
	       (keyword-parser 'never)
	       'anything-parser))

(add-clause-parser 'never-clause-parser)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Compute the body-form

(defmethod body-form ((clause never-clause) end-tag)
  (declare (ignore end-tag))
  `(when ,(form clause)
     (return-from ,*loop-name* nil)))
