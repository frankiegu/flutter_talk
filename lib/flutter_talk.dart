/// Your very own web application!
library angel;

import 'dart:async';
import 'package:angel_framework/angel_framework.dart';
import 'package:file/local.dart';
import 'src/config/config.dart' as configuration;
import 'src/routes/routes.dart' as routes;
import 'src/services/services.dart' as services;

/// Configures the server instance.
Future configureServer(Angel app) async {
  var fs = const LocalFileSystem();

  app.use((RequestContext req, ResponseContext res) {
    res.renderParams['year'] = new DateTime.now().year;
    res.renderParams['canonical'] = req.path;
    return true;
  });

  // Set up our application, using the plug-ins defined with this project.
  await app.configure(configuration.configureServer(fs));
  await app.configure(services.configureServer);
  await app.configure(routes.configureServer(fs));

  var errorHandler = app.errorHandler;
  app.errorHandler = (e, req, res) {
    if (req.accepts('text/html')) {
      return res.render('error', {'title': e.message, 'status': e.statusCode});
    } else {
      return errorHandler(e, req, res);
    }
  };
}
