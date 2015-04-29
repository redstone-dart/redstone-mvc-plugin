Checkout the code shown here at [example](https://github.com/redstone-dart/redstone-mvc-plugin/tree/master/example) folder.
# Redstone MVC

MVC Plugin for Redstone allows you to create routes that render `mustache`
templates using the return object as a model. With the custom `@ViewController`
annotation you can both specify both the http route the function will
respond to and the template that will be rendered.

To setup the plugin, you need add `mvc.mvcPlugin` to `app.addPlugin` on
the `main` function.

```dart
import 'package:redstone/server.dart' as app;
import 'package:redstone_mapper/mapper.dart';
import 'dart:math' as math;
import 'package:redstone_mvc/redstone_mvc.dart' as mvc;

main() {
  app.addPlugin(mvc.mvcPluggin);

  app.setupConsoleLog();
  app.start(port: 9090);
}
```
MVC works by encoding the object model returned by the function with `redstone_mapper` into a `Map` which is passed to `mustache` and then returned as `shelf.Response` with it `Content-Type` header set to `text/html`. You need to make sure that your model has the `@Field()` from `redstone_mapper` so they can properly be encoded and rendered.
```dart
class Example {
  @Field() String title;
  @Field() String description;
}
```
##ViewController
`ViewController` extends `Route` so you can easy replace the routes you want to render html with a `ViewController`. The next examples shows how to use the `template` parameter to render a simple mustache template at route `/stringTemplate` using the information from the `Example` instance model returned by the route function `stringTemplate`.
```dart
@mvc.ViewController('/stringTemplate', template: 
'''
  <div>
    <h2>{{title}}</h2>
    <p>{{description}}</p>
  </div>
''')
stringTemplate() => new Example()
  ..title = "MVC"
  ..description = "MVC is very easy with Redstone";
```
Normally however, you want to render an html file template. For this you can use the `filePath` parameter to specify the path of your file. By default it will expect that the template is an `.html` file, but if you need a diferent extension you can use the `extension` parameter to specify it.

In the nex example we are rendering the `/example/lib/template.html` on route `/fileTemplate` using an `Example` instance as a model.
```dart
@mvc.ViewController('/fileTemplate', filePath: '/example/lib/template')
fileTemplate() => new Example()
  ..title = "MVC"
  ..description = "MVC is very easy with Redstone";
```
If the route's `urlTemplate` path doesn't take you all the way to your template file, you use `subpath` to complete the remaining parts. Setting `subpath` will have no effect if you specified `filePath`.
```dart
@mvc.ViewController ('/example/lib', subpath: '/template')
subPath() => new Example()
  ..title = "Using subpath"
  ..description = "Just appends to the path";
```
If `filePath` and your route path match, you should unspecify [filePath] and `ViewController` will use the route's path to find your template file. Frameworks such as ASP.net MVC enforce folder structure, while Redstone MVC doesnt its is a good practice to order your template in a folder heirachy similar to the route heirarchy.
```dart
@mvc.ViewController('/example/lib/template')
viewController() => new Example()
  ..title = "MVC"
  ..description = "MVC is very easy with Redstone";
```
You can also set a folder directory as `root` so you don't polute your route. `root` will prepend to both `filePath` and your route's `urlTemplate` path depending on which is used.
```dart
@mvc.ViewController('/template', root: '/example/lib')
viewControllerRoot() => new Example()
  ..title = "MVC"
  ..description = "MVC is very easy with Redstone";
``` 
## ControllerGroup
You can use a `ViewController` inside a `app.Group` since it only prepends a section to your route's path. However you might also want to specify a common `root` directory to all your `filaPath`s or routes, for this you can use the `ControllerGroup` annotation. `ControllerGroup` extends `Group` and takes `root` as a first argument, and the normal `urlPrefix` as second argument. Your normal complete path to file will be `root + urlPrefix + urlTemplate`.
```dart
@mvc.ControllerGroup ('/example/lib', '/info')
class ExampleService1
{
  @mvc.ViewController ('/A')
  viewA () => new Example()
    ..title = "Route A"
    ..description = "Some description of A";
  
  @mvc.ViewController ('/B')
  viewB () => new Example()
    ..title = "Route B"
    ..description = "Some description of B";
}
```
If you want to reuse or have more control over which html get rendered, you can set a `root` in the `ControllerGroup` and `filePath` in each `ViewController`.

In the next example, routes will be `/info2/A` and `/info2/B`, but for both their template will be `/example/lib/template.html`.
```dart
@mvc.ControllerGroup ('/example/lib', '/info2')
class ExampleService2
{
  @mvc.ViewController ('/A', filePath: '/template')
  viewA () => new Example()
    ..title = "Route A"
    ..description = "Some description of A";
  
  @mvc.ViewController ('/B', filePath: '/template')
  viewB () => new Example()
    ..title = "Route B"
    ..description = "Some description of B";
}
```
Note that you can also set `includeRoot` to `false` if you want to **ignore** the `root` directory. If you want to bind to the groups route, you can use `@mvc.ViewControllerDefault` that extends from `@app.DefaultRoute` for that purpose.

## Setting path and template dynamically

You can set the `filePath` dynamically at runtime by returning a `Model_Path`. `Model_Path` takes an `Object model`, `String path` and optionally a `String extension` that defualts to `'html'`.
 
```dart
@mvc.ViewController ('/randomTemplate', root: '/example/lib/info')
dynamicFilePath ()
{
  var filePath = new math.Random().nextBool() ? '/A' : '/B';
  var model = new Example()
    ..title = "Dynamic File Path"
    ..description = 'If you return a Model_Path you can set the templates path dynamically';
  
  return new mvc.Model_Path(model, filePath);
}
```
`Model_StringTemplate` and `Model_Template` exist to provide similar features.
