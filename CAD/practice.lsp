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

(defun c:chgrad()
	(setvar "cmdecho" 0) ;����ִ�й��̲�����
	;ƴ����ΪINPUT����ѡ��
	(setq en (entsel"ѡ����֪Բ:")) ;Ҫ����ѡһһ��Բ
	;;;;����Ϊ����������뾶����ȡ��
	(setq en_data (entget (car en))) 	;ȡ�ö��������б�
	(setq old_rad_list (assoc 40 en_data))	;ȡ�ð뾶���б�
	(setq old_rr (cdr old_rad_list)) 	;ȡ�þ��а뾶
	(princ"\n�ɰ뾶")(princ old_rr) 	;��ʾ�þ�Բ�뾶ֵ��������
	;;;����Ϊ�°뾶��������������¾ɰ뾶����
	(setq cenpt (cdr (assoc 10 en_data)))	;ȡ��Բ��Բ��
	(setq new_rr (getdist cenpt "\nNew Radius:")) 	;Ҫ������һ�뾶ֵ
	(setq new_rad_list (cons 40 new_rr))	;�����°뾶���б�
	(setq en_data (subst new_rad_list old_rad_list en_data))	;�¾ɽ���
	(entmod en_data)	;�����¶��������Զ�����Բ�뾶
	(prin1)
  )
(prompt "�޸�Բ�뾶")
(prin1)

(defun c:cpoly5()
	(setvar "cmdecho" 0) ;����ִ�й��̲���Ӧ
	(setq en (entsel "Select CIRCLE:")) ;Ҫ��ѡ��һ��Բ
	(setq en_data (entget (car en))) ;ȡ�ö��������б�
	(setq cenpt (cdr (assoc 10 en_data))) ;���Բ��cenpt
	(setq rr (cdr (assoc 40 en_data))) ;��ð뾶m
	(command "polygon" 5 cenpt "i" rr) ;���Բ�ڽ��������
	(prin1)
  )
(prompt "�ڽ��������")
(prin1)	
	
(defun c:mcir3()
	(setvar "cmdecho" 0)
	(setq en (entsel "Select aLINE:"))
	(setq pts (cadr en))
	(setq mpt (osnap pts "mid"))
	(command "circle"mpt pause) ;ע��pause���÷�
	(prin1)
)	
	
