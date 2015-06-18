part of redstone.mvc;

void mvcPluggin(app.Manager manager) {
  bootstrapMapper();
  //Controller Group

  manager.addRouteWrapper(GroupController, (dynamic metadata, injector, app.Request request, app.DynamicRoute route) async {

    var group = metadata as GroupController;

    //Give it an improbable name
    request.attributes.controllerGroup__ = group;

    return route (injector, request);

  }, includeGroups: true);


  //Controller
  manager.addResponseProcessor(ViewController, (ViewController metadata, handlerName, value, injector) async {
    return makeViewControllerResponse(value, metadata);
  });

  //ControllerDefault
  manager.addResponseProcessor(DefaultViewController, (DefaultViewController metadata, handlerName, value, injector) async {
    return makeViewControllerResponse(value, metadata);
  });


  //DataController
  manager.addResponseProcessor(DataController, (DataController metadata, handlerName, value, injector) async {
    return makeDataControllerResponse(value);
  });

  //DataControllerDefault
  manager.addResponseProcessor(DefaultDataController, (DefaultDataController metadata, handlerName, value, injector) async {
    return makeDataControllerResponse(value);
  });
}