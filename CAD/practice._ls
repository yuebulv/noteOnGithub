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

(defun c:pbox (/ pa pb pe pd ww hh mpl mp2 mp3 mp4)
  ;功能：画田字型
	(setvar "cmdecho"0)
	(setvar "blipmode" 0)
	;以下paww、hh值须由用户输入
	(setq pa(getpoint"左下角点:"))
	(setq ww (getdist pa"n 宽度:"))
	(setq hh (getdist pa"m高度:"))
	;;以下pbpcpd值须由程序根据paww、hh运算得出
	(setq pb (polar pa 0 ww))
	(setq pc (polar pb (/ pi 2) hh))
	(setq pd (polar pc pi ww))
	;;;以下依据papbpcpd点画矩形
	(command "pline" pa pb pc pd "c")
	;以下mp1mp2mp3mp值须由程序根据pa、ww、hh
	;;;&pbpcpd值运算得出
	(setq mp1 (polar pa 0 (/ ww 2)))
	(setq mp2 (polar pb (/ pi 2) (/ hh 2)))
	(setq mp3 (polar pd 0 (/ ww 2)))
	(setq mp4 (polar pa (/ pi 2) (/ hh 2)))
	;;;以下依据mplmp2mp3、mp4点画出两条线
	(command "line" mp1 mp3 "")
	(command "line" mp2 mp4 "")
	(prin1)
)
(prompt"\n<<C:PBOX>>程序设计，作者SAKURA")
(prompt"\n这是我的第一个正式的AutoLISP程序")
(prin1)

;作图中常需要为十字光标轴线调整不同的角度以利配合自动方向定位法直接输入距离，调整的方式可用 SNAPANG 分别再给出角度值。
(defun c:0() (setvar"snapang"0) (prin1))
(defun c:15() (setvar "snapang"(* 15 (/ pi 180))) (prin1))
(defun c:30() (setvar "snapang"(* 30(/ pi 180))) (prin1))
(defun c:45() (setvar "snapang" (* 45 (/ pi 180))) (prin1))
(defun c:60() (setvar "snapang"(* 60 (/ pi 180))) (prin1))
(defun c:75() (setvar "snapang" (* 75 (/ pi 180))) (prin1))
(prompt"直接输入015、30456075十字光标轴线角度调整值")

(defun c:5test1()
	;以下pawwkk值须由用户输入
	(setq pa(getpoint"请输入直角三角形左下角点:"))
	(setq ww(getreal"n请输入直角三角形底边长度:"))
	(setq kk(getreal"n请输入直角三角形斜边长度:"))
	;以下pbpchh值须由程序依据pa ww、kk计算得出
	(setq pb (polar pa 0 ww))
	(setq hh(sqrt(-(* kk kk)(* ww ww))))
	(setq pc (polar pa (/ pi 2) hh))
	;以下依据papb、pc点画出直角三角形
	(command "line" pa pb pc "c")
	;用PLINE也可以
	(princ"n另一边hh的长度=")(princ hh)
	;以下将三角形两夹角自动求出，并显示在命令区
	(setq ang_pb (atan (/ hh ww)))
	(setq ang_pb (* ang_pb (/ 180 pi)))
	(setq ang_pc(- 90 ang_pb))
	(princ "\nPB的夹角=")(princ ang_pb)(princ"度")
	(princ "\nPC的夹角=")(princ ang_pc)(princ"度")
	(prin1)
  )
(prompt"\n<<5TEST1>>自动直角三角形绘制")
(prin1)

(defun c:5test2()
	;以下baspt、rad、num值须由用户输入
	(setq baspt(getpoint"请求输入基准点:"))
	(setq rad(getdist baspt"\n请求输入小圆半径:"))
	(setq num(getint"\n请求输入相切的小圆数量:"))
	;只要能求得cenpt点，再以array命令配合就可以了
	;以下ang1、kk、cenpt值须由程序依据baspt、rad、num求出
	(setq ang1 (/ (* pi 2)(* num 2)))
	(setq kk (/ rad (sin ang1)))
	(setq ang2 (- (/ pi 2) ang1))
	(setq cenpt (polar baspt ang2 kk))
	;以下依据cenpt、num配合环形array画出多圆相切
	(command "circle" baspt rad)
	;先画一个圆，才能array
	(command "array" (entlast) "" "p" cenpt num 360 "Y")
	(prin1)
)
(prompt"\n<5TEST2>>自动等圆相切绘制")
(prin1)

(defun c:chgrad()
	(setvar "cmdecho" 0) ;命令执行过程不返回
	;拼以下为INPUT对象选择
	(setq en (entsel"选择已知圆:")) ;要求碰选一一个圆
	;;;;以下为对象属性与半径属性取得
	(setq en_data (entget (car en))) 	;取得对象属性列表
	(setq old_rad_list (assoc 40 en_data))	;取得半径子列表
	(setq old_rr (cdr old_rad_list)) 	;取得旧有半径
	(princ"\n旧半径")(princ old_rr) 	;显示该旧圆半径值于命令行
	;;;以下为新半径输入与对象属性新旧半径更替
	(setq cenpt (cdr (assoc 10 en_data)))	;取得圆的圆心
	(setq new_rr (getdist cenpt "\nNew Radius:")) 	;要求输入一半径值
	(setq new_rad_list (cons 40 new_rr))	;产生新半径子列表
	(setq en_data (subst new_rad_list old_rad_list en_data))	;新旧交替
	(entmod en_data)	;根据新对象属性自动更新圆半径
	(prin1)
  )
