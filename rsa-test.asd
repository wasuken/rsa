;; (require \'asdf)
 
 (in-package :cl-user)
 (defpackage rsa-test-asd
 (:use :cl :asdf))
 (in-package :rsa-test-asd)
 
 (defsystem rsa-test
 :depends-on (:rsa)
 :version "1.0.0"
 :author "wasu"
 :license "MIT"
 :components ((:module "t" :components ((:file "rsa-test"))))
 :perform (test-op :after (op c)
 (funcall (intern #.(string :run) :prove) c)))

