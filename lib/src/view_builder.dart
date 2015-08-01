part of redstone.mvc;

abstract class ViewBuilder {
  Object get model;
  Future<Template> template(
      RouteBuilder routeBuilder, Controller controllerGroup);
}

class ViewControllerBuilder implements ViewBuilder {
  final Object model;
  final IViewController viewController;

  ViewControllerBuilder(this.model, this.viewController);

  Future<Template> template(
      RouteBuilder _, Controller controllerGroup) async {
    var route = buildViewControllersRoute(viewController, controllerGroup);
    //Get html file
    var html = await new File(path.current + route).readAsString();
    //Define template/object
    return new Template(html, lenient: true);
  }
}

class ViewRouteBuilder implements ViewBuilder {
  final Object model;
  final RouteBuilder viewController;

  ViewRouteBuilder(this.viewController, {this.model: const {}});

  Future<Template> template(
      RouteBuilder _, Controller controllerGroup) async {
    var route = viewController.buildRoute(app.request.requestedUri.path, controllerGroup);
    //Get html file
    var html = await new File(path.current + route).readAsString();
    //Define template/object
    return new Template(html, lenient: true);
  }
}

class ViewPath implements ViewBuilder {
  final String filePath;
  final String extension;
  final Object model;

  ViewPath(this.filePath, {this.model: const {}, this.extension: 'html'});

  String get completeFilePath => '$filePath.$extension';

  Future<Template> template(
      RouteBuilder routeBuilder, Controller controllerGroup) async {
    var root = routeBuilder.buildRoot(controllerGroup);
    var filePath = root + completeFilePath;
    //Get html file
    var html = await new File(path.current + filePath).readAsString();
    //Define template/object
    return new Template(html, lenient: true);
  }
}

class ViewStringBuilder implements ViewBuilder {
  final Object model;
  final String stringTemplate;

  ViewStringBuilder(this.stringTemplate, {this.model: const {}});

  Future<Template> template(
      RouteBuilder routeBuilder, Controller controllerGroup) async =>
  new Template(stringTemplate, lenient: true);
}

class ViewTemplateBuilder implements ViewBuilder {
  final Object model;
  final Template template_;

  ViewTemplateBuilder(this.template_, {this.model: const {}});

  Future<Template> template(
      RouteBuilder routeBuilder, Controller controllerGroup) async =>
  template_;
}