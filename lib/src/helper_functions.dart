part of redstone.mvc;

makeViewResponse(value, RouteBuilder routeBuilder) async {
  if (value == null || value is shelf.Response) {
    return value;
  }

  //Create headers
  var headers = {'Content-Type': 'text/html'}..addAll(app.response.headers);

  if (value is String) {
    return new shelf.Response.ok(value, headers: headers);
  }

  //Get ViewGroup
  Controller controller = app.request.attributes.controllerGroup__;

  //Get model
  Object model = value is ViewBuilder ? value.model : value;

  ViewBuilder renderable;

  if (routeBuilder.template != null) {
    renderable = new ViewString(routeBuilder.template, model: model);
  } else if (value is! ViewBuilder) {
    renderable = new ViewRouteBuilder(routeBuilder, model: model);
  } else {
    renderable = value;
  }

  Template template = await renderable.template(routeBuilder, controller);

  //Render template with encoded object
  var map = model is Map ? model : encode(model);
  var renderedTemplate = template.renderString(map);

  //Render into master template
  if (controller != null && controller.includeMaster) {
    Template masterTemplate = await controller.masterTemplate;
    renderedTemplate = masterTemplate.renderString({'view': renderedTemplate});
  }

  return new shelf.Response.ok(renderedTemplate, headers: headers);
}

makeJsonResponse(value) {
  if (value == null || value is shelf.Response) {
    return value;
  }
  var model = value is ViewBuilder ? value.model : value;
  var map = model is Map ? model : encode(model);

  return map;
}

String buildViewControllersRoute(ViewAction action,
    Controller controller) {
  var extension = action.extension;
  var filePath = action.filePath;
  var root = buildActionRoot(action, controller);
  var subpath = action.viewSubPath != null ? action.viewSubPath : '';
  var groupPath = controller.urlPrefix;
  var localPath = action.localPath;

  return filePath != null
      ? '$filePath.$extension'
      : '$root$groupPath$localPath$subpath.$extension';
}

String buildActionRoot(ViewAction action, Controller controller) {

  var actionRoot = action.root != null
      ? action.root : null;

  return actionRoot != null? actionRoot: buildControllerRoot(controller);
}

String buildControllerRoot(Controller controllerGroup) {

  var projectRoot = _config != null && _config.projectRoot != null ? _config.projectRoot : null;
  var controllerRoot = controllerGroup != null && controllerGroup.root != null
  ? controllerGroup.root
  : null;

  return controllerRoot != null? controllerRoot: projectRoot != null? projectRoot: '';
}
