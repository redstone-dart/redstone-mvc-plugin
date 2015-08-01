part of redstone.mvc;

makeViewControllerResponse(value, RouteBuilder routeBuilder) async {
  if (value == null || value is shelf.Response) {
    return value;
  }

  //Create headers
  var headers = {'Content-Type': 'text/html'}..addAll(app.response.headers);

  if (value is String) {
    return new shelf.Response.ok(value, headers: headers);
  }

  //Get ViewGroup
  Controller controllerGroup = app.request.attributes.controllerGroup__;

  //Get model
  Object model = value is ViewBuilder ? value.model : value;

  ViewBuilder renderable;

  if (routeBuilder.template != null) {
    renderable = new ViewStringBuilder(routeBuilder.template, model: model);
  } else if (value is! ViewBuilder) {
    renderable = new ViewRouteBuilder(routeBuilder, model: model);
  } else {
    renderable = value;
  }

  Template template = await renderable.template(routeBuilder, controllerGroup);

  //Render template with encoded object
  var map = model is Map ? model : encode(model);
  var renderedTemplate = template.renderString(map);

  //Render into master template
  if (config != null &&
      (controllerGroup == null || !controllerGroup.ignoreMaster) &&
      !routeBuilder.ignoreMaster) {
    Template masterTemplate = await config.template;
    renderedTemplate = masterTemplate.renderString({'view': renderedTemplate});
  }

  return new shelf.Response.ok(renderedTemplate, headers: headers);
}

makeDataControllerResponse(value) {
  if (value == null || value is shelf.Response) {
    return value;
  }
  var model = value is ViewBuilder ? value.model : value;
  var map = model is Map ? model : encode(model);

  return map;
}

String buildViewControllersRoute(IViewController controller,
    Controller groupController) {
  var extension = controller.extension;
  var filePath = controller.filePath;
  var root = buildViewControllersRoot(controller, groupController);
  var subpath = controller.subpath != null ? controller.subpath : '';
  var groupPath = groupController.urlPrefix;
  var localPath = controller.buildLocalPath;

  return filePath != null
      ? '$root$filePath.$extension'
      : '$root$groupPath$localPath$subpath.$extension';
}

String buildViewControllersRoot(IViewController controller, Controller controllerGroup) {
  if (!controller.includeRoot) return '';

  var projectRoot = config != null && config.projectRoot != null ? config.projectRoot : '';
  var routeRoot = controller.root != null
      ? controller.root
      : controllerGroup != null && controllerGroup.root != null
          ? controllerGroup.root
          : '';

  return projectRoot + routeRoot;
}
