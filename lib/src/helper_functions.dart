part of redstone.mvc;

makeRenderResponse(value, RouteBuilder routeBuilder) async {
  if (value == null || value is shelf.Response) {
    return value;
  }

  //Create headers
  var headers = {'Content-Type': 'text/html'}..addAll(app.response.headers);

  if (value is String) {
    return new shelf.Response.ok(value, headers: headers);
  }

  //Get ViewGroup
  ControllerGroup controllerGroup = app.request.attributes.controllerGroup__;
  
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
  var renderedTemplate = template.renderString(encode(model));

  return new shelf.Response.ok(renderedTemplate, headers: headers);
}

makeDecodeResponse(value) {
  if (value == null || value is shelf.Response) {
    return value;
  }

  return encode(value);
}
