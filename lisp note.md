# vlisual lisp

## 书籍

[AUTOCAD完全应用指南高清版(吴永进魔法书新书).pdf](E:\Z-StudyMaterials\lisp资料\AUTOCAD完全应用指南高清版(吴永进魔法书新书).pdf)

教材1[E:\Z-StudyMaterials\lisp资料\AUTOCAD完全应用指南高清版(吴永进魔法书新书).pdf](E:\Z-StudyMaterials\lisp资料\AUTOCAD完全应用指南高清版(吴永进魔法书新书).pdf)

教材2[E:\Z-StudyMaterials\lisp资料\Visual LISP开发者宝典.pdf](E:\Z-StudyMaterials\lisp资料\Visual LISP开发者宝典.pdf)



## 语法

- setq 给一个变量赋值

- list建立一段数据集合

- command 调用命令行

- getpoint 让用户选择一个点

- defun 表示我们开始编写一段函数，因为需要在系统里面注册命令，所以命令的格式为 C:后面跟你定义的命令。这段代码的执行命令就是 TT

```lisp
(defun c:tt()
    (setq 点1 (getpoint "\n请选择第一个点”))
    (setq 点2 (getpoint "\n请选择第二个点"))
    (command "line" 点1 点2 "")
)
```

- EntLast 获取上一个图元， (setq 刚才画的线 (entlast))

- car 取出表中第一个值用 CAR 函数

- entsel 选择一个图元

- 对象名：除了图元名还有个对象名，这是 vlisp 里面新的称呼，我们用这个代码来把图元转为对象名。
  seta 选择的对象 (vlax-Ename->Vla-0bject 选择的图元)
  或者:
  (seta 选择的对象 (Vlax-Ename->Vla-0bject (car (entsel)))
- V-Load-Com 函数用于加载 vla 开头的函数,在每个程序的开头加一句即可,不用每句话都加,后面的代码我们都认为程序已经先写了这个函数.
  旧版的 CAD,有些没有加载这个函数,会造成一些函数无法找到

## 函数

- defun c: function(a b / c d) # 加c:命令行中调用function
  - 在使用 (defun C:函数名(自变量/更改变量)···)的中，变量在“/”右边变量内，则称为局部变量，否则为全局变量(注:在 AutoLISP 中，未赋予值的变量，其返回值皆为 ni)。
    局部变量:在程序执行完毕后，其值自动消失
    全局变量:在程序执行完毕后，其值仍然存在。

defun function  # 不加c:，命令行中调用（function）



- 获取对象起点

		使用对象名处理的方法：
		(Vlax-Get (Vlax-Ename->Vla-0bject (car (entsel)))'StartPoint)
		使用图元名处理的方法：
		(cdr (assoc 10 (entget (car entsel))

- 获取图层名

```lisp
(vl-load-com)
(defun C:SHOWLAYER (/ ent)
  (while (setq ent
		(entsel)
	 )
    (princ
      (strcat "\nLayer:"
	      (vla-get-Layer
		(vlax-ename->vla-object (car ent))
	      )
      )
    )
  )
  (princ)
)
```

getpoint

getdist

(setvar "cmdecho" 0)  命令栏中不显示回显

setvar "osmode" 0 关闭对象捕捉

polar 返回一个点

### 流程控制

if

progn

cond 会根据判断结果匹配条件，[第7集AutoLisp流程控制函数1_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1kb411V7K8?p=7&spm_id_from=pageDriver&vd_source=71766beb4ab755e8dfb4543e1008fa76)

repeat

while

图元

entsel

entnext

entlast

entget

### 对象属性相关函数

- 2.1 (entsel[提示]) 请求选择一个对象，返回包含对象名称及选点坐标的列表
- 2.2 (car列表) 返回列表中的第一个元素 (通常用来求x坐标)
- 2.3 (cadr列表) 返回列表中的第二个元素 (通常用来求y坐标)
- 2.4 (caddr列表) 返回列表中的第三个元素 (通常用来求z坐标)
- 2.5 (cdr列表) 返回除去第一个元素后的列表
- 2.6 (entlast) 取出图形对象中的最后一个属性
- 2.7 (entget 称[应用序列表])   取得对象名称的属性联合列表
- 2.8 (assoc关键元素联合列表) 按关键元素寻找联合列表中的关系属性
- 2.9 (cons新素列表)  返回:将新元素结合到列表 (常用于产生“点对列表”
- 2.10 (subst新项项列表) 返回:替换旧列表后的列表
- 2.11 (entmod对列) 按更新的属性列表更新屏幕上的对象
- 2.12  (list 元素元素···) 返回:将元素合并成一列表







## 规则技巧

双击(  会标示）

nil 与 “” 有时候不相同，没有输入的时候为""

- (setq pt3 '(11 123))    '(11 123)表示点列表，或者(setq pt3 (list 11 123))

- 副选项中，“”代表enter键

## 注意事项

字符串比较时，大小写不同

caipanshu  123qweasdZ

- !变量 用来查询变量

## 问题

print  “str” 会和回车引号一起输出

princ “str” 会输出str

prin1





- vlax-put,vlax-get和vlax-put-prpperty,vlax-get-prpperty区别

http://bbs.mjtd.com/thread-57637-1-1.html



python cad

pythoncom

win32com

您好。  我倒是觉得恰恰相反![img](http://bbs.mjtd.com/static/image/smiley/qq/em14.gif)，COM资料极其丰富

官方ActiveX API的详细文档，每个版本都更新发布，说明、实例极其详细，，。这些VBA实例都是COM的调用方法照抄就好，python与之完全相同，基本没任何差别。同理你用Java，swt.win32调用com也是一模一样的，，那个Java更加的方便无所不能。。

我认为com的优势就是：资料丰富，操作标准通用

目前 Py调用Lisp，我用的是com接口SendCommand方法；可能这是最土的办法，不知道还有啥其他办法；；
Lisp调用Py，我用 (command “shell” “d:\\xxx\\xxx\\xx.py") ; 这个有黑窗口，比较郁闷。。



我用的不是你这些方法，这几天我把用我的方法实现非模态对话框的效果弄好了，就放出来。
但是我的方法需要用py注册com server,这个在win10非常难搞。考虑的win10现在普及度这么高，可能也是个大问题。
另外com虽然便利，但功能相对.net来说其实弱鸡很多。
com里面也没法实现如lisp中grread的动态效果，使用事件会崩溃等。。
但是跟py结合的一大好处是可以利用py大量丰富的第三方库，



 https://help.autodesk.com/view/OARX/2023/ENU/

[[源码\]](http://bbs.mjtd.com/forum.php?mod=forumdisplay&fid=3&filter=typeid&typeid=28) **原创！Vlisp与Cpython无缝联合开发CAD** http://bbs.mjtd.com/thread-185424-1-1.html

有人Python开发Autocad吗？都是COM，好像很少讨论
http://bbs.mjtd.com/forum.php?mod=viewthread&tid=185262&fromuid=7319936
