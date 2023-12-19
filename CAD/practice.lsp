;;;
;;;(Vlax-Get (Vlax-Ename->Vla-object (car (entsel))) 'EndPoint)
;;;
;;;(cdr (assoc 11 (entget (car (entsel)))))
;;;(vlax-dump-object vla-object)
;;;(vlax-dump-object Vlax-Get)


(defun c:huazhijiao ()
	(setq 点1 (getpoint "请输入第一个点"))
	(setq 点2 (getpoint 点1 "请输入第二个点"))
	(setq 点1点2的角度 (angle 点1 点2)) 
	(setq 点2点3的角度 (+ 点1点2的角度 (* 0.5 pi)))
	(setq 点3 (polar 点2 点2点3的角度 5))
	(command "_.line" "non" 点1 "non" 点2 "non" 点3 "")
)