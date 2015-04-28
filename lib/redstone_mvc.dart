library redstone.mvc;

import 'package:redstone/server.dart' as app;
import 'package:redstone_mapper/mapper.dart';
import 'package:redstone_mapper/plugin.dart';
import 'package:path/path.dart' as path;
import 'package:shelf/shelf.dart' as shelf;
import 'dart:io';
import 'package:mustache/mustache.dart';

part 'src/classes.dart';
part 'src/plugin.dart';

makeRenderResponse (value, RouteBuilder routeBuilder) async
{
  //Create headers
  var headers = {'Content-Type': 'text/html'}
    ..addAll(app.response.headers);
  
  //Get ViewGroup
  ControllerGroup controllerGroup = app.request.attributes.controllerGroup__; 
  //Create route
  var route = routeBuilder.buildRoute(app.request.url.path, controllerGroup);
  
  //Get html file
  var html = await new File (path.current + route).readAsString();
  //Create template
  var template = new Template(html, lenient: true);
  //Render template with encoded object
  var renderedTemplate = template.renderString(encode(value));
  
  return new shelf.Response.ok(renderedTemplate, headers: headers);
}

makeDecodeResponse (value)
{
  if (value == null || value is shelf.Response) {
    return value;
  }
  
  return encode(value);
}