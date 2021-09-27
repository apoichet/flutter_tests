import 'dart:async';
import 'dart:isolate';

import 'package:flutter_test/flutter_test.dart';

main() async {
  test('Futures Concurrent', () async {
    final treatmentFuture = Future.delayed(Duration(seconds: 2), () => print("Treatment finish !"));
    final advertisingFuture = Future.delayed(Duration(seconds: 3), () => print("Advertising finish !"));

    await Future.wait([treatmentFuture, advertisingFuture]);
  });

  test('Isolates Parallelism', () async {
    var mainPort = new ReceivePort();

    //Treatment
    await Isolate.spawn<SendPort>(treatment, mainPort.sendPort);

    //Show advertising
    await Future.delayed(Duration(seconds: 3)).then((_) => print("Advertising finish !"));
    final msgTreatment = await mainPort.first;
    print(msgTreatment);
  });
}

treatment(SendPort sendPort) async {
  //Do treatment
  await Future.delayed(Duration(seconds: 2));

  //Send treatment is finish
  sendPort.send("Treatment finish !");

  print("Isolates Terminated");
}
