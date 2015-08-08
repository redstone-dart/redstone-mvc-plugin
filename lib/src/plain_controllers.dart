part of redstone.mvc;

class Action extends app.Route {
  const Action(String urlTemplate, {List<String> methods: const [app.GET],
      String responseType, int statusCode: 200,
      bool allowMultipartRequest: false, Encoding encoding: UTF8, String root,
      String filePath, String extension: 'html',
      String subpath, String template, bool ignoreMaster: false,
      String localPath})
      : super(urlTemplate,
          methods: methods,
          responseType: responseType,
          statusCode: statusCode,
          allowMultipartRequest: allowMultipartRequest,
          encoding: encoding);
}

class DefaultAction extends app.DefaultRoute {
  const DefaultAction({List<String> methods: const [app.GET],
      String responseType, int statusCode: 200,
      bool allowMultipartRequest: false, Encoding encoding: UTF8, String root,
      String filePath, String extension: 'html',
      String subpath, String template, bool ignoreMaster: false,
      String localPath})
      : super(
          methods: methods,
          responseType: responseType,
          statusCode: statusCode,
          allowMultipartRequest: allowMultipartRequest,
          encoding: encoding);
}

class Get extends Action {
  const Get(String urlTemplate, {String responseType, int statusCode: 200,
      bool allowMultipartRequest: false, Encoding encoding: UTF8, String root,
      String filePath, String extension: 'html',
      String subpath, String template, bool ignoreMaster: false,
      String localPath})
      : super(urlTemplate,
          methods: const [app.GET],
          responseType: responseType,
          statusCode: statusCode,
          allowMultipartRequest: allowMultipartRequest,
          encoding: encoding);
}

class DefaultGet extends DefaultAction {
  const DefaultGet({List<String> methods: const [app.GET], String responseType,
      int statusCode: 200, bool allowMultipartRequest: false,
      Encoding encoding: UTF8, String root, String filePath,
      String extension: 'html', String subpath,
      String template, bool ignoreMaster: false, String localPath})
      : super(
          methods: const [app.GET],
          responseType: responseType,
          statusCode: statusCode,
          allowMultipartRequest: allowMultipartRequest,
          encoding: encoding);
}

class Post extends Action {
  const Post(String urlTemplate, {String responseType, int statusCode: 200,
      bool allowMultipartRequest: false, Encoding encoding: UTF8, String root,
      String filePath, String extension: 'html',
      String viewSubPath, String viewLocalPath, String template, bool ignoreMaster: false,
      String localPath})
      : super(urlTemplate,
          methods: const [app.POST],
          responseType: responseType,
          statusCode: statusCode,
          allowMultipartRequest: allowMultipartRequest,
          encoding: encoding);
}

class DefaultPost extends DefaultAction {
  const DefaultPost({List<String> methods: const [app.GET], String responseType,
      int statusCode: 200, bool allowMultipartRequest: false,
      Encoding encoding: UTF8, String root, String filePath,
      String extension: 'html', String viewSubPath, String viewLocalPath,
      String template, bool ignoreMaster: false, String localPath})
      : super(
          methods: const [app.POST],
          responseType: responseType,
          statusCode: statusCode,
          allowMultipartRequest: allowMultipartRequest,
          encoding: encoding);
}

class Put extends Action {
  const Put(String urlTemplate, {String responseType, int statusCode: 200,
      bool allowMultipartRequest: false, Encoding encoding: UTF8, String root,
      String filePath, String extension: 'html',
      String viewSubPath, String viewLocalPath, String template, bool ignoreMaster: false,
      String localPath})
      : super(urlTemplate,
          methods: const [app.PUT],
          responseType: responseType,
          statusCode: statusCode,
          allowMultipartRequest: allowMultipartRequest,
          encoding: encoding);
}

class DefaultPut extends DefaultAction {
  const DefaultPut({List<String> methods: const [app.GET], String responseType,
      int statusCode: 200, bool allowMultipartRequest: false,
      Encoding encoding: UTF8, String root, String filePath,
      String extension: 'html', String viewSubPath, String viewLocalPath,
      String template, bool ignoreMaster: false, String localPath})
      : super(
          methods: const [app.PUT],
          responseType: responseType,
          statusCode: statusCode,
          allowMultipartRequest: allowMultipartRequest,
          encoding: encoding);
}

class Delete extends Action {
  const Delete(String urlTemplate, {String responseType, int statusCode: 200,
      bool allowMultipartRequest: false, Encoding encoding: UTF8, String root,
      String filePath, String extension: 'html',
      String viewSubPath, String viewLocalPath, String template, bool ignoreMaster: false,
      String localPath})
      : super(urlTemplate,
          methods: const [app.DELETE],
          responseType: responseType,
          statusCode: statusCode,
          allowMultipartRequest: allowMultipartRequest,
          encoding: encoding);
}

class DefaultDelete extends DefaultAction {
  const DefaultDelete({List<String> methods: const [app.GET],
      String responseType, int statusCode: 200,
      bool allowMultipartRequest: false, Encoding encoding: UTF8, String root,
      String filePath, String extension: 'html',
      String viewSubPath, String viewLocalPath, String template, bool ignoreMaster: false,
      String localPath})
      : super(
          methods: const [app.DELETE],
          responseType: responseType,
          statusCode: statusCode,
          allowMultipartRequest: allowMultipartRequest,
          encoding: encoding);
}
