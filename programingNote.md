# Linux

## 命令

sudo su root权限

mv ./需要移动的文件或文件夹 目标地址

rm -r ./要删除的文件或文件夹

find 需要清空的文件夹 -type f -delete

## Python 相关


> ```bash
> wget https://www.python.org/ftp/python/3.8/Python-3.8.tgz
> tar -zxvf Python-3.5.3.tgz
> mv Python-3.5.3 /usr/local
> 删除旧版本的python依赖
> ll /usr/bin | grep python
> rm -rf /usr/bin/python
> cd /usr/local/Python-3.5.3/
> 配置
> ./configure
> 编译 make
> make
> 编译，安装
> make install
> 删除旧的软链接，创建新的软链接到最新的python
> rm -rf /usr/bin/python
> ln -s /usr/local/bin/python3.5 /usr/bin/python
> echo $PATH
> pwd
> 配置环境变量
> vim /etc/profile
> source /etc/profile
> python -V
> ```

要**停止python脚本**，只需按 Ctrl + C

```bash
ps aux|grep python
```

linux中文都是乱码

```bash
yum groupinstall "fonts"
```

[nohup和&后台运行，进程查看及终止](https://www.cnblogs.com/baby123/p/6477429.html)

`nohup ./OPQBot &`

## Linux各目录作用



<img src="C:\Users\Administrator.DESKTOP-95R7ULF\AppData\Roaming\Typora\typora-user-images\image-20211124132338933.png" alt="image-20211124132338933" style="zoom:50%;" />

etc lib var usr boot 目录需要备份

## 命令

<img src="C:\Users\Administrator.DESKTOP-95R7ULF\AppData\Roaming\Typora\typora-user-images\image-20211124135149440.png" alt="image-20211124135149440" style="zoom:50%;" />

<img src="C:\Users\Administrator.DESKTOP-95R7ULF\AppData\Roaming\Typora\typora-user-images\image-20211124135242570.png" alt="image-20211124135242570" style="zoom: 50%;" />

<img src="C:\Users\Administrator.DESKTOP-95R7ULF\AppData\Roaming\Typora\typora-user-images\image-20211124140201470.png" alt="image-20211124140201470" style="zoom:50%;" />

>  mkdir [-p] 

> > -p 递归创建目录（可以创建不存在的目录下的目录）

> pwd

> > 显示当前目录

<img src="C:\Users\Administrator.DESKTOP-95R7ULF\AppData\Roaming\Typora\typora-user-images\image-20211124141615357.png" alt="image-20211124141615357" style="zoom:50%;" />

可以同时复制多个文件

复制的时候也可以更名

# python

## python

#### 方法与属性

调用方法 fuction_a()

调用属性 a.attribute

#### 静态、动态、类方法

## pandas

### DataFrame

1. #### DataFrame.loc[argument_1,argument_2 =""]

   1. argument_1:行索引；可以是lable,list,boolean,series; 
   2. argument_2:列索引（可省略）

### 文本数据

<details>
	<summary>str</summary>
    str对象是定义在`Index`或`Series`上的属性
    s = pd.Series([{1: 'temp_1', 2: 'temp_2'}, ['a', 'b'], 0.5, 'my_string'])
    s.str[1]
        0    temp_1
        1         b
        2       NaN
        3         y
        dtype: object
    s.astype('string').str[1]
        0    1
        1    '
        2    .
        3    y
        dtype: string


#### split:文本拆分

<details>
	<summary>split</summary>
    s = pd.Series(['上海市黄浦区方浜中路249号', '上海市宝山区密山路5号'])
    s.str.split('[市区路]')
        0    [上海, 黄浦, 方浜中, 249号]
        1       [上海, 宝山, 密山, 5号]
        dtype: object
    s.str.split('[市区路]', n=2, expand=True)
        0	1	2
        0	上海	黄浦	方浜中路249号
        1	上海	宝山	密山路5号
#### join/cat:合并

<details>
    <summary>str.join</summary>
    s = pd.Series([['a','b'], [1, 'a'], [['a', 'b'], 'c']])
s.str.join('-')
    0    a-b
    1    NaN
    2    NaN
    dtype: object
s1 = pd.Series(['a','b'])
s2 = pd.Series(['cat','dog'])
s1.str.cat(s2,sep='-')
    0    a-cat
    1    b-dog
    dtype: object
s2.index = [1, 2]
s1.str.cat(s2, sep='-', na_rep='?', join='outer')
    0      a-?
    1    b-cat
    2    ?-dog
    dtype: object

#### contains:匹配

<details>
    <summary>str.contains</summary>
    返回了每个字符串是否包含正则模式的布尔序列：
    s = pd.Series(['my cat', 'he is fat', 'railway station'])
	s.str.contains('\s\wat')
        0     True
        1     True
        2    False
        dtype: bool
    <summary>str.startswith</summary>
    <p>--str.startswith和str.endswith返回了每个字符串以给定模式为开始和结束的布尔序列，它们都不支持正则表达式：
    s.str.startswith('my')
        0     True
        1    False
        2    False
        dtype: bool
    <summary>str.match</summary>
    # 如果需要用正则表达式来检测开始或结束字符串的模式，可以使用str.match，其返回了每个字符串起始处是否符合给定正则模式的布尔序列：
    s.str.match('m|h')
        0     True
        1     True
        2    False
        dtype: bool
	<summary>str.find</summary>
	<p>即str.find与str.rfind，其分别返回从左到右和从右到左第一次匹配的位置的索引，未找到则返回-1。需要注意的是这两个函数不支持正则匹配，只能用于字符子串的匹配：        

#### replace替换

<details>
    <sumary>str.replace</sumary>
    <p>
    s = pd.Series(['a_1_b','c_?'])
	s.str.replace('\d|\?', 'new', regex=True)
        0    a_new_b
        1      c_new
        dtype: object
        当需要对不同部分进行有差别的替换时，可以利用子组的方法，并且此时可以通过传入自定义的替换函数来分别进行处理，注意group(k)代表匹配到的第k个子组（圆括号之间的内容）：
        s = pd.Series(['上海市黄浦区方浜中路249号',
        '上海市宝山区密山路5号',
        '北京市昌平区北农路2号'])
        pat = '(\w+市)(\w+区)(\w+路)(\d+号)'
        city = {'上海市': 'Shanghai', '北京市': 'Beijing'}
        district = {'昌平区': 'CP District',
        '黄浦区': 'HP District',
        '宝山区': 'BS District'}
        road = {'方浜中路': 'Mid Fangbin Road',
        '密山路': 'Mishan Road',
        '北农路': 'Beinong Road'}
        def my_func(m):
            str_city = city[m.group(1)]
            str_district = district[m.group(2)]
            str_road = road[m.group(3)]
            str_no = 'No. ' + m.group(4)[:-1]
            return ' '.join([str_city,
                        str_district,
                        str_road,
                        str_no])
        s.str.replace(pat, my_func, regex=True)
            0    Shanghai HP District Mid Fangbin Road No. 249
            1           Shanghai BS District Mishan Road No. 5
            2           Beijing CP District Beinong Road No. 2
            dtype: object
    	这里的数字标识并不直观，可以使用命名子组更加清晰地写出子组代表的含义： 
        pat = '(?P<市名>\w+市)(?P<区名>\w+区)(?P<路名>\w+路)(?P<编号>\d+号)'
        def my_func(m):
            str_city = city[m.group('市名')]
            str_district = district[m.group('区名')]
            str_road = road[m.group('路名')]
            str_no = 'No. ' + m.group('编号')[:-1]
            return ' '.join([str_city,
                        str_district,
                        str_road,
                        str_no])
        s.str.replace(pat, my_func, regex=True)

#### extract提取

<details>
    <summary>str.extract</summary>
    s = pd.Series(['上海市黄浦区方浜中路249号',
                '上海市宝山区密山路5号',
                '北京市昌平区北农路2号'])
    pat = '(\w+市)(\w+区)(\w+路)(\d+号)'
	s.str.extract(pat)
    		0		1		2		3
        0	上海市	黄浦区	方浜中路	249号
        1	上海市	宝山区	密山路	5号
        2	北京市	昌平区	北农路	2号
    通过子组的命名，可以直接对新生成DataFrame的列命名：
    pat = '(?P<市名>\w+市)(?P<区名>\w+区)(?P<路名>\w+路)(?P<编号>\d+号)'
    s.str.extract(pat)
            市名	区名	路名	编号
        0	上海市	黄浦区	方浜中路	249号
        1	上海市	宝山区	密山路	5号
        2	北京市	昌平区	北农路	2号
    str.extractall不同于str.extract只匹配一次，它会把所有符合条件的模式全部匹配出来，如果存在多个结果，则以多级索引的方式存储：
    s = pd.Series(['A135T15,A26S5','B674S2,B25T6'], index = ['my_A','my_B'])
    pat = '[A|B](\d+)[T|S](\d+)'
    s.str.extractall(pat)
                    0	1
            match		
        my_A	0	135	15
                1	26	5
        my_B	0	674	2
                1	25	6
    str.findall的功能类似于str.extractall，区别在于前者把结果存入列表中，而后者处理为多级索引，每个行只对应一组匹配，而不是把所有匹配组合构成列表。
</details>

#### 常用字符串函数

<details>
    <summary>字母型函数</summary>
    `upper, lower, title, capitalize, swapcase`这五个函数主要用于字母的大小写转化，从下面的例子中就容易领会其功能：
    s = pd.Series(['lower', 'CAPITALS', 'this is a sentence', 'SwApCaSe'])
    s.str.title()
    	0                 Lower
        1              Capitals
        2    This Is A Sentence
        3              Swapcase
        dtype: object
    s.str.capitalize()
        0                 Lower
        1              Capitals
        2    This is a sentence
        3              Swapcase
        dtype: object
    s.str.swapcase()
        0                 LOWER
        1              capitals
        2    THIS IS A SENTENCE
        3              sWaPcAsE
        dtype: object
</details>

<details>
    <summary>数值型函数</summary>
    这里着重需要介绍的是pd.to_numeric方法，它虽然不是str对象上的方法，但是能够对字符格式的数值进行快速转换和筛选。其主要参数包括errors和downcast分别代表了非数值的处理模式和转换类型。其中，对于不能转换为数值的有三种errors选项，raise, coerce, ignore分别表示直接报错、设为缺失以及保持原来的字符串。
    s = pd.Series(['1', '2.2', '2e', '??', '-2.1', '0'])
	pd.to_numeric(s, errors='ignore')
        0       1
        1     2.2
        2      2e
        3      ??
        4    -2.1
        5       0
        dtype: object    
    pd.to_numeric(s, errors='coerce')
        0    1.0
        1    2.2
        2    NaN
        3    NaN
        4   -2.1
        5    0.0
        dtype: float64
    在数据清洗时，可以利用coerce的设定，快速查看非数值型的行：
    s[pd.to_numeric(s, errors='coerce').isna()]
        2    2e
        3    ??
        dtype: object
</details>

<details>
    <summary>统计型函数</summary>
    count和len的作用分别是返回出现正则模式的次数和字符串的长度：
    s = pd.Series(['cat rat fat at', 'get feed sheet heat'])
	s.str.count('[r|f]at|ee')
        0    2
        1    2
        dtype: int64
    s.str.len()
        0    14
        1    19
        dtype: int64
</details>

<details>
    <summary>格式型函数</summary>
    格式型函数主要分为两类，第一种是除空型，第二种是填充型。其中，第一类函数一共有三种，它们分别是strip, rstrip, lstrip，分别代表去除两侧空格、右侧空格和左侧空格。这些函数在数据清洗时是有用的，特别是列名含有非法空格的时候。
    my_index = pd.Index([' col1', 'col2 ', ' col3 '])
	my_index.str.strip().str.len()
    	Int64Index([4, 4, 4], dtype='int64')
    对于填充型函数而言，pad是最灵活的，它可以选定字符串长度、填充的方向和填充内容：
    s = pd.Series(['a','b','c'])
	s.str.pad(5,'left','*')
        0    ****a
        1    ****b
        2    ****c
        dtype: object
    s.str.pad(5,'both','*')
        0    **a**
        1    **b**
        2    **c**
        dtype: object
    上述的三种情况可以分别用rjust, ljust, center来等效完成，需要注意ljust是指右侧填充而不是左侧填充：
    	s.str.rjust(5, '*')
    在读取excel文件时，经常会出现数字前补0的需求，例如证券代码读入的时候会把"000007"作为数值7来处理，pandas中除了可以使用上面的左侧填充函数进行操作之外，还可用zfill来实现。
	s = pd.Series([7, 155, 303000]).astype('string')
	s.str.pad(6,'left','0')
        0    000007
        1    000155
        2    303000
        dtype: string
    s.str.zfill(6)
        0    000007
        1    000155
        2    303000
        dtype: string
</details>



## 文档

- https://docs.python.org/zh-cn/3.11/


> pyinstaller -F app.py

## xpath

```python
from lxml import etree

response = request.get(url=url, headers=headers)
response.encoding = 'utf-8' # 如果有乱码可以用这句,如果不管用可用下面代码
name = name.encode('iso-8859-1').decode('gbk') # 通用处理中文乱码的解决方案
page_text = response.text

# htmlPath为文件路径时用下面语法
parser = etree.HTMLParser(encoding='utf-8')
tree = etree.parse(htmlPath, parser=parser) 
# htmlText为网页文本时用下面语法
tree = etree.HTML(htmlText)

htmlAnalysis_question_list = tree.xpath("/html/body/div//h1/span/text()") # div// 表示div下所有节点
htmlAnalysis_options_list = tree.xpath("/html/body/div//ul[@id='ul_answers']/label/text()") # label下的文本
htmlAnalysis_questionUrl_list = tree.xpath("/html/body/header//div[@class='div3']//a/@href") # 获取href属性值
tree.xpath('//div[@class="slist"]/li') # //也可以用在头部  ./可表示当前节点

# 下载图片
img_data = requests.get(url=img_src, headers=headers).content
img_path ='picLibs/' + img_name
with open(img_path, 'wb') as fp:
    fp.write(img_data)
    

```

## Json

<img src="C:\Users\Administrator.DESKTOP-95R7ULF\AppData\Roaming\Typora\typora-user-images\image-20211126190856028.png" alt="image-20211126190856028" style="zoom:50%;" /><img src="C:\Users\Administrator.DESKTOP-95R7ULF\AppData\Roaming\Typora\typora-user-images\image-20211126191001993.png" alt="image-20211126191001993" style="zoom:50%;" />![image-20211126192503384](C:\Users\Administrator.DESKTOP-95R7ULF\AppData\Roaming\Typora\typora-user-images\image-20211126192503384.png)

## spider

### 乱码问题

```python
pip install -i https://pypi.tuna.tsinghua.edu.cn/simple some-package
```

## [从包中导入所有模块](https://www.codenong.com/23091581/)

## 函数

- 如果一个函数的参数中含有默认参数，则这个默认参数后的所有参数都必须是默认参数，否则会报错

## 解包

- https://zhuanlan.zhihu.com/p/33896402

## re

1. re.split('regx', 'str') # 方法按匹配的子串将字符串分割后返回列表

# xlwings

## 安装

- python中安装：pip install xlwings
- excel里安装加载项，cmd命令行输入：xlwings addin install

## 教程

1. https://zhuanlan.zhihu.com/p/120415076，xlwings库解析

# vba

## 教程

1. https://www.yiibai.com/vba/vba_error_handling.html易百教程

## 函数

### 关于function函数不能为其它单元格赋值解决方法

1. 写个空function
2. 工作表change事件中判断公式类型，然后调用赋值函数

### 怎样给自定义函数添加参数说明

- https://www.zhihu.com/question/487116972

# Git

## FAQ

1. Git 中文乱码

```shell
$ git config --global core.quotepath false  		# 显示 status 编码
$ git config --global gui.encoding utf-8			# 图形界面编码
$ git config --global i18n.commit.encoding utf-8	# 提交信息编码
$ git config --global i18n.logoutputencoding utf-8	# 输出 log 编码
$ export LESSCHARSET=utf-8 (windows下为：set LESSCHARSET=utf-8)
# 最后一条命令是因为 git log 默认使用 less 分页，所以需要 bash 对 less 命令进行 utf-8 编码
```

2. ```console
   $ git rm --cached README 只删除暂存区文件，保留磁盘中文件
   $ gim commit --amend '用这一次注释覆盖上次提交的注释'
   ```

   

## 冲突
