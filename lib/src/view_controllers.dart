part of redstone.mvc;

abstract class ViewAction {
  dynamic get root;
  String get filePath;
  String get extension;
  String get viewSubPath;
  String get viewLocalPath;
  String get template;
  String get localPath;
  bool get ignoreMaster;
}

class View extends app.Route implements RouteBuilder, ViewAction {
  final dynamic root;
  final String filePath;
  final String extension;
  final String viewSubPath;
  final String viewLocalPath;
  final String template;
  final bool ignoreMaster;

  String get localPath => viewLocalPath != null ? viewLocalPath : urlTemplate;

  const View(String urlTemplate, {List<String> methods: const [app.GET],
      String responseType, int statusCode: 200,
      bool allowMultipartRequest: false, Encoding encoding: UTF8, this.root,
      this.filePath, this.extension: 'mustache', this.viewSubPath,
      this.template, this.ignoreMaster: false, this.viewLocalPath})
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
    return buildActionRoot(this, groupController);
  }
}

class DefaultView extends app.DefaultRoute implements RouteBuilder, ViewAction {
  final dynamic root;
  final String filePath;
  final String extension;
  final String viewSubPath;
  final String viewLocalPath;
  final String template;
  final bool ignoreMaster;

  String get localPath => viewLocalPath != null ? viewLocalPath : '';

  const DefaultView({List<String> methods: const [app.GET], String responseType,
      int statusCode: 200, bool allowMultipartRequest: false,
      Encoding encoding: UTF8, this.root, this.filePath,
      this.extension: 'mustache', this.viewSubPath, this.viewLocalPath,
      this.template, this.ignoreMaster: false})
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
    return buildActionRoot(this, groupController);
  }

  String get buildLocalPath => localPath != null ? localPath : '';
}

class GetView extends View {
  const GetView(String urlTemplate, {String responseType, int statusCode: 200,
      bool allowMultipartRequest: false, Encoding encoding: UTF8, dynamic root,
      String filePath, String extension: 'mustache', String viewSubPath,
      String viewLocalPath, String template, bool ignoreMaster: false})
      : super(urlTemplate,
          methods: const [app.GET],
          responseType: responseType,
          statusCode: statusCode,
          allowMultipartRequest: allowMultipartRequest,
          encoding: encoding,
          root: root,
          filePath: filePath,
          extension: extension,
          viewSubPath: viewSubPath,
          viewLocalPath: viewLocalPath,
          template: template,
          ignoreMaster: ignoreMaster);
}

class DefaultGetView extends DefaultView {
  const DefaultGetView({String responseType, int statusCode: 200,
      bool allowMultipartRequest: false, Encoding encoding: UTF8, dynamic root,
      String filePath, String extension: 'mustache', String viewSubPath,
      String viewLocalPath, String template, bool ignoreMaster: false})
      : super(
          methods: const [app.GET],
          responseType: responseType,
          statusCode: statusCode,
          allowMultipartRequest: allowMultipartRequest,
          encoding: encoding,
          root: root,
          filePath: filePath,
          extension: extension,
          viewSubPath: viewSubPath,
          viewLocalPath: viewLocalPath,
          template: template,
          ignoreMaster: ignoreMaster);
}

class PostView extends View {
  const PostView(String urlTemplate, {String responseType, int statusCode: 200,
      bool allowMultipartRequest: false, Encoding encoding: UTF8, dynamic root,
      String filePath, String extension: 'mustache', String viewSubPath,
      String viewLocalPath, String template, bool ignoreMaster: false})
      : super(urlTemplate,
          methods: const [app.POST],
          responseType: responseType,
          statusCode: statusCode,
          allowMultipartRequest: allowMultipartRequest,
          encoding: encoding,
          root: root,
          filePath: filePath,
          extension: extension,
          viewSubPath: viewSubPath,
          viewLocalPath: viewLocalPath,
          template: template,
          ignoreMaster: ignoreMaster);
}

class DefaultPostView extends DefaultView {
  const DefaultPostView({String responseType, int statusCode: 200,
      bool allowMultipartRequest: false, Encoding encoding: UTF8, dynamic root,
      String filePath, String extension: 'mustache', String viewSubPath,
      String viewLocalPath, String template, bool ignoreMaster: false})
      : super(
          methods: const [app.POST],
          responseType: responseType,
          statusCode: statusCode,
          allowMultipartRequest: allowMultipartRequest,
          encoding: encoding,
          root: root,
          filePath: filePath,
          extension: extension,
          viewSubPath: viewSubPath,
          viewLocalPath: viewLocalPath,
          template: template,
          ignoreMaster: ignoreMaster);
}

class PutView extends View {
  const PutView(String urlTemplate, {String responseType, int statusCode: 200,
      bool allowMultipartRequest: false, Encoding encoding: UTF8, dynamic root,
      String filePath, String extension: 'mustache', String viewSubPath,
      String viewLocalPath, String template, bool ignoreMaster: false})
      : super(urlTemplate,
          methods: const [app.PUT],
          responseType: responseType,
          statusCode: statusCode,
          allowMultipartRequest: allowMultipartRequest,
          encoding: encoding,
          root: root,
          filePath: filePath,
          extension: extension,
          viewSubPath: viewSubPath,
          viewLocalPath: viewLocalPath,
          template: template,
          ignoreMaster: ignoreMaster);
}

class DefaultPutView extends DefaultView {
  const DefaultPutView({String responseType, int statusCode: 200,
      bool allowMultipartRequest: false, Encoding encoding: UTF8, dynamic root,
      String filePath, String extension: 'mustache', String viewSubPath,
      String viewLocalPath, String template, bool ignoreMaster: false,
      String localPath})
      : super(
          methods: const [app.PUT],
          responseType: responseType,
          statusCode: statusCode,
          allowMultipartRequest: allowMultipartRequest,
          encoding: encoding,
          root: root,
          filePath: filePath,
          extension: extension,
          viewSubPath: viewSubPath,
          viewLocalPath: viewLocalPath,
          template: template,
          ignoreMaster: ignoreMaster);
}

class DeleteView extends View {
  const DeleteView(String urlTemplate, {String responseType,
      int statusCode: 200, bool allowMultipartRequest: false,
      Encoding encoding: UTF8, dynamic root, String filePath,
      String extension: 'mustache', String viewSubPath, String viewLocalPath,
      String template, bool ignoreMaster: false, String localPath})
      : super(urlTemplate,
          methods: const [app.DELETE],
          responseType: responseType,
          statusCode: statusCode,
          allowMultipartRequest: allowMultipartRequest,
          encoding: encoding,
          root: root,
          filePath: filePath,
          extension: extension,
          viewSubPath: viewSubPath,
          viewLocalPath: viewLocalPath,
          template: template,
          ignoreMaster: ignoreMaster);
}

class DefaultDeleteView extends DefaultView {
  final localPath = '';

  const DefaultDeleteView({String responseType, int statusCode: 200,
      bool allowMultipartRequest: false, Encoding encoding: UTF8, dynamic root,
      String filePath, String extension: 'mustache', String viewSubPath,
      String viewLocalPath, String template, bool ignoreMaster: false,
      String localPath})
      : super(
          methods: const [app.DELETE],
          responseType: responseType,
          statusCode: statusCode,
          allowMultipartRequest: allowMultipartRequest,
          encoding: encoding,
          root: root,
          filePath: filePath,
          extension: extension,
          viewSubPath: viewSubPath,
          viewLocalPath: viewLocalPath,
          template: template,
          ignoreMaster: ignoreMaster);
}
