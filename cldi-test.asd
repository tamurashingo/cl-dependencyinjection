#|
  This file is a part of cl-dependencyinjection project.
  Copyright (c) 2017 tamura shingo (tamura.shingo@gmail.com)
|#

(in-package :cl-user)
(defpackage cldi-test-asd
  (:use :cl :asdf))
(in-package :cldi-test-asd)

(defsystem cldi-test
  :author "tamura shingo"
  :license "MIT"
  :depends-on (:cldi
               :prove)
  :components ((:module "t"
                :components
                ((:test-file "cldi"))))
  :description "Test system for cl-dependencyinjection"

  :defsystem-depends-on (:prove-asdf)
  :perform (test-op :after (op c)
                    (funcall (intern #.(string :run-test-system) :prove-asdf) c)
                    (asdf:clear-system c)))
