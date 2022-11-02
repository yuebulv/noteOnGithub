import pandas as pd
from pandas import DataFrame, Series
import matplotlib.pyplot as plt
import os
import numpy as np


def notePandas(path):
    # DataFrame
    NewdataFrame = pd.read_excel(path, header=None, index_col="ID", skiprows=False, usecols=False, dtype=None)
    columnsIndes = NewdataFrame.columns
    setColumnsIndex = ["ID", 'Type']
    NewdataFrame.set_index("ID", inplace=True)  # "ID"设置为行索引
    newDF = NewdataFrame
    newSeries = columnsIndes
    newDF = newDF.append(newSeries, ignore_index=True)  # Series按行添加到df

    # series
    dic = {"a": 1, "b": 2}
    newSeries = pd.Series(dic)

    s1 = pd.Series([1, 2, 3], index=[1, 2, 3], name="A")
    s2 = pd.Series([1, 2, 3], index=[1, 2, 3], name="B")
    newDf = pd.DataFrame({s1.name: s1, s2.name: s2})  # 此时Series为行,且index对齐
    newDf = pd.DataFrame([s1, s2])  # 此时Series为列

    # value
    newDf["columnIndex"].at["index"] = "value"  # series改值
    newDf.at['index', 'column'] = "value"  # DataFrame改值
    newDf["column1"] = newDf["column2"] * newDf['column3']  # 列值相乘
    newDf["column1"] = newDf["column2"].apply(lambda x: x + 2)
    newDf["column1"] = newDf.column2.apply(lambda x: x + 2)
    newDf.columns = ["-".join(i) for i in newDf.values]  # 值拼接 修改列label

    # 数据类型
    newSeries = newSeries.astype(int)

    # 排序
    newDf.sort_values(by=["index1", "index2"], inplace=True, ascending=[True, False])

    # 筛选
    newDf = newDf.loc["Series"]

    # 画图
    newDf.plot.bar(x="index", y="columns", color="red", title="title", stacked=False)
    plt.show()
    ## 柱状图、柱状叠加图
    plt.bar(newDf.index, newDf.column, color="red")
    plt.xticks(newDf.index, rotation="90")
    plt.xlabel("xName")
    plt.ylabel("yName")
    plt.title("title", fontsize="10", fontweight="bold")
    plt.show()
    ## 折线图
    newDf.plot(x="index", y="columns")
    ## 散点图
    newDf.plot.scatter(x="index", y="columns")
    ## 直方图
    newDf.index.plot.hist()

    # 数据wvsr
    newDf.corr()  # 每两列的相关系数
    # excel
    pd.options.display.max_columns = 777
    newDf = pd.read_excel("path", sheet_name="sheetName")

    # 表格联合
    newDf: DataFrame = newDf.merge("newDf2", how="left", on="index").fillna(0)  # 类似于join

    # 分列
    splitDf = newDf["column"].str.split(n=0, expand=True)

    # 求和、平均
    newSeries = newDf.sum(axis=1)  # axis=1按行方向，0按列方向
    newSeries = newDf.mean(axis=1)  # 平均

    # 消除重复数据
    newDf.drop_duplicates(subset=["ID"], keep="last")
    # 判断是否是重复数据
    students = pd.read_excel('C:/Temp/Students Duplicates.xlsx')
    dupe = students.duplicated(subset='Name')
    dupe = dupe[dupe]
    print(students.iloc[dupe.index])

    # 数据透视
    import numpy as np
    newDf = newDf.pivot_table(index="index", columns="column", values="value", aggfunc=np.sum)
    df_group = newDf.groupby(["columns", "columns2"])

    # 数据追加
    newDf = newDf.append(newDf).reset_index(drop=True)
    newDf = newDf.append(newSeries, ignore_index=True)
    newDf = pd.concat([newDf, newDF], axis=0)
    # 插入数据
    part1 = newDf[:20]
    part2 = newDf[20:]
    newDf = part1.append(newSeries, ignore_index=True).append(part2).reset_index(drop=True)
    newDf.insert(1, column="column", value=np.repeat["value", len(newDf)])
    # 改数据
    newSeries = pd.Series({"id": 40, "column": "value"})
    newDf.iloc[40] = newSeries
    newDf.at["index", "column"] = 1
    newDf["column"] = 25
    newDf["column1"] = np.arange[0, len(newDf)]
    newDf.rename(columns={"column": "column"}, inplace=True)
    # 删除数据
    newDf.drop(index=[1, 2], inplace=True)
    newDf.drop(columns=[1, 2], inplace=True)
    newDf.dropna(inplace=True)


