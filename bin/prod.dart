import 'dart:io';
import 'dart:isolate';
import 'package:angel_framework/angel_framework.dart';
import 'package:flutter_talk/flutter_talk.dart' as flutter_talk;
import 'package:logging/logging.dart';

const String hostname = '127.0.0.1';
const int port = 3000;

void main() {
  // Start a server instance in multiple isolates.

  for (int id = 0; id < Platform.numberOfProcessors; id++)
    Isolate.spawn(isolateMain, id);

  isolateMain(Platform.numberOfProcessors);
}

void isolateMain(int id) {
  var app = new Angel();

  // In production, we'll want to log errors to a file.
  // Alternatives include sending logs to a service like Sentry.
  app.logger = new Logger('angel')
    ..onRecord.listen((rec) {
      if (rec.error == null) {
        stdout.writeln(rec);
      } else {
        var err = rec.error;
        if (err is AngelHttpException && err.statusCode != 500) return;
        var sink = stderr;
        sink..writeln(rec)..writeln(rec.error)..writeln(rec.stackTrace);
      }
    });

  app.configure(flutter_talk.configureServer).then((_) async {
    // Passing `startShared` to the constructor allows us to start multiple
    // instances of our application concurrently, listening on a single port.
    //
    // This effectively lets us multi-thread the application.
    var http = new AngelHttp.custom(app, startShared);
    var server = await http.startServer(hostname, port);
    print('Instance #$id listening at http://${server.address.address}:${server
        .port}');
  });
}
