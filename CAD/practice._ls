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

(defun c:pbox (/ pa pb pe pd ww hh mpl mp2 mp3 mp4)
  ;���ܣ���������
	(setvar "cmdecho"0)
	(setvar "blipmode" 0)
	;����paww��hhֵ�����û�����
	(setq pa(getpoint"���½ǵ�:"))
	(setq ww (getdist pa"n ���:"))
	(setq hh (getdist pa"m�߶�:"))
	;;����pbpcpdֵ���ɳ������paww��hh����ó�
	(setq pb (polar pa 0 ww))
	(setq pc (polar pb (/ pi 2) hh))
	(setq pd (polar pc pi ww))
	;;;��������papbpcpd�㻭����
	(command "pline" pa pb pc pd "c")
	;����mp1mp2mp3mpֵ���ɳ������pa��ww��hh
	;;;&pbpcpdֵ����ó�
	(setq mp1 (polar pa 0 (/ ww 2)))
	(setq mp2 (polar pb (/ pi 2) (/ hh 2)))
	(setq mp3 (polar pd 0 (/ ww 2)))
	(setq mp4 (polar pa (/ pi 2) (/ hh 2)))
	;;;��������mplmp2mp3��mp4�㻭��������
	(command "line" mp1 mp3 "")
	(command "line" mp2 mp4 "")
	(prin1)
)
(prompt"\n<<C:PBOX>>������ƣ�����SAKURA")
(prompt"\n�����ҵĵ�һ����ʽ��AutoLISP����")
(prin1)

;��ͼ�г���ҪΪʮ�ֹ�����ߵ�����ͬ�ĽǶ���������Զ�����λ��ֱ��������룬�����ķ�ʽ���� SNAPANG �ֱ��ٸ����Ƕ�ֵ��
(defun c:0() (setvar"snapang"0) (prin1))
(defun c:15() (setvar "snapang"(* 15 (/ pi 180))) (prin1))
(defun c:30() (setvar "snapang"(* 30(/ pi 180))) (prin1))
(defun c:45() (setvar "snapang" (* 45 (/ pi 180))) (prin1))
(defun c:60() (setvar "snapang"(* 60 (/ pi 180))) (prin1))
(defun c:75() (setvar "snapang" (* 75 (/ pi 180))) (prin1))
(prompt"ֱ������015��30456075ʮ�ֹ�����߽Ƕȵ���ֵ")

(defun c:5test1()
	;����pawwkkֵ�����û�����
	(setq pa(getpoint"������ֱ�����������½ǵ�:"))
	(setq ww(getreal"n������ֱ�������εױ߳���:"))
	(setq kk(getreal"n������ֱ��������б�߳���:"))
	;����pbpchhֵ���ɳ�������pa ww��kk����ó�
	(setq pb (polar pa 0 ww))
	(setq hh(sqrt(-(* kk kk)(* ww ww))))
	(setq pc (polar pa (/ pi 2) hh))
	;��������papb��pc�㻭��ֱ��������
	(command "line" pa pb pc "c")
	;��PLINEҲ����
	(princ"n��һ��hh�ĳ���=")(princ hh)
	;���½����������н��Զ����������ʾ��������
	(setq ang_pb (atan (/ hh ww)))
	(setq ang_pb (* ang_pb (/ 180 pi)))
	(setq ang_pc(- 90 ang_pb))
	(princ "\nPB�ļн�=")(princ ang_pb)(princ"��")
	(princ "\nPC�ļн�=")(princ ang_pc)(princ"��")
	(prin1)
  )
(prompt"\n<<5TEST1>>�Զ�ֱ�������λ���")
(prin1)

(defun c:5test2()
	;����baspt��rad��numֵ�����û�����
	(setq baspt(getpoint"���������׼��:"))
	(setq rad(getdist baspt"\n��������СԲ�뾶:"))
	(setq num(getint"\n�����������е�СԲ����:"))
	;ֻҪ�����cenpt�㣬����array������ϾͿ�����
	;����ang1��kk��cenptֵ���ɳ�������baspt��rad��num���
	(setq ang1 (/ (* pi 2)(* num 2)))
	(setq kk (/ rad (sin ang1)))
	(setq ang2 (- (/ pi 2) ang1))
	(setq cenpt (polar baspt ang2 kk))
	;��������cenpt��num��ϻ���array������Բ����
	(command "circle" baspt rad)
	;�Ȼ�һ��Բ������array
	(command "array" (entlast) "" "p" cenpt num 360 "Y")
	(prin1)
)
(prompt"\n<5TEST2>>�Զ���Բ���л���")
(prin1)