part of redstone.mvc;


class Controller extends app.Route {
  const Controller(String urlTemplate, {List<String> methods: const [app.GET],
  String responseType, int statusCode: 200,
  bool allowMultipartRequest: false, Encoding encoding: UTF8, String root,
  String filePath, bool includeRoot: true, String extension: 'html',
  String subpath, String template, bool ignoreMaster: false, String localPath})
  : super(urlTemplate,
  methods: methods,
  responseType: responseType,
  statusCode: statusCode,
  allowMultipartRequest: allowMultipartRequest,
  encoding: encoding);
}

class DefaultController extends app.DefaultRoute {
  const DefaultController({List<String> methods: const [app.GET],
                          String responseType, int statusCode: 200,
                          bool allowMultipartRequest: false, Encoding encoding: UTF8, String root,
                          String filePath, bool includeRoot: true, String extension: 'html',
                          String subpath, String template, bool ignoreMaster: false, String localPath})
  : super(
      methods: methods,
      responseType: responseType,
      statusCode: statusCode,
      allowMultipartRequest: allowMultipartRequest,
      encoding: encoding);
}