(prompt "<C:MCIR3>>***")
(prin1)	
	
	
(defun c:7testa()
	;����sizeֵ�����û�����
	(initget"A0 A1 A2 A3 A4") ;�����ַ���Ч��
	(setq size(getkword"������ͼֽ��СA0,A1,A2,A3,A4,<A3>"))
	(if(= size nil)(setq size "A3"))
	(setq size(strcase size));ͳһת�ɴ�д
	;cond�����ж�ʽ
	(cond((= size "A0") (setq p2 '(1189 841)))
		((= size"A1")(setq p2 '(841 594)))
		((= size "A2") (setq p2 '(594 420)))
		((= size"A3")(setq p2 '(420 297)))
		((= size"A4") (setq p2 '(297 210)))
		(t(setq p2 '(420 297)))
	     )
	;׼�����ƾ���ͼ��
	(setq p1 '(0 0))
	(command "rectang" p1 p2)
	(command "zoom" "A")
	(prin1)
  )

(defun c:7test2()
	;����paww��hh��nֵ�����û�����
	(setq pa(getpoint"�����������½ǵ�:"))
	(setq ww(getdist pa"\n��������¥�ݿ��:"))
	(setq hh (getdist pa"\n��������¥�ݸ߶�:"))
	(setq n (getint "\n��������¥�ݽ���:"))
	;�Ȼ���pa>pb>pc
	(setq pb (polar pa 0 ww))
	(setq pc (polar pb (/ pi 2) hh))
	(command "line" pa pb pc "")
	;��������������dw��dh��ppֵ���ɳ�������ww��hh��n���
	(setq dw (/ ww n))
	(setq dh (/ hh n))
	(setq pp pa)
	;����׼������repeatѭ����
  	;����һ����line��
;;;	(repeat n
;;;		(setq p1 (polar pp (/ pi 2) dh))
;;;		(setq p2 (polar p1 0 dw))
;;;		(command "line" pp p1 p2 "")
;;;		(setq pp p2)
;;;	  )
  
  	;���������ö���߻�
	(command "pline")
  	(command pp)
	(repeat n
		(setq p1 (polar pp (/ pi 2) dh))
		(setq p2 (polar p1 0 dw))
		(command p1 p2)
		(setq pp p2)
  	  )
	(command"")

	(prin1)
  
  )
(prompt"\n<<7TEST2>>�����Զ�¥�ݻ��Ƴ���")
(prin1)

(defun c:7test3()
	;����paww��hh��nֵ�����û�����
	(setq n(getint"��������������α���N="))
	(setq en(entsel"\nѡȡ��������������ε�Բ:"))
	(setq I 0)
	(while en;��en����ʱ��ִ������ѭ�����ݣ�ֱ��en ������Ϊֹ
		(setq en_data (entget (car en)))
		(setq en_type (cdr (assoc 0 en_data)))
		;Ⱥ��0Ϊ�������
		(if(= en_type "CIRCLE")
			(progn
				(setq cenpt (cdr (assoc 10 en_data)))
				(setq rad (cdr (assoc 40 en_data)))
				(command "polygon" n cenpt "I" rad)
				(setq I(1+ I))
			  )
			(alert"�ö��󲢲���Բ������ѡȡԲ")
		);end if
		(setq en(entsel "\nѡ����һ����������������ε�Բ:"))
	  )
	(princ(strcat"\n��������"(itoa i)"Բ�����������"))
	(prin1)
  )
(prompt"\n<<7TEST3>�����Զ��Բ���������������")
(prin1)

(defun c:9test2()
	(sub_chk_layer)
	(sub_chk_style)
	;;;���Ͽ����ú�����������У��������ͼ��������
	;;�����ٴ�������������	  
	(prin1)
  )
(defun sub_chk_layer()
	(setq chklay (tblsearch "layer" "str"))
	(if(= chklay nil)
		(command "layer""n" "str" "c" "4" "str" "")
  	)
	(setq chklay (tblsearch "layer" "txt"))
	(if(= chklay nil)
		(command "layer" "n""txt" "c" "3" "t" "")
	  )
	(setq chklay (tblsearch "layer" "dim"))
	(if(= chklay nil)
		(command "layer""n" "dim" "c" "5" "dim" "")
	  )
	(setq chklay (tblsearch "layer" "hat"))
	(if(= chklay nil)
		(command "layer""n""hat" "c""6""hat" "")
	  )
	(setq chklay (tblsearch "layer" "cen"))
	(if(= chklay nil)
		(command "layer" "n" "cen" "c" "2" "cen" "lt" "center" "cen" "")
	  )
	(setq chklay (tblsearch "layer" "hid"))
	(if(= chklay nil)
		(command "layer" "n""hid" "c" "2" "hid" "lt" "hidden" "hid" "")
	  )
	(prompt"\nͼ��STR��TXT��HAT��DIM��CEN��HID����OK!")
  )

(defun sub_chk_style()
	(setq chksty (tblsearch "style" "CC"))
	(if(= chksty nil)
		(command "style""CC" "txt,chineset" "" "" "" "" "" "")
	  )
	(setq chksty (tblsearch "style" "kk"))
	(if (= chksty nil)
		(command "style" "kk" "����" "" "" "" "" "")
	  )
	(prompt"\n����CC��kk����OK!")
  )

(defun c:10test()
	(setq data list '())
	;�����ļ����û�ѡȡ
	(setq dat_file(getfiled"չ�㷶��""C:\\LSPTOOLS\\10test1""dat"2))
	(setq ff (open dat_file "r"))
	(setq data (read-line ff))
	(while data
		(setq data_list (cons data data_list))
		(setq data(read-line ff))
	  )
	(setq data_list (reverse data_list))
	(command "pline"(foreach pt data_list (command pt)))
	(close ff)
	(prin1)
)
(prompt "<10TEST2>>�Զ�չ���б��ɳ���")
(prin1)