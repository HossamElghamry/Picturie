import 'package:rxdart/rxdart.dart';

class GlobalBloc {
  BehaviorSubject<int> _currentTabView$;
  BehaviorSubject<int> get currentTabView$ => _currentTabView$;

  GlobalBloc() {
    _currentTabView$ = BehaviorSubject<int>.seeded(0);
  }

  void changeHomeTab(int tabIndex) {
    switch (tabIndex) {
      case 0:
        _currentTabView$.add(0);
        break;
      case 1:
        _currentTabView$.add(1);
        break;
      case 2:
        _currentTabView$.add(2);
        break;
      case 3:
        _currentTabView$.add(3);
        break;
      default:
        _currentTabView$.add(0);
    }
  }

  void dispose() {
    _currentTabView$.close();
  }
}
