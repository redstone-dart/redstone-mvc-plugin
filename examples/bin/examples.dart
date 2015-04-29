import 'package:redstone/server.dart' as app;
import 'package:redstone_mapper/mapper.dart';
import 'dart:math' as math;
/* 
 * Use 'package:redstone_mvc/redstone_mvc.dart' if didn't clone
 * redstone_mvc but copied the 'examples' folder instead.
 */
import '../../lib/redstone_mvc.dart' as mvc;

main() {
  app.addPlugin(mvc.mvcPluggin);

  app.setupConsoleLog();
  app.start(port: 9090);
}

class Example {
  @Field() String title;
  @Field() String description;
}
/**
 * [ViewController] extends [Route] so you can easy replace the routes you 
 * want to render html with a [ViewController]. Use [template] parameter to render 
 * a simple mustache template at route '/stringTemplate' using the information
 * from the [Example] instance returned by the route function [stringTemplate].
 */
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

/**
 * Normally you want to render an html file template. Use the [filePath] parameter
 * to specify the path of your file. By default it will its a .html file, if
 * you need a diferent extension, use the [extension] parameter to specify it.
 * 
 * In this example we are rendering the `/examples/lib/template.html` on
 * route `/fileTemplate` using an [Example] instance as a model.
 */
@mvc.ViewController('/fileTemplate', filePath: '/examples/lib/template')
fileTemplate() => new Example()
  ..title = "MVC"
  ..description = "MVC is very easy with Redstone";

/**
 * If [filePath] and your route path match, you unspecify [filePath] and
 * ViewController will use the route path to find your template file.
 */
@mvc.ViewController('/examples/lib/template')
viewController() => new Example()
  ..title = "MVC"
  ..description = "MVC is very easy with Redstone";

/**
 * If the route's `urlTemplate` path doesn't take you all the way to your
 * template file, you use `subpath` to complete the remaining parts. Setting
 * `subpath` will have no effect if you specified `filePath`.
 */
@mvc.ViewController ('/examples/lib', subpath: '/template')
subPath() => new Example()
  ..title = "Using subpath"
  ..description = "Just appends to the path";

/**
 * Set a folder as [root] so you don't polute your route. [root] will
 * prepend to both [filePath] and your route's path, depending on which
 * is used.
 */
@mvc.ViewController('/template', root: '/examples/lib')
viewControllerRoot() => new Example()
  ..title = "MVC"
  ..description = "MVC is very easy with Redstone";

/**
 * You can use a view controller in a [Group] since it only prepends
 * a section to your [Route]'s path. However, you might also want to
 * specify a common [root] directory to all your [filaPath]s or routes,
 * for this you can use the [ControllerGroup] annotation. [ControllerGroup]
 * extends [Group] and takes [root] as a first argument, and the normal
 * [urlPrefix] as second argument. Your normal complete path to file will
 * be [root] + [urlPrefix] + [urlTemplate], where urlTemplate is your
 */
@mvc.ControllerGroup ('/examples/lib', '/info')
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

/**
 * If you want to reuse or have more control over which html get rendered,
 * you can set a [root] in the [ControllerGroup] and [filePath] in each 
 * [ViewController].
 * 
 * In this example, routes will be '/info2/A' and '/info2/B', but
 * for both their template is '/examples/lib/template.html'.
 */
@mvc.ControllerGroup ('/examples/lib', '/info2')
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

/**
 * You can set the [filePath] dynamically at runtime by returning a
 * [Model_Path]. [Model_Path] takes an [Object model], [String path] and
 * optionally a [String extension] that defualts to 'html'.
 * 
 * [Model_StringTemplate] and [Model_Template] exist to provide similar
 * features.
 */
@mvc.ViewController ('/randomTemplate', root: '/examples/lib/info')
dynamicFilePath ()
{
  var filePath = new math.Random().nextBool() ? '/A' : '/B';
  var model = new Example()
    ..title = "Dynamic File Path"
    ..description = 'If you return a Model_Path you can set the templates path dynamically';
  
  return new mvc.Model_Path(model, filePath);
}
