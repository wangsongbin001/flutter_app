import 'dart_study02.dart';

void main() {
  /****************变量****************/
  print("hello world");
  //dart 所有的类型都是对象, i,j 默认值都是null;
  int i;
  String j;
  print(i);
  print(j);
  // var 申明变量；赋值那一刻确定变量类型，赋值后不能修改类型。
  var a = "hello world";
  print(a);
  // 类似Object, 再不能确定类型的情况下使用。
  dynamic b = "";
  b = 1;
  //final 运行时常量，与java一致； const，编译时常量，效率更高
  final aa = "";
  const bb = 1;

  /****************内置类型（七种）****************/
  //num 数值类型 int(整型 between -2^53 and 2^53)可以当成long来用； double（浮点型）
  int c = 1;
  //bitLength返回所占用的字节
  print(c.bitLength);
  c = 2;
  print(c.bitLength);
  c = 7;
  print(c.bitLength);
  double cc = 1.1;

  //String 字符串, 比Java更方便，
  String d = "我要去大保健";
  int dd = 11;
  String ddd = "${d}我要找${dd}号技师";
  print(ddd);
  //'' ""都可以。
  print(' "你好" "之华" ');
  //"""""" 三引号，支持换行字符串
  print("""hello world!
   hello world !
   hello world !
   hello world !""");
  //String.length(); utf16编码下，代码单元的个数。
  print(ddd.length);

  //bool 布尔类型；基本等同于Boolean；不同点：默认值依然是null;
  bool dddd = false;
  print(dddd);

  //List 数组列表, 遍历模版iter
  List<int> nums = [1, 2, 3, 4, 5];
  for (var e in nums) {
    print(e);
  }

  //Map 映射集合
  Map<String, int> maps = {"1": 1, "2": 2, "3": 3};
  for (var key in maps.keys) {
    print("$key ${maps[key]}");
  }

  //Runes 用来表示特殊字符 unicode;
  Runes runes = new Runes("\u{ffff1}");
  print(runes);

  //Symbols, 可以把它当成常量，可以用来switch
  var f = #aa;
  switch (f) {
    case #aa:
      print(f);
      break;
    case #bb:
      break;
  }

  /****************操作符****************/
  //as 类型强转
  num g = 1;
  int gg = g as int;
  print(gg.runtimeType);
  //is 判断继承关系 等同Java instanceof
  print(gg is int);
  print(gg is num);
  //is! 非is
  print(gg is! num);

  //安全操作符 ??= 当被赋值对象为空时赋值
  String h;
  h ??= "123";
  h ??= "abc";
  print(h);
  // ?? 条件判断(??为null，执行后面操作)
  h = null;
  h = h ?? "123";
  print(h);
  //？. 安全操作，防止抛异常; print(h.length);
  h = null;
  print(h?.length);

  //级联操作符..  方法返回类对象。
  new Builder()
    ..a()
    ..b();
  print(new Builder()..a().runtimeType);

  /****************方法****************/
  //方法也是对象,Function
  hello(String name) {
    print("hello ${name}!");
  }

  hello("world");
  //方法作为参数,用Function会比较模糊，无法编译期检查错误。推荐使用typedef定义参数类型
  void post(saysome f) {
    f("小明");
  }

  post(hello);
  //可选位置参数,可以传任意个数参数(<= 定义的参数)。用中括号包裹【】
  void add([int i = 0, int j = 0]) {
    print(i + j);
  }

  add();
  add(1);
  add(1, 2);
  //可选命名参数，可以传任意key对 应的参数，使用{}
  void show({String a = "", String b = ""}) {
    print('$a$b');
  }

  show(a: "我是A");
  show(b: "我是B");
  show(a: "我是A", b: "我是B");
  //匿名方法，类似与grovy中的闭包
  var k = () {
    print("匿名方法");
  };
  void post1(k) {
    k();
  }

  ;
  post1(k);

  /****************异常****************/
  //java是强制异常处理的语言；dart不是;异常有两种Exception， Error;
  //finally与java一样；
  //针对不同异常对不同的处理使用on,针对任何对象都可以。
  testException() {
//    throw "我是String";
    throw new Exception("dart except");
  }

  try {
    testException();
  } on String catch (e) {
    print(e);
  } on Exception catch (e, s) {
    //可以有两个参数，一个是异常，一个是调用栈信息
    print(e);
    print(s);
  } finally {
    print("finally");
  }

  /****************测试私有属性****************/
  Point point = new Point(1, 2);
//  point._z;
//  point._zzz();

  Point3 point3 = new Point3.x(5);
  point3.x = 10;
  print(point3.x);
}

typedef saysome(String str);

class Builder {
  String a() {
    print("a");
    return "abc";
  }

  b() {
    print("b");
  }
}

void test(dynamic a) {}
