part of redstone.mvc;

class Root {
  static const String bin = '/bin';
  static const String lib = '/lib';
  static const String web = '/web';
}

abstract class Renderable {
  Object get model;
  Future<Template> template(
      RouteBuilder routeBuilder, GroupController controllerGroup);
}

class Model_RouteBuilder implements Renderable {
  final Object model;
  final RouteBuilder routeBuilder;

  Model_RouteBuilder(this.model, this.routeBuilder);

  Future<Template> template(
      RouteBuilder _, GroupController controllerGroup) async {
    var route = routeBuilder.buildRoute(app.request.url.path, controllerGroup);
    //Get html file
    var html = await new File(path.current + route).readAsString();
    //Define template/object
    return new Template(html, lenient: true);
  }
}

class Model_Path implements Renderable {
  final String filePath;
  final String extension;
  final Object model;

  Model_Path(this.model, this.filePath, {this.extension: 'html'});

  String get completeFilePath => '$filePath.$extension';

  Future<Template> template(
      RouteBuilder routeBuilder, GroupController controllerGroup) async {
    var root = routeBuilder.buildRoot(controllerGroup);
    var filePath = root + completeFilePath;
    //Get html file
    var html = await new File(path.current + filePath).readAsString();
    //Define template/object
    return new Template(html, lenient: true);
  }
}

class Model_StringTemplate implements Renderable {
  final Object model;
  final String stringTemplate;

  Model_StringTemplate(this.model, this.stringTemplate);

  Future<Template> template(
          RouteBuilder routeBuilder, GroupController controllerGroup) async =>
      new Template(stringTemplate, lenient: true);
}

class Model_Template implements Renderable {
  final Object model;
  final Template template_;

  Model_Template(this.model, this.template_);

  Future<Template> template(
          RouteBuilder routeBuilder, GroupController controllerGroup) async =>
      template_;
}

abstract class RouteBuilder {
  String buildRoute(String urlPath, GroupController controllerGroup);
  String get template;
  String buildRoot(GroupController controllerGroup);
}

class DataController extends app.Route {

  const DataController(String urlTemplate,
      {List<String> methods: const [app.GET], String responseType,
      int statusCode: 200, bool allowMultipartRequest: false,
      bool matchSubPaths: false, String root,
      String filePath, includeRoot: true, String extension: 'html',
      String subpath, String template})
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
      bool allowMultipartRequest: false, bool matchSubPaths: false, String root,
      String filePath, includeRoot: true, String extension: 'html',
      String subpath, String template})
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

  String buildRoute(String urlPath, GroupController controllerGroup) {
    var root = buildRoot(controllerGroup);
    var posfix = subpath != null ? subpath : '';

    return filePath != null
        ? '$root$filePath.$extension'
        : '$root$urlPath$posfix.$extension';
  }

  String buildRoot(GroupController controllerGroup) {
    return !includeRoot
        ? ''
        : this.root != null
            ? this.root
            : controllerGroup != null && controllerGroup.root != null
                ? controllerGroup.root
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

  String buildRoute(String urlPath, GroupController controllerGroup) {
    var root = buildRoot(controllerGroup);
    var posfix = urlPosfix != null ? urlPosfix : '';

    return fullFilePath != null
        ? '$root$fullFilePath.$extension'
        : '$root$urlPath$posfix.$extension';
  }

  String buildRoot(GroupController controllerGroup) {
    return !includeRoot
        ? ''
        : this.root != null
            ? this.root
            : controllerGroup != null && controllerGroup.root != null
                ? controllerGroup.root
                : '';
  }
}

class GroupController extends app.Group {
  final String root;

  const GroupController(String urlPrefix, {this.root}) : super(urlPrefix);
}