# map/apply/applymap
def note_1():
    """
    Pandas的数据转换函数map、apply、applymap
    1.map:只用于Series,实现每个值>值的映射：
    2.apply:用于Series?实现每个值的处理，用于Dataframe实现某个轴的Series的处理
    3.applymap:只能用于DataFrame,用于处理该DataFrame的每个元素；
    """
    dataPath = r"c:\data.xlsx"
    if os.path.exists(dataPath):
        newDf: DataFrame = pd.read_excel(dataPath)
        newDf.style.applymap("function", subset=["column", "column2"])
        demo = [".\picture\QQ图片20221025133527", ["https://zhuanlan.zhihu.com/p/100064394"]]

        ## map
        data = newDf
        # ①使用字典进行映射
        data["gender"] = data["gender"].map({"男": 1, "女": 0})

        # ②使用函数
        def gender_map(x):
            gender = 1 if x == "男" else 0
            return gender

        # 注意这里传入的是函数名，不带括号
        data["gender"] = data["gender"].map(gender_map)

        ## apply
        ### 与map的区别是,map的函数只能接收一个参数,apply可以接收多个
        def apply_age(x, bias):
            return x + bias

        # 以元组的方式传入额外的参数
        data["age"] = data["age"].apply(apply_age, args=(-3,))

        ## applymap
        ### 会对DataFrame中的每个单元格执行指定函数的操作
        data.applymap(lambda x: "%.2f" % x)


