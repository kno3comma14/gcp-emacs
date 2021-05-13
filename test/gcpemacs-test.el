;;; gcpemacs-test.el --- Tests for gcpemacs
(load-file "./lisp/gcpemacs-serverless.el")

(ert-deftest call-command-without-headers-test ()
  (should (equal (list "function-1         ACTIVE   HTTP Trigger  us-central1"
		       "gcpemacs-function  OFFLINE  HTTP Trigger  us-central1")
	     (call-command-without-headers "gcloud functions list")))) 

(ert-deftest example-test ()
  (should (= (+ 9 2) 11)))

;;; gcpemacs-test.el ends here
