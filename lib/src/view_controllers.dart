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

class View extends app.Route implements RouteBuilder, IViewController {
  final String root;
  final String filePath;
  final bool includeRoot;
  final String extension;
  final String subpath;
  final String template;
  final bool ignoreMaster;
  final String localPath;

  const View(String urlTemplate, {List<String> methods: const [app.GET],
      String responseType, int statusCode: 200,
      bool allowMultipartRequest: false, Encoding encoding: UTF8, this.root,
      this.filePath, this.includeRoot: true, this.extension: 'html',
      this.subpath, this.template, this.ignoreMaster: false, this.localPath})
      : super(urlTemplate,
          methods: methods,
          responseType: responseType,
          statusCode: statusCode,
          allowMultipartRequest: allowMultipartRequest,
          encoding: encoding);

  String buildRoute(String urlPath, Controller groupController) {
    return buildViewControllersRoute(this, groupController);
  }

  String buildRoot(Controller groupController) {
    return buildViewControllersRoot(this, groupController);
  }

  String get buildLocalPath => localPath != null ? localPath : urlTemplate;
}

class DefaultView extends app.DefaultRoute
    implements RouteBuilder, IViewController {
  final String root;
  final String filePath;
  final bool includeRoot;
  final String extension;
  final String subpath;
  final String template;
  final bool ignoreMaster;
  final String localPath;

  const DefaultView({List<String> methods: const [app.GET], String responseType,
      int statusCode: 200, bool allowMultipartRequest: false,
      Encoding encoding: UTF8, this.root, this.filePath, this.includeRoot: true,
      this.extension: 'html', this.subpath, this.template,
      this.ignoreMaster: false, this.localPath})
      : super(
          methods: methods,
          responseType: responseType,
          statusCode: statusCode,
          allowMultipartRequest: allowMultipartRequest,
          encoding: encoding);

  String buildRoute(String urlPath, Controller groupController) {
    return buildViewControllersRoute(this, groupController);
  }

  String buildRoot(Controller groupController) {
    return buildViewControllersRoot(this, groupController);
  }

  String get buildLocalPath => localPath != null ? localPath : '';
}

class GetView extends View {
  const GetView(String urlTemplate, {String responseType, int statusCode: 200,
      bool allowMultipartRequest: false, Encoding encoding: UTF8, String root,
      String filePath, bool includeRoot: true, String extension: 'html',
      String subpath, String template, bool ignoreMaster: false,
      String localPath})
      : super(urlTemplate,
          methods: const [app.GET],
          responseType: responseType,
          statusCode: statusCode,
          allowMultipartRequest: allowMultipartRequest,
          encoding: encoding,
          root: root,
          filePath: filePath,
          includeRoot: includeRoot,
          extension: extension,
          subpath: subpath,
          template: template,
          ignoreMaster: ignoreMaster,
          localPath: localPath);
}

class DefaultGetView extends DefaultView {
  const DefaultGetView({String responseType, int statusCode: 200,
      bool allowMultipartRequest: false, Encoding encoding: UTF8, String root,
      String filePath, bool includeRoot: true, String extension: 'html',
      String subpath, String template, bool ignoreMaster: false,
      String localPath})
      : super(
          methods: const [app.GET],
          responseType: responseType,
          statusCode: statusCode,
          allowMultipartRequest: allowMultipartRequest,
          encoding: encoding,
          root: root,
          filePath: filePath,
          includeRoot: includeRoot,
          extension: extension,
          subpath: subpath,
          template: template,
          ignoreMaster: ignoreMaster,
          localPath: localPath);
}

class PostView extends View {
  const PostView(String urlTemplate, {String responseType, int statusCode: 200,
      bool allowMultipartRequest: false, Encoding encoding: UTF8, String root,
      String filePath, bool includeRoot: true, String extension: 'html',
      String subpath, String template, bool ignoreMaster: false,
      String localPath})
      : super(urlTemplate,
          methods: const [app.POST],
          responseType: responseType,
          statusCode: statusCode,
          allowMultipartRequest: allowMultipartRequest,
          encoding: encoding,
          root: root,
          filePath: filePath,
          includeRoot: includeRoot,
          extension: extension,
          subpath: subpath,
          template: template,
          ignoreMaster: ignoreMaster,
          localPath: localPath);
}

