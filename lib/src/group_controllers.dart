part of redstone.mvc;


class GroupController extends app.Group {
  final String root;
  final bool ignoreMaster;
  const GroupController(String urlPrefix, {this.root, this.ignoreMaster: false})
  : super(urlPrefix);
}