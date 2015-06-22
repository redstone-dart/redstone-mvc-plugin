part of redstone.mvc;

class Root {
  static const String bin = '/bin';
  static const String lib = '/lib';
  static const String web = '/web';
}

class MvcConfig {
  String masterLocation;
  String extension;
  String projectRoot;

  MvcConfig({this.masterLocation: '/html/master', this.extension: 'html',
      this.projectRoot: "/web"});

  Future<Template> get template async {
    var route = "$projectRoot$masterLocation.$extension";
    var html = await new File(path.current + route).readAsString();
    //Define template/object
    return new Template(html, lenient: true);
  }
}

abstract class RouteBuilder {
  String buildRoute(String urlPath, GroupController controllerGroup);
  String get template;
  String buildRoot(GroupController controllerGroup);
  bool get ignoreMaster;
}
