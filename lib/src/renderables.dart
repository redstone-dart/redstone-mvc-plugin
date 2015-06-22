part of redstone.mvc;

abstract class Renderable {
  Object get model;
  Future<Template> template(
      RouteBuilder routeBuilder, GroupController controllerGroup);
}

class Model_ViewController implements Renderable {
  final Object model;
  final IViewController viewController;

  Model_ViewController(this.model, this.viewController);

  Future<Template> template(
      RouteBuilder _, GroupController controllerGroup) async {
    var route = buildViewControllersRoute(viewController, controllerGroup);
    //Get html file
    var html = await new File(path.current + route).readAsString();
    //Define template/object
    return new Template(html, lenient: true);
  }
}

class Model_RouteBuilder implements Renderable {
  final Object model;
  final RouteBuilder viewController;

  Model_RouteBuilder(this.model, this.viewController);

  Future<Template> template(
      RouteBuilder _, GroupController controllerGroup) async {
    var route = viewController.buildRoute(app.request.requestedUri.path, controllerGroup);
    //Get html file
    var html = await new File(path.current + route).readAsString();
    //Define template/object
    return new Template(html, lenient: true);
  }
}

class Model_Path implements Renderable {
  final String filePath;
  final String extension;
  final Object model;

  Model_Path(this.model, this.filePath, {this.extension: 'html'});

  String get completeFilePath => '$filePath.$extension';

  Future<Template> template(
      RouteBuilder routeBuilder, GroupController controllerGroup) async {
    var root = routeBuilder.buildRoot(controllerGroup);
    var filePath = root + completeFilePath;
    //Get html file
    var html = await new File(path.current + filePath).readAsString();
    //Define template/object
    return new Template(html, lenient: true);
  }
}

class Model_StringTemplate implements Renderable {
  final Object model;
  final String stringTemplate;

  Model_StringTemplate(this.model, this.stringTemplate);

  Future<Template> template(
      RouteBuilder routeBuilder, GroupController controllerGroup) async =>
  new Template(stringTemplate, lenient: true);
}

class Model_Template implements Renderable {
  final Object model;
  final Template template_;

  Model_Template(this.model, this.template_);

  Future<Template> template(
      RouteBuilder routeBuilder, GroupController controllerGroup) async =>
  template_;
}