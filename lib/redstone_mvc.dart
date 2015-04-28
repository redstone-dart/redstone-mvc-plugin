import 'package:redstone/server.dart' as app;
import 'package:redstone_mapper/mapper.dart';
import 'package:path/path.dart' as path;
import 'package:shelf/shelf.dart' as shelf;
import 'dart:io';
import 'package:mustache/mustache.dart';

class Root
{
  static const String bin = '/bin';
  static const String lib = '/lib';
  static const String web = '/web';
}
/**
 * Examples:
 * 
 */
class Controller extends app.Route {
  final String root;
  final String fullFilePath;
  final bool ignoreRoot;
  final String extension;
  final String urlPosfix;
  
  const Controller(String urlTemplate, {List<String> methods: const [app.GET],
    String responseType, int statusCode: 200, bool allowMultipartRequest: false,
    bool matchSubPaths: false, this.root, this.fullFilePath, this.ignoreRoot: false, this.extension: 'html', this.urlPosfix})
      : super (urlTemplate, methods: methods, responseType: responseType,
          statusCode: statusCode, allowMultipartRequest: allowMultipartRequest,
          matchSubPaths: matchSubPaths);
  
  String buildRoute (String urlPath, ControllerGroup controlGroup)
  {
    var root = ignoreRoot ? '' :
                this.root != null ? this.root :
                controlGroup != null ? controlGroup.root :
                '';
    
    var posfix = urlPosfix != null ? urlPosfix : '';
    
    return fullFilePath != null ?
        '$root$fullFilePath.$extension' :
        '$root$urlPath$posfix.$extension';
  }
}

class ControllerGroup extends app.Group {
  final String root;
  
  const ControllerGroup(this.root, String urlPrefix): super (urlPrefix);
}


void mvcPluggin(app.Manager manager) {
  
  //Controller Group
  manager.addRouteWrapper(ControllerGroup, (metadata, Map<String, String> pathSegments, injector, request, route) async {
    
    var group = metadata as ControllerGroup;
    
    //Give it an improbable name
    request.attributes.controllerGroup__ = group;
    
    return route (pathSegments, injector, request);
    
  }, includeGroups: true);
  
  
  //Controller
  manager.addResponseProcessor(Controller, (metadata, handlerName, value, injector) async {
    //Get metadata
    var controller = metadata as Controller;
    //Get ViewGroup
    ControllerGroup controllerGroup = app.request.attributes.controllerGroup__; 
    //Create headers
    var headers = {'Content-Type': 'text/html'}
      ..addAll(app.response.headers);
    
    //Create route
    var route = controller.buildRoute(app.request.url.path, controllerGroup);
    
    //Get html file
    var html = await new File (path.current + route).readAsString();
    //Create template
    var template = new Template(html, lenient: true);
    //Render template with encoded object
    var renderedTemplate = template.renderString(encode(value));
    
    return new shelf.Response.ok(renderedTemplate, headers: headers);
  });
}