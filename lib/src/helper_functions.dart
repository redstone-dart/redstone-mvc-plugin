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

  Template template;
  Object model;

  if (routeBuilder.template != null) {
    //Define template/object
    template = new Template(routeBuilder.template, lenient: true);
    model = value;
    
  } else if (value is Model_Path) {
    
    var root = routeBuilder.buildRoot(controllerGroup);
    var filePath = root + value.filePath;
    //Get html file
    var html = await new File(path.current + filePath).readAsString();
    //Define template/object
    template = new Template(html, lenient: true);
    model = value.model;
    
  } else if (value is Model_StringTemplate) {
    //Define template/object
    template = new Template(value.template, lenient: true);
    model = value.model;
    
  } else if (value is Model_Template) {
    //Define template/object
    template = value.template;
    model = value.model;
    
  } else {
    
    //Create route
    var route = routeBuilder.buildRoute(app.request.url.path, controllerGroup);
    //Get html file
    var html = await new File(path.current + route).readAsString();
    //Define template/object
    template = new Template(html, lenient: true);
    model = value;
  }
  
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
