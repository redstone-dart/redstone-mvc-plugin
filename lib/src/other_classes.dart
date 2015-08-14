part of redstone.mvc;

class MvcConfig {
  final String masterLocation;
  final String masterExtension;
  final String projectRoot;

  MvcConfig({this.masterLocation: '/master', this.masterExtension: 'mustache',
      this.projectRoot: "/lib/views"});

  Future<Template> get template async {
    var route = "$projectRoot$masterLocation.$masterExtension";
    var html = await new File(path.current + route).readAsString();
    //Define template/object
    return new Template(html, lenient: true);
  }
}

abstract class RouteBuilder {
  String buildRoute(String urlPath, Controller controllerGroup);
  String get template;
  String buildRoot(Controller controllerGroup);
  bool get ignoreMaster;
}

const DecodeJson = const Decode();
const DecodeForm = const Decode(from: const[app.FORM]);
const DecodeAny = const Decode(from: const[app.JSON, app.FORM]);
const DecodeQueryParams = const Decode (fromQueryParams: true);

