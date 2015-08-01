part of redstone.mvc;


class Controller extends app.Group {
  final String root;
  final bool ignoreMaster;
  const Controller(String urlPrefix, {this.root, this.ignoreMaster: false})
  : super(urlPrefix);
}