part of redstone.mvc;

class Json extends app.Route {
  const Json(String urlTemplate, {List<String> methods: const [app.GET],
      String responseType, int statusCode: 200,
      bool allowMultipartRequest: false, Encoding encoding: UTF8, dynamic root,
      String filePath, String extension: 'html', String viewSubPath,
      String viewLocalPath, String template, bool ignoreMaster})
      : super(urlTemplate,
          methods: methods,
          responseType: responseType,
          statusCode: statusCode,
          allowMultipartRequest: allowMultipartRequest,
          encoding: encoding);
}

class DefaultJson extends app.DefaultRoute {
  const DefaultJson({List<String> methods: const [app.GET], String responseType,
      int statusCode: 200, bool allowMultipartRequest: false,
      Encoding encoding: UTF8, dynamic root, String filePath, includeRoot: true,
      String extension: 'html', String viewSubPath, String viewLocalPath,
      String template, bool ignoreMaster})
      : super(
          methods: methods,
          responseType: responseType,
          statusCode: statusCode,
          allowMultipartRequest: allowMultipartRequest,
          encoding: encoding);
}

class GetJson extends Json {
  const GetJson(String urlTemplate, {String responseType, int statusCode: 200,
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

class DefaultGetJson extends DefaultJson {
  const DefaultGetJson({String responseType, int statusCode: 200,
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

class PostJson extends Json {
  const PostJson(String urlTemplate, {String responseType, int statusCode: 200,
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

class DefaultPostJson extends DefaultJson {
  const DefaultPostJson({String responseType, int statusCode: 200,
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

class PutJson extends Json {
  const PutJson(String urlTemplate, {String responseType, int statusCode: 200,
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

class DefaultPutJson extends DefaultJson {
  const DefaultPutJson({String responseType, int statusCode: 200,
      bool allowMultipartRequest: false, Encoding encoding: UTF8, dynamic root,
      String filePath, String extension: 'mustache', String viewSubPath,
      String viewLocalPath, String template, bool ignoreMaster: false})
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

class DeleteJson extends Json {
  const DeleteJson(String urlTemplate, {String responseType,
      int statusCode: 200, bool allowMultipartRequest: false,
      Encoding encoding: UTF8, dynamic root, String filePath,
      String extension: 'mustache', String viewSubPath, String viewLocalPath,
      String template, bool ignoreMaster: false})
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

class DefaultDeleteJson extends DefaultJson {
  const DefaultDeleteJson({String responseType, int statusCode: 200,
      bool allowMultipartRequest: false, Encoding encoding: UTF8, dynamic root,
      String filePath, String extension: 'mustache', String viewSubPath,
      String viewLocalPath, String template, bool ignoreMaster: false})
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
