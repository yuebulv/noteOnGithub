import pandas as pd
from pandas import DataFrame, Series
import matplotlib.pyplot as plt
import os


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


if __name__ == "__main__":
    note_1()