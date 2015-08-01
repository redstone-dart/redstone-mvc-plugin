part of redstone.mvc;

void mvcPluggin(app.Manager manager) {
  bootstrapMapper();
  //Controller Group

  manager.addRouteWrapper(Controller, (dynamic metadata, injector,
      app.Request request, app.DynamicRoute route) async {
    var group = metadata as Controller;

    //Give it an improbable name
    request.attributes.controllerGroup__ = group;

    return route(injector, request);
  }, includeGroups: true);

  var viewTypes = [
    View,
    DefaultView,
    GetView,
    DefaultGetView,
    PostView,
    DefaultPostView,
    PutView,
    DefaultPutView,
    DeleteView,
    DefaultDeleteView
  ];

  var jsonTypes = [
    Json,
    DefaultJson,
    GetJson,
    DefaultGetJson,
    PostJson,
    DefaultPostJson,
    PutJson,
    DefaultPutJson,
    DeleteJson,
    DefaultDeleteJson
  ];

  for (var viewType in viewTypes) {
    manager.addResponseProcessor(viewType,
        (dynamic metadata, handlerName, value, injector) async {
      return makeViewControllerResponse(value, metadata);
    });
  }

  //DataController
  for (var jsonType in jsonTypes) {
    manager.addResponseProcessor(jsonType,
        (type, handlerName, value, injector) async {
      return makeDataControllerResponse(value);
    });
  }
}
