part of redstone.mvc;

class DataController extends app.Route {
  const DataController(String urlTemplate,
                       {List<String> methods: const [app.GET], String responseType,
                       int statusCode: 200, bool allowMultipartRequest: false,
                       Encoding encoding: UTF8, String root, String filePath, includeRoot: true,
                       String extension: 'html', String subpath, String template, String localPath})
  : super(urlTemplate,
  methods: methods,
  responseType: responseType,
  statusCode: statusCode,
  allowMultipartRequest: allowMultipartRequest,
  encoding: encoding);
}

class DefaultDataController extends app.DefaultRoute {
  const DefaultDataController({List<String> methods: const [app.GET],
                              String responseType, int statusCode: 200,
                              bool allowMultipartRequest: false, Encoding encoding: UTF8, String root,
                              String filePath, includeRoot: true, String extension: 'html',
                              String subpath, String template, String localPath})
  : super(
      methods: methods,
      responseType: responseType,
      statusCode: statusCode,
      allowMultipartRequest: allowMultipartRequest,
      encoding: encoding);
}