def note_2():
    dataPath = r"c:\data.xlsx"
    if os.path.exists(dataPath) is False:
        return f"{dataPath}文件不存在"
    newDf = pd.read_excel(dataPath)
    newSeries: Series
    # 查询
    newDf: DataFrame.loc  # 即能查询又可以覆盖，推荐
    def loc_note():
        print(newDf.loc[["index", "index2"], ["column"]])
        print(newDf.loc["index1":"index2", "column1":"column2"])
        print(newDf.loc[newDf["index"] < 10, :])
        print(newDf.loc["function", :])
    newDf.iloc
    newDf: DataFrame.where
    newDf: DataFrame.query()

    def 新增数据列():
        newDf.loc[:, "新增列"] = newSeries
        newDf.loc[:, "新增列"] = newDf.apply("function", axis=1)
        newDf[["column", "column1"]] = newDf.apply("function要返回元组两个数(column_value,column1_value)", axis=1, result_type="expand")
        print(newDf["column1"].value_counts())  # 分类计数
        newdf = newDf.assign("series1", "series2")

    def 数据统计():
        newDf.describe()  # 所有数字的统计结果，数量，最大，最小，平均，标准差等
        newSeries.mean()
        newSeries.max()
        newSeries.min()
        newSeries.unique()  # 去重
        newSeries.value_counts()  # 按值计数
        newDf.cov()  # 协方差矩阵
        newSeries.cov(newSeries)
        newDf.corr()  # 相关系数矩阵

    def 缺失值处理():
        newDf.isnull()
        newDf.notnull()
        newDf.dropna(axis=1, how="all", inplace=True)  # 删除全为空值的列行
        newDf.fillna({"column": "value"})
        newDf.loc[:, "column"] = newDf["column"].fillna("value")
        newDf.loc[:, "column"] = newDf["column"].fillna(method="ffill")  # 使用前一个不为空的值填充
        newDf.interpolate(method="linear")  # 线性插值

    def error_pandas():
        "settingWithCopyWarning报警"
        "pandas不允许先筛选子dataframe，再进行修改写入"
        "要么使用.loc实现一个步骤直接修改原dataframe"
        "要么复制一个dataframe，下一步再执行修改"
        pass

    def 排序():
        newSeries.sort_values()
        newDf.sort_values(by="column", ascending=False, inplace=True)
        newDf.sort_values(by=["column", "column2"], ascending=[False, True], inplace=True)

    def 字符串处理():
        # Series有str属性，dataframe没有，只能用在字符串上，不能用在数字上，不是python原生str，支持正则
        newSeries = newDf["column"].str.startswith("2018-03")  # 这里得到的newSeries全是布尔类型
        print(newDf["column"].str.replace("-", "").str[0:6].str.replace(",", ""))
        newDf["column"].str.replace("正则表达式", "")

    def axis_pandas():
        '''
        - axis = 0或者"index":
            ·如果是单行操作，就指的是某一行
            ·如果是聚合操作，指的是跨行cross
        rows.axis = 1或者"columns":
            ·如果是单列操作，就指的是某一列
            ·如果是聚合操作，指的是跨列cross columns
        按哪个axis，就是这个axis要动起来(类似被or遍历)，其它的axis保持不动
        '''
        newDf.mean(axis=0)  # 聚合操作的时候，结果输出的是每列的平均值，即表示为进行跨行聚合

    def index_pandas():
        """
        1.方便数据查询
        2.使用index会提升查询性能
        ·如果index是唯一的，Pandas会使用哈希表优化，查询性能为O(1);
        ·如果index不是唯一的，但是有序，Pandas会使用二分查找算法，查询性能为O(logN);
        ·如果index是完全随机的，那么每次查询都要扫描全表，查询性能为O(N);
        3.使用index能自动对齐数据
            如有Series相加，相同index的行会自动对齐相加
        4.更多的数据结构支持
        """
        newDf: DataFrame.index.is_monotonic_increasing  # 索引是否单调递增
        newDf: DataFrame.index.is_unique

    def merge_pandas():
        """
        merge 相当于sql的join，将不同的表按key关联到一张表
         2、理解merge时数量的对齐关系以下关系要正确理解:
            . one-to-one:一对一关系，关联的key都是唯一的
            .比如(学号，姓名) merge (学号，年龄)
            结果条数为:1*1
        . one-to-many:一对多关系，左边唯一key，右边不唯一key
            -比比如(学号，姓名) merge (学号，[语文成绩、数学成绩、英语成绩])·结果条数为:1*N
        . many-to-many:多对多关系，左边右边都不是唯一的
            比如(学号，[语文成绩、数学成绩、英语成绩]) merge (学号，[篮球、足球、乒乓球)·结果条数为:MN
        """
        newDf2: DataFrame
        pd.merge(newDf, newDf2)

    def concat_pandas():
        """
        使用场景:
            批量合并相同格式的Excel、给DataFrame添加行、I给DataFrame添加列
        一句话说明concat语法:
            ·使用某种合并方式(innerlouter)
            ·沿着某个轴向(axis=0/1)
            ·把多个Pandas对象(DataFramelSeries)合并成一个。
        concat语法: pandas.concat(objs, axis=0, join='outer, ignore_index=False)
            .objs: 一个列表，内容可以是DataFrame或者Series，可以混合
            .axis:默认是0代表按行合并，如果等于1代表按列合并
            .join:合并的时候索引的对齐方式，默认是outer join，也可以是inner join
            .ignore_index:是否忽略掉原来的数据索引
        append语法:DataFrame.append(other, ignore_index=False)
            append只有按行合并，没有按列合并，相当于concat按行的简写形式
            .other:单个dataframe、series、dict，或者列表
            .ignore_index:是否忽略掉原来的数据索引
        """
        newDf2: DataFrame
        pd.concat([newDf, newDf2, newSeries])
        pd.concat([pd.DataFrame([i], columns=["A"]) for i in range(5)], ignore_index=True)
        newDf.append(newDf2)
        newDf.append({"column": ["values"]}, ignore_index=True)

    def groupby_pandas():
        print(newDf.groupby("column").sum)
        print(newDf.groupby(["column", "column2"], as_index=False).mean)  # 列的分级索引
        print(newDf.groupby("column").agg([np.sum, np.mean]))  # 列的多种数据统计
        newDf.groupby("column").agg({"column1": np.sum, "column2": np.mean})

    def 分层索引():
        newSeries.unstack() # 把二级索引变成列索引
        newSeries.reset_index()  # 把多层索引变成列
        print(newSeries.loc[("multiindex1", "multiindex2")])
        newDf.set_index(["column", "column2"], inplace=True)  # 设置多层索引
        """
        DataFrame多层索引的筛选数据
        ·元组(key1,key2)代表筛选多层索引，其中key1是索引第一级，key2是第二级，比如key1=JD,key2=2019-10-02
        ·列表[key1,key2]代表同一层的多个KEY,其中key1和key2是并列的同级索引，比如key1=JD,key2=BIDU
        """

    def 数据透视():
        """stack/unstack/pivot
        教程：https://www.bilibili.com/video/BV1UJ411A7Fs/?p=20&spm_id_from=pageDriver&vd_source=71766beb4ab755e8dfb4543e1008fa76
        stack: DataFrame.stack(level=-1, dropna=Tmue), 将column变成index, 类似以把横放的书籍变成竖放
        level = -1代表多层索引的最内层，可以通过 == 0、1、2指定多层索引的对应层
        unstack:DataFrame.unstack(level=.1,fill_value=None),将index:变成column,类似把竖放的书籍变成横放
        pivot:DataFrame.pivot(index=:None,columns=None,values:=None),指定index、columns、.values实现二维透机
        """
        pass

def 数据清洗():
    newDf: DataFrame
    newSe: Series
    newSe = newDf.duplicated(keep=False)  # 判断是否为重复行
    newDf.drop_duplicates(keep="first", inplace=True)

def 索引():
    "显示、隐式索引"
    newDf: DataFrame
    newSe: Series
    print(newDf.iloc[0])  # iloc隐式索引、loc显示索引
    print(newDf["column"])  # 列索引
    print(newDf[0:2])  # 行索引
    print(newDf.iloc[:, 0:2])  # 列切片
    newDf.info


if __name__ == "__main__":
    note_1()