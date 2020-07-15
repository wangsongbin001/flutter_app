/****************class 类****************/
//1，类似java类也是class关键字申明, 并且所有的类都默认继承Object。
class Point{
  int x;
  int y;
  int _z;

  //2，类的构造方法也不能重载，如果没有自定构造函数，默认无参构造函数Point()
  Point(this.x, this.y);
  //3，命名构造函数，确定有定义多个构造函数的需求；
  Point.y(this.y);
  //4，通过在前面加_；定义私有属性；
  Point.z(this._z);
  _print1(){
    print("Point x=${this.x},y=${this.y},_z=$_z");
  }
  //5，初始化列表，命名构造方法的一种, 这样写无法对map做非空判断。个人喜欢后面接{}
  Point.fromMap(Map map):this.x = map["x"], this.y = map['y'];
  //6，构造方法的重定向，类似java中的this;但是dart中重定向是没有代码的；不能{this(x, y)}
  Point.xy(int x, int y):this(x, y);
}

//7，如果你要提供一个不变的对象；可以定义成常量对象；
class ConstPoint{
  final int x;
  final int y;
  const ConstPoint(this.x, this.y);
}

//8，工厂构造函数，与static 实现单例模式类似。
class Point2{
  static Point2 _instance;

  factory Point2.getInstance(){
    if(_instance == null){
      _instance = Point2._inner();
    }
    return _instance;
  }

  Point2._inner();
}

//9 setter, getter 方法,非私有的，非final的变量默认都实现了get,set方法; 如下为私有变量实现get,set方法
class Point3{
  int _x;
  int _y;

  Point3(this._x, this._y);

  Point3.x(this._x);

  set x(int _x) => this._x = _x;
  int get x{//x后面没接括号
    return this._x;
  }

  //10，重载操作符使用operator 加操作符
  Point3 operator +(Point3 point3){
     int x = this._x + point3._x;
     return Point3.x(x);
  }
}

//11，抽象类。
abstract class AbsObject{
  void absMethod();//不用写abstract
}

//12，dart里没有interface，每一个class都可以是interface;除了abstract类，
// 都可以被implement, 而且必须实现所有的方法。
class NormalObject{
  void hello(){
  }

  void doAction(){
  }
}

class Normal extends AbsObject implements NormalObject{

  @override
  void absMethod() {
    // TODO: implement absMethod
    print("absMethod run in Normal");
  }

  @override
  void hello() {
    // TODO: implement hello
    print("hello run in Normal");
  }

  @override
  void doAction() {
    // TODO: implement doAction
    print("doAction run in Normal");
  }
}

//13，mixins(混入)，with关键字，帮助我们实现了，类似多继承功能；被混入的类不能自定义构造方法。
// 如下C中即能使用A中的方法，又能使用B中的方法；
// 如果A,B中方法有ab，则实际调用为with位置到后的类中的方法；如果方法名相同参数不同，则无法同时被混入with；
class A{
  void a(){
    print("method a run");
  }

  void ab(){
    print("method ab run in a");
  }
}
class B{
  void b(){
    print("method b run");
  }

  void ab(){
    print("method ab run in b");
  }
//  void ab(String str){
//    print("method ab run in b $str");
//  }
}
class C with A,B{
  void c(){
    print("method c run");
  }
}
//语法糖果
class CC = Object with A,B;

void main(){
  //默认会有无参数的构造方法,new 关键字可以省略；
  Point point = new Point(1, 2);
  print("${point.x}  ${point.y}");
  //命名构造函数,
  point = Point.y(3);
  print("${point.x}  ${point.y}");
  //私有属性,因为同一个文件中所以可以调用；
  print(point._z);
  point._print1();
  //初始化列表
  point = Point.fromMap({'x':3, 'y':4});
  print("${point.x}  ${point.y}");
  //常量构造函数, cp1与cp2使用同一个内存空间。
  ConstPoint cp1 = const ConstPoint(1, 2);
  ConstPoint cp2 = const ConstPoint(1, 2);
  ConstPoint cp3 = const ConstPoint(2, 3);
  print(cp1 == cp2);
  print(cp1 == cp3);
  //工厂构造方法
  Point2 point2 = Point2.getInstance();
  print(point2);
  //重载操作符
  Point3 p31 = new Point3(10, 2);
  Point3 p32 = new Point3(20, 3);
  Point3 p3 = p31 + p32;
  print(p3.x);
  //abstract 抽象类, dart不支持匿名函数，直接实现接口
  AbsObject absObject = new Normal();
  absObject.absMethod();
  NormalObject normalObject = new Normal();
  normalObject.hello();
  normalObject.doAction();
  //mixins混入；
  C c = new C();
  c.a();
  c.b();
  c.c();
  c.ab();
  //homework：
  Fraction fraction = new Fraction(3, -8);
  print(fraction.value());
  Fraction fadd = fraction + new Fraction(1, 2);
  print(fadd.value());
  Fraction fmultiply = fraction * new Fraction(1, 2);
  print(fmultiply.value());
  Fraction fdivision = fraction / new Fraction(1, 2);
  print(fdivision.value());

}

class Fraction{
  //分子
  int num1;
  //分母
  int num2;

  Fraction(this.num1, this.num2);

  String value(){
    double value = num1/num2;
    int n = getNum1(num1.abs(), num2.abs());
    num1 = num1~/n;
    num2 = num2~/n;
    if(value > 0) {
      return "${num1.abs()}/${num2.abs()}";
    }else{
      return "-${num1.abs()}/${num2.abs()}";
    }
  }

  operator +(Fraction other){
    int num1 = this.num1 * other.num2 + this.num2 * other.num1;
    int num2 = this.num2 * other.num2;
    return new Fraction(num1, num2);
  }

  operator *(Fraction other){
    int num1 = this.num1 * other.num1;
    int num2 = this.num2 * other.num2;
    return new Fraction(num1, num2);
  }

  operator /(Fraction other){
    int num1 = this.num1 * other.num2;
    int num2 = this.num2 * other.num1;
    int n = getNum1(num1, num2);
    return new Fraction(num1 ~/n, num2 ~/n);
  }

  //求最大公约数
  int getNum1(int num1, int num2){
    int big = num1 > num2 ? num1 : num2;
    int small = num1 > num2 ? num2 : num1;
    int temp = big%small;
    while(temp != 0){
      big = small;
      small = temp;
      temp = big % small;
    }
    return small;
  }

  //求最小公倍数:相乘除以最大公约数；
  int getNum2(int num1, int num2){
    return num1 * num2 ~/ getNum1(num1, num2);
  }
}

