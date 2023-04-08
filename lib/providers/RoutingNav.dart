import 'package:flutter/widgets.dart';

class RoutingNav extends ChangeNotifier {
  int pageIndex = 0;
  late PageController pageController;

  RoutingNav() {
    pageController = PageController();
  }

  setPageIndex(index) {
    pageIndex = index;
    notifyListeners();
  }
}
