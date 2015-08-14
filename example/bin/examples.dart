import 'package:redstone/server.dart' as app;
import 'package:redstone_mapper/mapper.dart';
import 'dart:math' as math;
/* 
 * Use 'package:redstone_mvc/redstone_mvc.dart' if didn't clone
 * redstone_mvc but copied the 'examples' folder instead.
 */
import '../../lib/redstone_mvc.dart';

main() {
  app.addPlugin(mvcPluggin);

  app.setupConsoleLog();
  app.start(port: 9090);
}

class Example {
  @Field() String title;
  @Field() String description;
}
/**
 * [View] extends [Route] so you can easy replace the routes you 
 * want to render html with a [View]. Use [template] parameter to render 
 * a simple mustache template at route '/stringTemplate' using the information
 * from the [Example] instance returned by the route function [stringTemplate].
 */
@View('/stringTemplate', template: '''
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
 * In this example we are rendering the `/example/lib/template.html` on
 * route `/fileTemplate` using an [Example] instance as a model.
 */
@View('/fileTemplate', filePath: '/example/lib/template')
fileTemplate() => new Example()
  ..title = "MVC"
  ..description = "MVC is very easy with Redstone";

/**
 * If [filePath] and your route path match, you unspecify [filePath] and
 * View will use the route path to find your template file.
 */
@View('/example/lib/template')
view() => new Example()
  ..title = "MVC"
  ..description = "MVC is very easy with Redstone";

/**
 * If the route's `urlTemplate` path doesn't take you all the way to your
 * template file, you use `subpath` to complete the remaining parts. Setting
 * `subpath` will have no effect if you specified `filePath`.
 */
@View('/example/lib', viewSubPath: '/template')
subPath() => new Example()
  ..title = "Using subpath"
  ..description = "Just appends to the path";

/**
 * Set a folder as [root] so you don't polute your route. [root] will
 * prepend to both [filePath] and your route's path, depending on which
 * is used.
 */
@View('/template', root: '/example/lib')
viewRoot() => new Example()
  ..title = "MVC"
  ..description = "MVC is very easy with Redstone";

/**
 * You can use a view controller in a [Group] since it only prepends
 * a section to your [Route]'s path. However, you might also want to
 * specify a common [root] directory to all your [filaPath]s or routes,
 * for this you can use the [Controller] annotation. [Controller]
 * extends [Group] and takes the normal [urlPrefix] as first argument and an optional
 * [root] parameters.
 */
@Controller('/info', root: '/example/lib')
class ExampleService1 {
  @View('/A')
  viewA() => new Example()
    ..title = "Route A"
    ..description = "Some description of A";

  @View('/B')
  viewB() => new Example()
    ..title = "Route B"
    ..description = "Some description of B";
}

/**
 * If you want to reuse or have more control over which html get rendered,
 * you can set a [root] in the [Controller] and [filePath] in each 
 * [View].
 * 
 * In this example, routes will be '/info2/A' and '/info2/B', but
 * for both their template is '/example/lib/template.html'.
 */
@Controller('/info2', root: '/example/lib')
class ExampleService2 {
  @View('/A', filePath: '/template')
  viewA() => new Example()
    ..title = "Route A"
    ..description = "Some description of A";

  @View('/B', filePath: '/template')
  viewB() => new Example()
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
@View('/randomTemplate', root: '/example/lib/info')
dynamicFilePath() {
  var filePath = new math.Random().nextBool() ? '/A' : '/B';
  var model = new Example()
    ..title = "Dynamic File Path"
    ..description =
    'If you return a Model_Path you can set the templates path dynamically';

  return new ViewPath(filePath, model: model);
}
