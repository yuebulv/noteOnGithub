;;;
;;;(Vlax-Get (Vlax-Ename->Vla-object (car (entsel))) 'EndPoint)
;;;
;;;(cdr (assoc 11 (entget (car (entsel)))))
;;;(vlax-dump-object vla-object)
;;;(vlax-dump-object Vlax-Get)


(defun c:huazhijiao ()
	(setq ��1 (getpoint "�������һ����"))
	(setq ��2 (getpoint ��1 "������ڶ�����"))
	(setq ��1��2�ĽǶ� (angle ��1 ��2)) 
	(setq ��2��3�ĽǶ� (+ ��1��2�ĽǶ� (* 0.5 pi)))
	(setq ��3 (polar ��2 ��2��3�ĽǶ� 5))
	(command "_.line" "non" ��1 "non" ��2 "non" ��3 "")
)