part of redstone.mvc;

class Root {
  static const String bin = '/bin';
  static const String lib = '/lib';
  static const String web = '/web';
}

class Model_Path {
  final String path;
  final String extension;
  final Object model;

  Model_Path(this.model, this.path, {this.extension: 'html'});

  String get filePath => '$path.$extension';
}

class Model_StringTemplate
{
  final Object model;
  final String template;
  
  Model_StringTemplate (this.model, this.template);
}

class Model_Template
{
  final Object model;
  final Template template;
  
  Model_Template (this.model, this.template);
}

abstract class RouteBuilder {
  String buildRoute(String urlPath, ControllerGroup controllerGroup);
  String get template;
  String buildRoot (ControllerGroup controllerGroup);
}

//class Render implements RouteBuilder {
//  final String path;
//  final String extension;
//  final bool includeRoot;
//  final String template;
//
//  const Render({this.path, this.extension: 'html', this.includeRoot: true,
//      this.template});
//
//  String buildRoute(String urlPath, ControllerGroup controllerGroup) {
//    var root = !includeRoot ? '' :
//               controllerGroup != null ? controllerGroup.root :
//               '';
//    
//    if (path == null)
//      throw new ArgumentError.notNull('null path field in Render instance');
//    
//    return '$root$path.$extension';
//  }
//}

class DataController extends app.Route {
  const DataController(String urlTemplate,
      {List<String> methods: const [app.GET], String responseType,
      int statusCode: 200, bool allowMultipartRequest: false,
      bool matchSubPaths: false})
      : super(urlTemplate,
          methods: methods,
          responseType: responseType,
          statusCode: statusCode,
          allowMultipartRequest: allowMultipartRequest,
          matchSubPaths: matchSubPaths);
}

class DataControllerDefault extends app.DefaultRoute {
  const DataControllerDefault({List<String> methods: const [app.GET],
      String responseType, int statusCode: 200,
      bool allowMultipartRequest: false, bool matchSubPaths: false})
      : super(
          methods: methods,
          responseType: responseType,
          statusCode: statusCode,
          allowMultipartRequest: allowMultipartRequest,
          matchSubPaths: matchSubPaths);
}


class ViewController extends app.Route implements RouteBuilder {
  final String root;
  final String filePath;
  final bool includeRoot;
  final String extension;
  final String subpath;
  final String template;

  const ViewController(String urlTemplate,
      {List<String> methods: const [app.GET], String responseType,
      int statusCode: 200, bool allowMultipartRequest: false,
      bool matchSubPaths: false, this.root, this.filePath,
      this.includeRoot: true, this.extension: 'html', this.subpath,
      this.template})
      : super(urlTemplate,
          methods: methods,
          responseType: responseType,
          statusCode: statusCode,
          allowMultipartRequest: allowMultipartRequest,
          matchSubPaths: matchSubPaths);

  String buildRoute(String urlPath, ControllerGroup controllerGroup) {
    var root = buildRoot(controllerGroup);
    var posfix = subpath != null ? subpath : '';

    return filePath != null
        ? '$root$filePath.$extension'
        : '$root$urlPath$posfix.$extension';
  }

  
  String buildRoot(ControllerGroup controllerGroup) {
    return ! includeRoot ?  ''
        : this.root != null ? this.root
        : controllerGroup != null ? controllerGroup.root
        : '';
  }
}

class ViewControllerDefault extends app.DefaultRoute implements RouteBuilder {
  final String root;
  final String fullFilePath;
  final bool includeRoot;
  final String extension;
  final String urlPosfix;
  final String template;

  const ViewControllerDefault({List<String> methods: const [app.GET],
      String responseType, int statusCode: 200,
      bool allowMultipartRequest: false, bool matchSubPaths: false, this.root,
      this.fullFilePath, this.includeRoot: true, this.extension: 'html',
      this.urlPosfix, this.template})
      : super(
          methods: methods,
          responseType: responseType,
          statusCode: statusCode,
          allowMultipartRequest: allowMultipartRequest,
          matchSubPaths: matchSubPaths);

  String buildRoute(String urlPath, ControllerGroup controllerGroup) {
    var root = buildRoot(controllerGroup);
    var posfix = urlPosfix != null ? urlPosfix : '';

    return fullFilePath != null
        ? '$root$fullFilePath.$extension'
        : '$root$urlPath$posfix.$extension';
  }

  String buildRoot(ControllerGroup controllerGroup) {
    return !includeRoot ? ''
        : this.root != null ? this.root
        : controllerGroup != null ? controllerGroup.root
        : '';
  }
}

class ControllerGroup extends app.Group {
  final String root;

  const ControllerGroup(this.root, String urlPrefix) : super(urlPrefix);
}
