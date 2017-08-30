#|
  This file is a part of cl-dependencyinjection project.
  Copyright (c) 2017 tamura shingo (tamura.shingo@gmail.com)
|#

#|
  Dependency Injection macro for Common Lisp

  Author: tamura shingo (tamura.shingo@gmail.com)
|#

(in-package :cl-user)
(defpackage cldi-asd
  (:use :cl :asdf))
(in-package :cldi-asd)

(defsystem cldi
  :version "0.1"
  :author "tamura shingo"
  :license "MIT"
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "cldi"))))
  :description "Dependency Injection macro for Common Lisp"
  :long-description
  #.(with-open-file (stream (merge-pathnames
                             #p"README.markdown"
                             (or *load-pathname* *compile-file-pathname*))
                            :if-does-not-exist nil
                            :direction :input)
      (when stream
        (let ((seq (make-array (file-length stream)
                               :element-type 'character
                               :fill-pointer t)))
          (setf (fill-pointer seq) (read-sequence seq stream))
          seq)))
  :in-order-to ((test-op (test-op cldi-test))))