class DefaultPostView extends DefaultView {
  const DefaultPostView({String responseType, int statusCode: 200,
      bool allowMultipartRequest: false, Encoding encoding: UTF8, String root,
      String filePath, bool includeRoot: true, String extension: 'html',
      String subpath, String template, bool ignoreMaster: false,
      String localPath})
      : super(
          methods: const [app.POST],
          responseType: responseType,
          statusCode: statusCode,
          allowMultipartRequest: allowMultipartRequest,
          encoding: encoding,
          root: root,
          filePath: filePath,
          includeRoot: includeRoot,
          extension: extension,
          subpath: subpath,
          template: template,
          ignoreMaster: ignoreMaster,
          localPath: localPath);
}

class PutView extends View {
  const PutView(String urlTemplate, {String responseType, int statusCode: 200,
      bool allowMultipartRequest: false, Encoding encoding: UTF8, String root,
      String filePath, bool includeRoot: true, String extension: 'html',
      String subpath, String template, bool ignoreMaster: false,
      String localPath})
      : super(urlTemplate,
          methods: const [app.PUT],
          responseType: responseType,
          statusCode: statusCode,
          allowMultipartRequest: allowMultipartRequest,
          encoding: encoding,
          root: root,
          filePath: filePath,
          includeRoot: includeRoot,
          extension: extension,
          subpath: subpath,
          template: template,
          ignoreMaster: ignoreMaster,
          localPath: localPath);
}

class DefaultPutView extends DefaultView {
  const DefaultPutView({String responseType, int statusCode: 200,
      bool allowMultipartRequest: false, Encoding encoding: UTF8, String root,
      String filePath, bool includeRoot: true, String extension: 'html',
      String subpath, String template, bool ignoreMaster: false,
      String localPath})
      : super(
          methods: const [app.PUT],
          responseType: responseType,
          statusCode: statusCode,
          allowMultipartRequest: allowMultipartRequest,
          encoding: encoding,
          root: root,
          filePath: filePath,
          includeRoot: includeRoot,
          extension: extension,
          subpath: subpath,
          template: template,
          ignoreMaster: ignoreMaster,
          localPath: localPath);
}

class DeleteView extends View {
  const DeleteView(String urlTemplate, {String responseType,
      int statusCode: 200, bool allowMultipartRequest: false,
      Encoding encoding: UTF8, String root, String filePath,
      bool includeRoot: true, String extension: 'html', String subpath,
      String template, bool ignoreMaster: false, String localPath})
      : super(urlTemplate,
          methods: const [app.DELETE],
          responseType: responseType,
          statusCode: statusCode,
          allowMultipartRequest: allowMultipartRequest,
          encoding: encoding,
          root: root,
          filePath: filePath,
          includeRoot: includeRoot,
          extension: extension,
          subpath: subpath,
          template: template,
          ignoreMaster: ignoreMaster,
          localPath: localPath);
}

class DefaultDeleteView extends DefaultView {
  const DefaultDeleteView({String responseType, int statusCode: 200,
                       bool allowMultipartRequest: false, Encoding encoding: UTF8, String root,
                       String filePath, bool includeRoot: true, String extension: 'html',
                       String subpath, String template, bool ignoreMaster: false,
                       String localPath})
  : super(
      methods: const [app.DELETE],
      responseType: responseType,
      statusCode: statusCode,
      allowMultipartRequest: allowMultipartRequest,
      encoding: encoding,
      root: root,
      filePath: filePath,
      includeRoot: includeRoot,
      extension: extension,
      subpath: subpath,
      template: template,
      ignoreMaster: ignoreMaster,
      localPath: localPath);
}