(prompt "修改圆半径")
(prin1)

(defun c:cpoly5()
	(setvar "cmdecho" 0) ;命令执行过程不响应
	(setq en (entsel "Select CIRCLE:")) ;要求选择一个圆
	(setq en_data (entget (car en))) ;取得对象属性列表
	(setq cenpt (cdr (assoc 10 en_data))) ;求得圆心cenpt
	(setq rr (cdr (assoc 40 en_data))) ;求得半径m
	(command "polygon" 5 cenpt "i" rr) ;完成圆内接正五边形
	(prin1)
  )
(prompt "内接正五边形")
(prin1)	
	
(defun c:mcir3()
	(setvar "cmdecho" 0)
	(setq en (entsel "Select aLINE:"))
	(setq pts (cadr en))
	(setq mpt (osnap pts "mid"))
	(command "circle"mpt pause) ;注意pause的用法
	(prin1)
)	
	
(prompt "<C:MCIR3>>***")
(prin1)	
	
	
(defun c:7testa()
	;以下size值须由用户输入
	(initget"A0 A1 A2 A3 A4") ;输入字符有效性
	(setq size(getkword"请输入图纸大小A0,A1,A2,A3,A4,<A3>"))
	(if(= size nil)(setq size "A3"))
	(setq size(strcase size));统一转成大写
	;cond多重判断式
	(cond((= size "A0") (setq p2 '(1189 841)))
		((= size"A1")(setq p2 '(841 594)))
		((= size "A2") (setq p2 '(594 420)))
		((= size"A3")(setq p2 '(420 297)))
		((= size"A4") (setq p2 '(297 210)))
		(t(setq p2 '(420 297)))
	     )
	;准备绘制矩形图框
	(setq p1 '(0 0))
	(command "rectang" p1 p2)
	(command "zoom" "A")
	(prin1)
  )

(defun c:7test2()
	;以下paww、hh、n值须由用户输入
	(setq pa(getpoint"请求输入左下角点:"))
	(setq ww(getdist pa"\n请求输入楼梯宽度:"))
	(setq hh (getdist pa"\n请求输入楼梯高度:"))
	(setq n (getint "\n请求输入楼梯阶数:"))
	;先画出pa>pb>pc
	(setq pb (polar pa 0 ww))
	(setq pc (polar pb (/ pi 2) hh))
	(command "line" pa pb pc "")
	;请留意以下三行dw、dh、pp值须由程序依据ww、hh与n求出
	(setq dw (/ ww n))
	(setq dh (/ hh n))
	(setq pp pa)
	;以下准备进入repeat循环了
  	;方案一，用line画
;;;	(repeat n
;;;		(setq p1 (polar pp (/ pi 2) dh))
;;;		(setq p2 (polar p1 0 dw))
;;;		(command "line" pp p1 p2 "")
;;;		(setq pp p2)
;;;	  )
  
  	;方案二，用多段线画
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
(prompt"\n<<7TEST2>>快速自动楼梯绘制程序")
(prin1)

(defun c:7test3()
	;以下paww、hh、n值须由用户输入
	(setq n(getint"请求输入正多边形边数N="))
	(setq en(entsel"\n选取想作内切正多边形的圆:"))
	(setq I 0)
	(while en;当en存在时，执行以下循环内容，直到en 不存在为止
		(setq en_data (entget (car en)))
		(setq en_type (cdr (assoc 0 en_data)))
		;群码0为对象类别
		(if(= en_type "CIRCLE")
			(progn
				(setq cenpt (cdr (assoc 10 en_data)))
				(setq rad (cdr (assoc 40 en_data)))
				(command "polygon" n cenpt "I" rad)
				(setq I(1+ I))
			  )
			(alert"该对象并不是圆请重新选取圆")
		);end if
		(setq en(entsel "\n选择下一个想作内切正多边形的圆:"))
	  )
	(princ(strcat"\n共绘制了"(itoa i)"圆内切正多边形"))
	(prin1)
  )
(prompt"\n<<7TEST3>连续对多个圆绘制内切正多边形")
(prin1)

(defun c:9test2()
	(sub_chk_layer)
	(sub_chk_style)
	;;;以上可设置好在往后程序中，所需求的图层与字体
	;;以下再搭配其他主程序	  
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
	(prompt"\n图层STR，TXT，HAT，DIM，CEN，HID创建OK!")
  )

(defun sub_chk_style()
	(setq chksty (tblsearch "style" "CC"))
	(if(= chksty nil)
		(command "style""CC" "txt,chineset" "" "" "" "" "" "")
	  )
	(setq chksty (tblsearch "style" "kk"))
	(if (= chksty nil)
		(command "style" "kk" "楷体" "" "" "" "" "")
	  )
	(prompt"\n字体CC与kk创建OK!")
  )

(defun c:10test()
	(setq data list '())
	;以下文件由用户选取
	(setq dat_file(getfiled"展点范例""C:\\LSPTOOLS\\10test1""dat"2))
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
(prompt "<10TEST2>>自动展点列表技巧程序")
(prin1)