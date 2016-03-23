
import "dart:isolate";
import "dart:async";

void main(List<String> args, SendPort toMain) {
  var interval = new Duration(seconds: 10);
  var fromMain = new ReceivePort();
  toMain.send(fromMain.sendPort);
  Timer timer;
  fromMain.listen((msg) {
    switch(msg) {
    case "start":
      timer = new Timer.periodic(interval, (t) {
        toMain.send("tick");
      });
      break;
    case "stop":
      timer.cancel();
      break;
    }
  });
}
