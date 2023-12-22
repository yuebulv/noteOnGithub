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