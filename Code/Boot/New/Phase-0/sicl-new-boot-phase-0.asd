(cl:in-package #:asdf-user)

(defsystem #:sicl-new-boot-phase-0
  :depends-on (#:sicl-hir-to-cl
               :sicl-source-tracking
               :eclector
               :eclector-concrete-syntax-tree)
  :serial t
  :components
  ((:file "packages")
   (:file "import-from-host")
   (:file "define-defmacro")
   (:file "define-backquote-macro")
   (:file "define-default-setf-expander")
   (:file "fill-environment")
   (:file "environment")
   (:file "load-file")))