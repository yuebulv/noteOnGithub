# python中有三种方法，实例方法、静态方法(staticmethod) 和 类方法(classmethod)
"""
静态方法类似普通函数，参数里面不用传递 self。有一些方法和类相关，但是又不需要类中的任何信息，出于对代码的理解和维护，就可用使用静态方法。
静态方法最大的优点是能节省开销，因为它不会绑定到实例对象上，它在内存中只生成一个。而实例方法每个实例对象都是独立的，开销较大
而类方法与实例方法类似，但是类方法传递的不是实例，而是类本身。当需要和类交互而不需要和实例交互时，就可以选择类方法。
总结
1.静态方法和类方法都可以通过类直接调用，也可以实例化后再调用
2.类方法的第一个参数是 cls，可以调用类的属性和方法，而静态方法不用传递参数，也不能调用类属性
3.如果一个方法没有使用到类本身任何变量，可以直接使用静态方法。静态方法放到类外边也不影响，主要是放在类里面给它一个作用域，方便管理
"""
# 类
class Person(object):
    def __init__(self, name, age):
        self.name = name
        self.age = age
        print('self:', self)

    # 定义一个build方法，返回一个person实例对象，这个方法等价于Person()。
    @classmethod
    def build(cls):
        # cls()等于Person()
        p = cls("Tom", 18)
        print('cls:', cls)
        return p


if __name__ == '__main__':
    person = Person.build()
    print(person, person.name, person.age)