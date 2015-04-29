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

  Template template;
  Object object;

  if (value is Tuple2<FilePath, Object>) {
    //Get html file
    var html = await new File(path.current + value.i1.filePath).readAsString();
    //Define template/object
    template = new Template(html, lenient: true);
    object = value.i2;
    
  } else if (value is Tuple2<String, Object>) {
    //Define template/object
    template = new Template(value.i1, lenient: true);
    object = value.i2;
    
  } else if (value is Tuple2<Template, Object>) {
    //Define template/object
    template = value.i1;
    object = value.i2;
    
  } else {
    //Get ViewGroup
    ControllerGroup controllerGroup = app.request.attributes.controllerGroup__;
    //Create route
    var route = routeBuilder.buildRoute(app.request.url.path, controllerGroup);
    //Get html file
    var html = await new File(path.current + route).readAsString();
    //Define template/object
    template = new Template(html, lenient: true);
    object = value;
  }
  
  //Render template with encoded object
  var renderedTemplate = template.renderString(encode(object));

  return new shelf.Response.ok(renderedTemplate, headers: headers);
}

makeDecodeResponse(value) {
  if (value == null || value is shelf.Response) {
    return value;
  }

  return encode(value);
}
