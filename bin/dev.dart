import 'dart:io';
import 'package:angel_framework/angel_framework.dart';
import 'package:angel_hot/angel_hot.dart';
import 'package:flutter_talk/flutter_talk.dart' as flutter_talk;
import 'package:flutter_talk/src/pretty_logging.dart' as flutter_talk;
import 'package:logging/logging.dart';

main() async {
  // Watch the config/ and web/ directories for changes, and hot-reload the server.
  var hot = new HotReloader(() async {
    var app = new Angel();
    app.logger = new Logger('flutter_training');
    var sub = app.logger.onRecord.listen(flutter_talk.prettyLog);
    app.shutdownHooks.add((_) => sub.cancel());
    await app.configure(flutter_talk.configureServer);
    return app;
  }, [
    new Directory('config'),
    new Directory('lib'),
  ]);

  var server = await hot.startServer('0.0.0.0', 3000);
  print('Listening at http://${server.address.address}:${server.port}');
}
