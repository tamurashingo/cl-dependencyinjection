# cl-dependencyinjection - Dependency Injection macro for Common Lisp
[![Build Status](https://travis-ci.org/tamurashingo/cl-dependencyinjection.svg?branch=develop)](https://travis-ci.org/tamurashingo/cl-dependencyinjection)


## Usage

```common-lisp
;; define interface

CL-USER> (defif test-service (x))
TEST-SERVICE

; error occurs when call test-service at this point

CL-USER> (test-service "some data")
; Evaluation aborted on #<SIMPLE-ERROR "cannot run TEST-SERVICE. need to define dependency" {1005756013}>.

;; define dependency

CL-USER> (defdep test-service (x)
           (format T "this is test-service")
           (format NIL "***~A***" x))
TEST-SERVICE

CL-USER> (test-service "some data")
this is test-service
"***some data***"
```


### in application


#### define interface

In `service.lisp`, define interface.
function name, arguments.

```common-lisp
(defpackage someapp.service
  (:use :cl
        :cl-dependencyinjection)
  (:export :some-service))
(in-package :someapp.service)

(defif some-service (&rest params)
  "some-service provides its service name and its parameters

params
- &rest params parameters what you want to print

returns
- nothing")
```

#### define dependency
In `service-impl.lisp`, define dependency.
`defdep` overwrites the function defined by `defif`.

```common-lisp
(defpackage someapp.service.impl
  (:use :cl
        :cl-dependencyinjection)
  (:import-from :someapp.service
                :some-service))
(in-package :someapp.service.impl)

(defdep some-service (&rest params)
  (format T "some-service~%")
  (loop for p in params
        do (format T "param:~A~%" p))
  (format T "done~%"))
```


#### call the service

In `client.lisp`, call the service.

```common-lisp
(defpackage someapp.client
  (:use :cl)
  (:import-from :someapp.service
                :some-service))

(some-service 1 2 3)

;-> some-service
;-> param:1
;-> param:2
;-> param:3
;-> done
```

### in test

#### define mocked dependency

In test, `cl-dependencyinjection` helps you to create mock function.


```common-lisp
(defpackage someapp.service.test
  (:use :cl
        :cl-dependencyinjection)
  (:import-from :someapp.service
                :some-service))

(defdep some-service (&rest params)
  (format T "some mocked service")
  T)
```


## Installation

This library will be available on Quicklisp when ready for use.

## Author

* tamura shingo (tamura.shingo@gmail.com)

## Copyright

Copyright (c) 2017 tamura shingo (tamura.shingo@gmail.com)

## License

Licensed under the MIT License.
