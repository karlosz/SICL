(cl:in-package #:asdf-user)

(defsystem #:sicl-hir-to-mir
  :depends-on (#:cleavir2-hir)
  :serial t
  :components
  ((:file "packages")
   (:file "generic-functions")
   (:file "cons")
   (:file "general-instance")
   (:file "hir-to-mir")))