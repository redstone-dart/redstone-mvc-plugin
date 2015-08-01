part of redstone.mvc;


class MvcConfig {
  final String masterLocation;
  final String extension;
  final String projectRoot;

  MvcConfig({this.masterLocation: '/master', this.extension: 'html',
      this.projectRoot: "/web/html"});

  Future<Template> get template async {
    var route = "$projectRoot$masterLocation.$extension";
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
