;;; gcpemacs-test.el --- Tests for gcpemacs
(require 'el-mock)
(load-file "./lisp/gcpemacs-serverless.el")

(ert-deftest call-command-without-headers-test ()
  (with-mock
   (mock (shell-command-to-string-functions gcloud-functions-list-command) =>
	 (concat "NAME                STATUS   TRIGGER       REGION" "\n"
		 "function-1          ACTIVE   HTTP Trigger  us-central1" "\n"
		 "gcpemacs-function   OFFLINE  HTTP Trigger  us-central1" "\n"))
   (mock (shell-command-to-string-regions gcloud-functions-regions-list-command) =>
	 (concat "NAME" "\n"
		 "projects/amplified-bee-313606/locations/us-central1" "\n"
		 "projects/amplified-bee-313606/locations/us-east1" "\n"
		 "projects/amplified-bee-313606/locations/us-east4" "\n"
		 "projects/amplified-bee-313606/locations/us-west2" "\n"
		 "projects/amplified-bee-313606/locations/us-west3" "\n"
		 "projects/amplified-bee-313606/locations/us-west4" "\n"
		 "projects/amplified-bee-313606/locations/europe-central2" "\n"
		 "projects/amplified-bee-313606/locations/europe-west1" "\n"
		 "projects/amplified-bee-313606/locations/europe-west2" "\n"
		 "projects/amplified-bee-313606/locations/europe-west3" "\n"
		 "projects/amplified-bee-313606/locations/europe-west6" "\n"
		 "projects/amplified-bee-313606/locations/asia-east2" "\n"
		 "projects/amplified-bee-313606/locations/asia-northeast1" "\n"
		 "projects/amplified-bee-313606/locations/asia-northeast2" "\n"
		 "projects/amplified-bee-313606/locations/asia-northeast3" "\n"
		 "projects/amplified-bee-313606/locations/asia-south1" "\n"
		 "projects/amplified-bee-313606/locations/asia-southeast2" "\n"
		 "projects/amplified-bee-313606/locations/northamerica-northeast1" "\n"
		 "projects/amplified-bee-313606/locations/southamerica-east1" "\n"
		 "projects/amplified-bee-313606/locations/australia-southeast1" "\n"))
   (mock (shell-command-to-string-eventtypes gcloud-functions-event-types-list-command) =>
	 (concat "EVENT_PROVIDER                   EVENT_TYPE                                                EVENT_TYPE_DEFAULT  RESOURCE_TYPE       RESOURCE_OPTIONAL" "\n"
		 "cloud.pubsub                     google.pubsub.topic.publish                               Yes                 topic               No" "\n"
		 "cloud.pubsub                     providers/cloud.pubsub/eventTypes/topic.publish           No                  topic               No" "\n"))
   (should (equal
	    (list "function-1          ACTIVE   HTTP Trigger  us-central1"
		  "gcpemacs-function   OFFLINE  HTTP Trigger  us-central1")
	    (call-command-without-headers (shell-command-to-string-functions gcloud-functions-list-command))))
   (should (equal
	    (list "projects/amplified-bee-313606/locations/us-central1"
		  "projects/amplified-bee-313606/locations/us-east1"
		  "projects/amplified-bee-313606/locations/us-east4"
		  "projects/amplified-bee-313606/locations/us-west2"
		  "projects/amplified-bee-313606/locations/us-west3"
		  "projects/amplified-bee-313606/locations/us-west4"
		  "projects/amplified-bee-313606/locations/europe-central2"
		  "projects/amplified-bee-313606/locations/europe-west1"
		  "projects/amplified-bee-313606/locations/europe-west2"
		  "projects/amplified-bee-313606/locations/europe-west3"
		  "projects/amplified-bee-313606/locations/europe-west6"
		  "projects/amplified-bee-313606/locations/asia-east2"
		  "projects/amplified-bee-313606/locations/asia-northeast1"
		  "projects/amplified-bee-313606/locations/asia-northeast2"
		  "projects/amplified-bee-313606/locations/asia-northeast3"
		  "projects/amplified-bee-313606/locations/asia-south1"
		  "projects/amplified-bee-313606/locations/asia-southeast2"
		  "projects/amplified-bee-313606/locations/northamerica-northeast1"
		  "projects/amplified-bee-313606/locations/southamerica-east1"
		  "projects/amplified-bee-313606/locations/australia-southeast1")
	    (call-command-without-headers (shell-command-to-string-regions gcloud-functions-regions-list-command))))
   (should (equal
	    (list "cloud.pubsub                     google.pubsub.topic.publish                               Yes                 topic               No"
		  "cloud.pubsub                     providers/cloud.pubsub/eventTypes/topic.publish           No                  topic               No")
	    (call-command-without-headers (shell-command-to-string-eventtypes gcloud-functions-event-types-list-command))))))

;;; gcpemacs-test.el ends here
