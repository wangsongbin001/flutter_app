import 'dart:async';
/****************dart 异步编程****************/
import "dart:isolate";
import 'dart:io';

int i;
//1, isolate;dart中通过Isolate.spawn启动一个线程，但不同于java中的线程；dart线程间是内存隔离的
main(){
  Isolate.spawn(entryPoint, "hello world!");
  print("next");
  //2，线程间，内存隔离的
  i = 1;
  //3，自线程与主线程间的通讯，SendPort&ReceivePort; 相互把发送器发给对方，ReceivePort注册监听；
  ReceivePort mainReceivePort = new ReceivePort();
  mainReceivePort.listen((msg){
    if(msg is ThreadData) {
      print(msg.msg);
      msg.port.send("msg from main 2");
      return;
    }
    print(msg);
    //使用完了记得关闭哦
    mainReceivePort.close();
  }
  );
  Isolate.spawn(entryPoint2, ThreadData(mainReceivePort.sendPort, "msg from main"));
  //4，消息驱动，main(）线程是串行的，耗时操作会影响，后面的消息接收。
  // dart中有两个任务队列；microtask queue(微任务队列)/eventtask queue（事件任务队列），微任务队 列优先级更高，每执行完一次事件任务，都检查是否有微任务；有则优先执行；
  ReceivePort mR = new ReceivePort();
  mR.listen((msg){
    print(msg);
  });
  Future.microtask((){
    print("微任务执行");
  });
  mR.sendPort.send("普通任务执行");
  Future.microtask((){
    print("微任务执行");
  });
  //5，Future，1,提交延时任务; 2，流操作
  Future.delayed(Duration(seconds: 3),(){return "delay task";})
      .then((t){
           print("then $t");
       });
  new File(r"/Users/songbinwang/dev/github/flutter_demo/flutter_app/lib/a.txt")
      .readAsString()
      .then((conent){
        print('文件内容 $conent');
        return 1;
      })
      .then((i){
        print(i);
      })
      .catchError((e, s){
        print('$e $s');
      });
  //6，组合 wait方法不是同步的，不会阻塞当前的线程。
  Future f1 = new File(r"/Users/songbinwang/dev/github/flutter_demo/flutter_app/lib/a.txt").readAsString();
  Future f2 = Future.delayed(Duration(seconds: 3), (){return "task2";});
  Future.wait([f1, f2]).then((values){
    print(values[0]);
    print(values[1]);
  });
  print('wait end');
  //7，Stream 流，当对与Future来说，读取文件，可以分步进行；
  //StreamSubscription.onData 回调，会替换之前的回调。
  Stream s1 = new File(r"/Users/songbinwang/dev/github/flutter_demo/flutter_app/lib/a.txt").openRead();
  StreamSubscription<List<int>> listen = s1.listen((str){
    //如果是大文件，会回调多次。
    print('stream $str');
  });
  //任务暂停
  listen.pause();
  //结束回调
  listen.onDone((){});
  //8，文件写入
  File dest = new File(r"/Users/songbinwang/dev/github/flutter_demo/flutter_app/lib/b.txt");
  dest.openWrite().addStream(s1);
  print("write end");
  //9，广播模式， Stream.asBroadcastStream();调用这个方法前不能有订阅者；
  Stream stream1 = Stream.fromIterable([1,2,3,4]).asBroadcastStream();
  stream1.listen((t){
    print("广播接收器1 $t");
    if(t == 1){
       stream1.listen((t1){print("广播接收器2 $t1");});
    }
  });
  //StreamController.broadcast();自主创建广播；必须先注册监听；
  StreamController streamController = StreamController.broadcast();
  streamController.stream.listen((t){
    print("StreamController $t");
  });
  streamController.add(1);
  //async/await  结合使用：async将同步变异步，await将异步变同步；准确的收async方法中，从await开始切换到异步；
  readFile().then((content){
    print("content: " + content);
  });
  print("end");
}

void entryPoint(Object msg){
  print(msg);
  //sleep3秒，并不会阻塞主线程的执行。是dart:io中的方法
  sleep(new Duration(seconds: 3));
  //线程间，内存隔离的
  print(i);
}

void entryPoint2(Object msg){
  if(msg is ThreadData) {
    print(msg.msg);
    ReceivePort workReceivePort = new ReceivePort();
    workReceivePort.listen((msg){
      print(msg);
      workReceivePort.close();
    });
    msg.port.send(ThreadData(workReceivePort.sendPort, "msg from work"));
    return;
  }
  print(msg);
  //使用完了记得关闭哦
}
class ThreadData{
  SendPort port;
  String msg;
  ThreadData(this.port, this.msg);
}

Future<String> readFile() async{
  print("readFile async1");
  String content = await new File(r"/Users/songbinwang/dev/github/flutter_demo/flutter_app/lib/a.txt").readAsString();
  sleep(Duration(seconds: 6));
  print("readFile async2");
  return content;
}

