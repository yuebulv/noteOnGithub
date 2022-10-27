import pandas as pd
from pandas import DataFrame
import os


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
    # 查询
    newDf: DataFrame.loc  # 即能查询又可以覆盖，推荐
    newDf.iloc
    newDf: DataFrame.where
    newDf: DataFrame.query()


if __name__ == "__main__":
    note_1()