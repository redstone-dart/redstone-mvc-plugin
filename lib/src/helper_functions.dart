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
  GroupController controllerGroup = app.request.attributes.controllerGroup__;

  //Get model
  Object model = value is Renderable ? value.model : value;

  Renderable renderable;


  if (routeBuilder.template != null) {
    renderable = new Model_StringTemplate(model, routeBuilder.template);

  } else if (value is! Renderable) {
    renderable = new Model_RouteBuilder(model, routeBuilder);

  } else {
    renderable = value;
  }

  Template template = await renderable.template(routeBuilder, controllerGroup);

  //Render template with encoded object
  var map = model is Map ? model : encode(model);
  var renderedTemplate = template.renderString (map);

  //Render into master template
  if (config != null && (controllerGroup == null || !controllerGroup.ignoreMaster) && !routeBuilder.ignoreMaster) {
    Template masterTemplate = await config.template;
    renderedTemplate = masterTemplate.renderString({'view': renderedTemplate});
  }

  return new shelf.Response.ok(renderedTemplate, headers: headers);
}

makeDataControllerResponse(value) {
  if (value == null || value is shelf.Response) {
    return value;
  }
  var model = value is Renderable? value.model: value;
  var map = model is Map? model: encode(model);

  return map;
}


