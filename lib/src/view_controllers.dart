part of redstone.mvc;

abstract class IViewController {
  String get root;
  String get filePath;
  bool get includeRoot;
  String get extension;
  String get subpath;
  String get template;
  bool get ignoreMaster;
  String get localPath;
  String get buildLocalPath;
}

class ViewController extends app.Route
    implements RouteBuilder, IViewController {
  final String root;
  final String filePath;
  final bool includeRoot;
  final String extension;
  final String subpath;
  final String template;
  final bool ignoreMaster;
  final String localPath;

  const ViewController(String urlTemplate,
      {List<String> methods: const [app.GET], String responseType,
      int statusCode: 200, bool allowMultipartRequest: false,
      Encoding encoding: UTF8, this.root, this.filePath, this.includeRoot: true,
      this.extension: 'html', this.subpath, this.template,
      this.ignoreMaster: false, this.localPath})
      : super(urlTemplate,
          methods: methods,
          responseType: responseType,
          statusCode: statusCode,
          allowMultipartRequest: allowMultipartRequest,
          encoding: encoding);

  String buildRoute(String urlPath, GroupController groupController) {
    return buildViewControllersRoute(this, groupController);
  }

  String buildRoot(GroupController groupController) {
    return buildViewControllersRoot(this, groupController);
  }

  String get buildLocalPath => localPath != null ? localPath : urlTemplate;
}

class DefaultViewController extends app.DefaultRoute
    implements RouteBuilder, IViewController {
  final String root;
  final String filePath;
  final bool includeRoot;
  final String extension;
  final String subpath;
  final String template;
  final bool ignoreMaster;
  final String localPath;

  const DefaultViewController({List<String> methods: const [app.GET],
      String responseType, int statusCode: 200,
      bool allowMultipartRequest: false, Encoding encoding: UTF8, this.root,
      this.filePath, this.includeRoot: true, this.extension: 'html',
      this.subpath, this.template, this.ignoreMaster: false, this.localPath})
      : super(
          methods: methods,
          responseType: responseType,
          statusCode: statusCode,
          allowMultipartRequest: allowMultipartRequest,
          encoding: encoding);

  String buildRoute(String urlPath, GroupController groupController) {
    return buildViewControllersRoute(this, groupController);
  }

  String buildRoot(GroupController groupController) {
    return buildViewControllersRoot(this, groupController);
  }

  String get buildLocalPath => localPath != null ? localPath : '';
}
