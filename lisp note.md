# vlisual lisp

## 书籍

教材1[E:\Z-StudyMaterials\lisp资料\猫老师Lisp入门教程（第一版）0811.pdf.pdf](E:\Z-StudyMaterials\lisp资料\猫老师Lisp入门教程（第一版）0811.pdf.pdf)

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
  - c d 是区域性参数，函数运行完销毁

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

## 技巧

双击(  会标示）

nil 与 “” 有时候不相同，没有输入的时候为""

## 注意事项

字符串比较时，大小写不同

## 问题

print  “str” 会和回车引号一起输出

princ “str” 会输出str

prin1

