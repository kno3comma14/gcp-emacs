;;; gcpemacs-serverless.el --- Tool for working with Google Functions           -*- lexical-binding: t -*-
;;
;; Filename: gcpemacs-serverless.el
;;
;; Copyright (C) 2020 Enyert Vinas
;;
;; Description: Tool for working with Google Functions
;; Author: Daniel Barreto <enyert.vinas@gmail.com>
;; Keywords: lisp, maint, tools
;; Created: Sun Feb 16 15:17:36 2020 (+0200)
;; Version: 0.1.1
;; Package-Requires: ((emacs "25.1"))
;; URL: https://github.com/evinasgu/gcpemacs
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;
;; Tool for working with Google Functions
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or (at
;; your option) any later version.
;;
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:

(setq gcloud-functions-list-command "gcloud functions list")
(setq gcloud-functions-regions-list-command "gcloud functions regions list")
(setq gcloud-functions-event-types-list-command "gcloud functions event-types list")
(setq gcloud-functions-list-command-keys '("NAME" "STATUS" "TRIGGER" "REGION"))

(defun call-command-without-headers (x)
  "Execute a given x command and remove the headers"
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

(defun create-single-functions-event-types-list-data (x)
  (let ((values (split-string x))
	(function_map (make-hash-table :test 'equal)))
    (puthash "EVENT_PROVIDER" (nth 0 values) function_map)
    (puthash "EVENT_TYPE" (nth 1 values) function_map)
    (puthash "EVENT_TYPE_DEFAULT" (nth 2 values) function_map)
    (puthash "RESOURCE_TYPE" (nth 3 values) function_map)
    (puthash "RESOURCE_OPTIONAL" (nth 4 values) function_map)
    function_map))

(defun create-functions-list-data ()
  (let ((rows (call-command-without-headers gcloud-functions-list-command)))
    (mapcar #'create-single-functions-list-data rows)))

(defun create-functions-regions-list-data ()
  (let ((rows (call-command-without-headers gcloud-functions-regions-list-command)))
    (mapcar  #'create-single-functions-regions-list-data rows)))

(defun create-functions-event-types-list-data ()
  (let ((rows (call-command-without-headers gcloud-functions-event-types-list-command)))
    (mapcar  #'create-single-functions-event-types-list-data rows)))

(provide 'gcpemacs-serverless)

;;; gcpemacs-serverless.el ends here
