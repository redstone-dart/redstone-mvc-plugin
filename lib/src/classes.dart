part of redstone.mvc;

class Root
{
  static const String bin = '/bin';
  static const String lib = '/lib';
  static const String web = '/web';
}

class FilePath
{
  final String path;
  final String extension;
  
  FilePath (this.path, {this.extension: 'html'});
  
  String get filePath => '$path.$extension';
}

abstract class RouteBuilder
{
  String buildRoute (String urlPath, ControllerGroup controllerGroup);
  String get template;
}

class Render implements RouteBuilder
{
  final String path;
  final String extension;
  final bool includeRoot;
  final String template;
  
  const Render (this.path, {this.extension: 'html', this.includeRoot: true, this.template});
  
  String buildRoute (String urlPath, ControllerGroup controllerGroup)
  {
    var root = ! includeRoot ? '' :
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
  final bool includeRoot;
  final String extension;
  final String urlPosfix;
  final String template;
  
  const ViewController(String urlTemplate, {List<String> methods: const [app.GET],
    String responseType, int statusCode: 200, bool allowMultipartRequest: false,
    bool matchSubPaths: false, this.root, this.fullFilePath, this.includeRoot: true,
    this.extension: 'html', this.urlPosfix, this.template})
      
      : super (urlTemplate, methods: methods, responseType: responseType,
          statusCode: statusCode, allowMultipartRequest: allowMultipartRequest,
          matchSubPaths: matchSubPaths);
  
  String buildRoute (String urlPath, ControllerGroup controlGroup)
  {
    var root = ! includeRoot ? '' :
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
  final bool includeRoot;
  final String extension;
  final String urlPosfix;
  final String template;
  
  const ViewControllerDefault({List<String> methods: const [app.GET],
    String responseType, int statusCode: 200, bool allowMultipartRequest: false,
    bool matchSubPaths: false, this.root, this.fullFilePath, this.includeRoot: true,
    this.extension: 'html', this.urlPosfix, this.template})
    
      : super (methods: methods, responseType: responseType,
          statusCode: statusCode, allowMultipartRequest: allowMultipartRequest,
          matchSubPaths: matchSubPaths);
  
  String buildRoute (String urlPath, ControllerGroup controlGroup)
  {
    var root = ! includeRoot ? '' :
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