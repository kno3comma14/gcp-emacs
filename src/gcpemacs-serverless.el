; NAME STATUS TRIGGER REGION

(setq gcloud-functions-list-command "gcloud functions list")
(setq gcloud-functions-regions-list-command "gcloud functions regions list")
(setq gcloud-functions-list-command-keys '("NAME" "STATUS" "TRIGGER" "REGION"))

(defun call-command-without-headers (x)
  (butlast (cdr (split-string (shell-command-to-string x) "\n")) 1))

(defun create-single-functions-list-data (x)
  (let ((values (split-string x))
	(function_map (make-hash-table :test 'equal)))    
    (puthash "NAME" (nth 0 values) function_map)
    (puthash "STATUS" (nth 1 values) function_map)
    (puthash "TRIGGER" (nth 2 values) function_map)
    (puthash "REGION" (nth 3 values) function_map)
    function_map))

(defun create-single-functions-regions-list-data (x)
  (let ((values (split-string x))
	(function_map (make-hash-table :test 'equal)))
    (puthash "NAME" (nth 0 values) function_map)
    function_map))

(defun create-functions-list-data ()
  (let ((rows (call-command-without-headers gcloud-functions-list-command)))
    (mapcar #'create-single-functions-list-data rows)))

(defun create-functions-regions-list-data ()
  (let ((rows (call-command-without-headers gcloud-functions-regions-list-command)))
    (mapcar  #'create-single-functions-regions-list-data rows)))
  
