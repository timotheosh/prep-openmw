;;;; prep-openmw.lisp
;;
;;;; Copyright (c) 2019 Tim Hawes


(in-package #:prep-openmw)

(defparameter *module-directory* (pathname "/home/thawes/SpiderOak Hive/Games/Elder Scrolls/Morrowind/OpenMW/mods/"))
(defparameter *target-directory* "/home/thawes/target/")

(defparameter *unpacker-7z*
  '((:cmd "7z")
    (:extract "x")
    (:overwrite "-y")))

(defparameter *unpacker-zip*
  '((:cmd "unzip")
    (:extract "")
    (:overwrite "-o")))

(defparameter *unpacker-rar*
  '((:cmd "unrar")
    (:extract " x ")
    (:overwrite "-o+")))

(defun get-unpacker (path)
  (let ((file-type (pathname-type path)))
    (multiple-value-bind (sym junk)
        (intern (string-upcase (format nil "*unpacker-~A*" file-type)))
      (handler-case
          (symbol-value sym)
        (unbound-variable (terr)
          (format t "Don't have an unpacker defined for ~A~%" file-type))))))

(defun unpack (file)
  (let* ((unpacker (get-unpacker file))
         (command
          (format nil "~A ~A ~A \"~A\""
                  (second (assoc :cmd unpacker))
                  (second (assoc :extract unpacker))
                  (second (assoc :overwrite unpacker))
                  file)))
    (if unpacker
        (progn
          (uiop:chdir *target-directory*)
          (uiop:run-program command))
        (format t "Cannot unpack file ~A" file))))

(defun module-list (&optional (path *module-directory*))
  (remove-if-not #'uiop:file-pathname-p
                 (directory (format nil "~A/*.*" path))))

(defun -main (&rest argv)
  (declare (ignorable argv)))
