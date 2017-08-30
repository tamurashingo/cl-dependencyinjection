(in-package :cl-user)
(defpackage cldi-test
  (:use :cl
        :cldi
        :prove))
(in-package :cldi-test)

(plan nil)

;; ----------------------------------------
;; define interface
;; ----------------------------------------
(ok (defif test-service0 ())
    "define no argument service")
(ok (defif test-service1 (x))
    "define one argument service")
(ok (defif test-service2 (x y))
    "define two arguments service")
(ok (defif test-service0 (zero))
    "overwrite defined service")

(ok (defif test-service-optional (a b &optional c))
    "optional")
(ok (defif test-service-rest (a b &rest c &key d e f))
    "rest, key")


;; ----------------------------------------
;; define dependency
;; ----------------------------------------
(defif test-service0 ())
(defdep test-service0 ()
  "test-service0")
(is (test-service0) "test-service0")

(defif test-service1 (x))
(defdep test-service1 (x)
  (+ x 1))
(is (test-service1 0) 1)
(is (test-service1 2) 3)

(defif test-service2 (x y))
(defdep test-service2 (x y)
  (format T "test-service2")
  (let ((x x)
        (y y))
    (+ x y)))
(is (test-service2 1 2) 3)
(is (test-service2 4 5) 9)


;; ----------------------------------------
;; error case
;; ----------------------------------------
(is-error (defdep test-service-error (e)
            (format T "this is error case" e))
          error
          "undefined interface")

(finalize)
