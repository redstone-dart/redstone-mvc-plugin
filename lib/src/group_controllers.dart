part of redstone.mvc;

class Controller extends app.Group {
  final dynamic root;
  final String masterFilePath;
  final String masterExtension;
  final String masterSubpath;
  final bool useCustomMaster;

  const Controller(String urlPrefix, {this.useCustomMaster: false,
      this.masterExtension: "mustache", this.masterFilePath, this.masterSubpath, this.root})
      : super(urlPrefix);

  String get masterRoute {
    var extension = masterExtension;
    var filePath = masterFilePath;
    var root = buildControllerRoot(this);
    var subpath = masterSubpath != null ? masterSubpath : '';
    var localPath = urlPrefix;

    return filePath != null
        ? '$filePath.$extension'
        : '$root$localPath$subpath.$extension';
  }

  bool get includeMaster {
    return customMasterTemplate || _config.masterLocation != null;
  }

  bool get customMasterTemplate =>
    useCustomMaster || masterFilePath != null || masterSubpath != null;

  Future<Template> get masterTemplate async {
    if (customMasterTemplate) {
      var filePath = path.current + masterRoute;
      var file = new File(filePath);
      if (await file.exists()) {
        var html = await file.readAsString();
        return new Template(html, lenient: true);
      } else {
        return new Template("Template a location '$filePath' not found.",
            lenient: true);
      }
    } else {
      return _config.template;
    }
  }
}
