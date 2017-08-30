(in-package :cl-user)
(defpackage cldi
  (:use :cl)
  (:export :defif
           :defdep))
(in-package :cldi)


(defmacro defif (servicename lambda-list)
  "define interface"
  `(defun ,servicename ,lambda-list
     (declare (ignore
               ,@(remove-if #'(lambda (s)
                                (eq (char (symbol-name s) 0)
                                    #\&))
                            `,lambda-list)))
     (error (format NIL "cannot run ~A service. need to define dependency" ',servicename))))

(defmacro defdep (servicename lambda-list &body body)
  "define dependency"
  (handler-case
      (symbol-function servicename)
    (undefined-function ()
      (error (format NIL "not define interface:~A" servicename))))
  `(progn
     (setf (fdefinition ',servicename)
           #'(lambda ,lambda-list
               ,@body))
     ',servicename))

