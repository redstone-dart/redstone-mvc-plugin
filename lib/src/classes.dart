part of redstone.mvc;

class Root
{
  static const String bin = '/bin';
  static const String lib = '/lib';
  static const String web = '/web';
}

abstract class RouteBuilder
{
  String buildRoute (String urlPath, ControllerGroup controllerGroup);
}

class Render implements RouteBuilder
{
  final String path;
  final String extension;
  final bool ignoreRoot;
  
  const Render (this.path, {this.extension: 'html', this.ignoreRoot: false});
  
  String buildRoute (String urlPath, ControllerGroup controllerGroup)
  {
    var root = ignoreRoot ? '' :
                controllerGroup != null ? controllerGroup.root :
                '';
    return '$root$path.$extension';
  }
}

class DataController extends app.Route
{
  const DataController(String urlTemplate, {List<String> methods: const [app.GET],
    String responseType, int statusCode: 200, bool allowMultipartRequest: false,
    bool matchSubPaths: false})
      : super (urlTemplate, methods: methods, responseType: responseType,
          statusCode: statusCode, allowMultipartRequest: allowMultipartRequest,
          matchSubPaths: matchSubPaths);
}

class DataControllerDefault extends app.DefaultRoute
{
  const DataControllerDefault({List<String> methods: const [app.GET],
    String responseType, int statusCode: 200, bool allowMultipartRequest: false,
    bool matchSubPaths: false})
      : super (methods: methods, responseType: responseType,
          statusCode: statusCode, allowMultipartRequest: allowMultipartRequest,
          matchSubPaths: matchSubPaths);
}
/**
 * Examples:
 * 
 */
class ViewController extends app.Route implements RouteBuilder {
  final String root;
  final String fullFilePath;
  final bool ignoreRoot;
  final String extension;
  final String urlPosfix;
  
  const ViewController(String urlTemplate, {List<String> methods: const [app.GET],
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

class ViewControllerDefault extends app.DefaultRoute implements RouteBuilder {
  final String root;
  final String fullFilePath;
  final bool ignoreRoot;
  final String extension;
  final String urlPosfix;
  
  const ViewControllerDefault({List<String> methods: const [app.GET],
    String responseType, int statusCode: 200, bool allowMultipartRequest: false,
    bool matchSubPaths: false, this.root, this.fullFilePath, this.ignoreRoot: false, this.extension: 'html', this.urlPosfix})
      : super (methods: methods, responseType: responseType,
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