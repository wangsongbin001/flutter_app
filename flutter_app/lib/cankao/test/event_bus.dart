import 'dart:async';

class EventBus {
  static EventBus _instance;
  StreamController _streamController;

  factory EventBus.getDefault() {
    return _instance ??= EventBus._internal();
  }

  EventBus._internal() {
    _streamController = StreamController.broadcast();
  }

  StreamSubscription<T> regiest<T>(void onData(T event)) {
    ///todo 需要返回订阅者，所以不能使用下面这种形式
//   return _streamController.stream.listen((event) {
//      if (event is T) {
//        onData(event);
//      }
//    });
    ///没有指定类型，全类型注册
    if (T == dynamic) {
      return _streamController.stream.listen(onData);
    } else {
      ///筛选出 类型为 T 的数据,获得只包含T的Stream
      Stream<T> stream =
          _streamController.stream.where((type) => type is T).cast<T>();
      return stream.listen(onData);
    }
  }

  void post(event) {
    _streamController.add(event);
  }

  void destroy() {
    _streamController.close();
  }
}

void main() {
  EventBus.getDefault().regiest((s) {
    print("全类型注册:$s");
  });

  EventBus.getDefault().regiest<String>((s) {
    print("字符串注册:$s");
  });

  EventBus.getDefault().regiest<int>((s) {
    print("int注册:$s");
  });

  EventBus.getDefault().post("哈哈");
  EventBus.getDefault().post(1);

  EventBus.getDefault().post(10086.11);

}
