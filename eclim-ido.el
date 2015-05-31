(require 'eclim)
(require 'ido)

;; Use ido mode with eclim-file-locate
;; TODO(jaigupta): respect case-sensitive from eclim.el
(defun eclim-file-locate-ido ()
  (interactive)
  (eclim/with-results hits ("locate_file" ("-p" "^.*$") ("-s" "workspace"))
    (find-file (ido-completing-read "Select file:" (mapcar (lambda (hit) (assoc-default 'path hit)) hits)))))

(provide 'eclim-ido)
