import 'package:flutter/widgets.dart';
import './ghost_content_api_client.dart';

class GhostContentAPIProvider extends InheritedWidget {
  final GhostContentAPIClient client;
  final Widget child;

  GhostContentAPIProvider({
    @required this.client,
    @required this.child,
  });

  static GhostContentAPIClient of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<GhostContentAPIProvider>()).client;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}
