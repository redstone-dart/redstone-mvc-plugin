part of redstone.mvc;

void mvcPluggin(app.Manager manager) {
  bootstrapMapper();
  //Controller Group
  manager.addRouteWrapper(ControllerGroup, (metadata, Map<String, String> pathSegments, injector, request, route) async {
    
    var group = metadata as ControllerGroup;
    
    //Give it an improbable name
    request.attributes.controllerGroup__ = group;
    
    return route (pathSegments, injector, request);
    
  }, includeGroups: true);
  
  
  //Controller
  manager.addResponseProcessor(ViewController, (ViewController metadata, handlerName, value, injector) async {
    return makeRenderResponse(value, metadata);
  });
  
  //ControllerDefault
  manager.addResponseProcessor(ViewControllerDefault, (ViewControllerDefault metadata, handlerName, value, injector) async {
    return makeRenderResponse(value, metadata);
  });
  
  //Render
//  manager.addResponseProcessor(Render, (Render metadata, handlerName, value, injector) async {
//    return makeRenderResponse(value, metadata);
//  });
  
  //DataController
  manager.addResponseProcessor(DataController, (DataController metadata, handlerName, value, injector) async {
    return makeDecodeResponse(value);
  });
  
  //DataControllerDefault
  manager.addResponseProcessor(DataControllerDefault, (DataControllerDefault metadata, handlerName, value, injector) async {
    return makeDecodeResponse(value);
  });
}