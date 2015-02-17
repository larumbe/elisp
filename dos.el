(setq old-kill-ring-max kill-ring-max)
(setq kill-ring-max 4)

(defun current-kill (n &optional do-not-move)
  "Rotate the yanking point by N places, and then return that kill.
     If N is zero, `interprogram-paste-function' is set, and calling it
     returns a string, then that string is added to the front of the
     kill ring and returned as the latest kill.
     If optional arg DO-NOT-MOVE is non-nil, then don't actually move the
     yanking point; just return the Nth kill forward."
  (let ((interprogram-paste (and (= n 0)
				 interprogram-paste-function
				 (funcall interprogram-paste-function))))
    (if interprogram-paste
	(progn
	  ;; Disable the interprogram cut function when we add the new
	  ;; text to the kill ring, so Emacs doesn't try to own the
	  ;; selection, with identical text.
	  (let ((interprogram-cut-function nil))
	    (kill-new interprogram-paste))
	  interprogram-paste)
      (or kill-ring (error "Kill ring is empty"))
      (let ((ARGth-kill-element
	     (nthcdr (mod (- n (length kill-ring-yank-pointer))
			  (length kill-ring))
		     kill-ring)))
	(or do-not-move
	    (setq kill-ring-yank-pointer ARGth-kill-element))
	(car ARGth-kill-element)))))

(defun Hola (nada)
  (interactive "P")
  (message "Hola"))
