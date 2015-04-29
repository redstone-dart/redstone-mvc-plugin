import 'package:redstone/server.dart' as app;
import 'package:redstone_mvc/redstone_mvc.dart' as mvc;
import 'package:redstone_mapper/plugin.dart';
import 'package:redstone_mapper/mapper.dart';
import 'package:tuple/tuple.dart';

main ()
{
  app.addPlugin(mvc.mvcPluggin);
  app.addPlugin(getMapperPlugin());
  
  app.setupConsoleLog();
  app.start(port: 9090);
}

class Example
{
  @Field() String title;
  @Field() String description;
}

@mvc.Render('/examples/template.html')
helloMvc () => new Example()
                ..title = "MVC"
                ..description = "MVC is very easy with Redstone";

