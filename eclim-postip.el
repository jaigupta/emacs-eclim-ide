(require 'eclim)
(require 'pos-tip)

(defun eclim-show-postip (doc)
  ;; TODO(jaigupta): Check if we can make use of the links in docs.
  (pos-tip-show (assoc-default 'text doc)))

;; Show a small java doc at point without opening a new buffer.
(defun eclim-java-show-documentation-for-current-element-postip ()
  (interactive)
    (let ((symbol (symbol-at-point)))
      (if symbol
          (let ((bounds (bounds-of-thing-at-point 'symbol))
                (window-config (current-window-configuration)))
            (eclim/with-results doc ("java_element_doc"
                                     ("-p" (eclim--project-name))
                                     "-f"
                                     ("-l" (- (cdr bounds) (car bounds)))
                                     ("-o" (save-excursion
                                             (goto-char (car bounds))
                                             (eclim--byte-offset))))
              (eclim-show-postip doc)))

        (message "No element found at point."))))

(provide 'eclim-postip)
