(in-package :cl-user)
(defpackage cl-dependencyinjection-asd
  (:use :cl :asdf))
(in-package :cl-dependencyinjection-asd)

(defsystem cl-dependencyinjection
  :version "0.1"
  :author "tamura shingo"
  :license "MIT"
  :depends-on (:cldi))
