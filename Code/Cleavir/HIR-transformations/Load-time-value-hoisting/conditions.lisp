(cl:in-package #:cleavir-load-time-value-hoisting)

(define-condition circular-dependencies-in-creation-form
    (error acclimation:condition)
  ((%object :initarg :object :reader object)
   (%creation-form :initarg :creation-form :reader creation-form)))

(define-condition circular-dependencies-in-load-time-value-form
    (error acclimation:condition)
  ((%form :initarg :form :reader form)))
