import 'package:rxdart/rxdart.dart';

class GlobalBloc {
  BehaviorSubject<int> _currentTabView$;
  BehaviorSubject<int> get currentTabView$ => _currentTabView$;

  GlobalBloc() {
    _currentTabView$ = BehaviorSubject<int>.seeded(0);
  }

  void changeHomeTab(int pageIndex) {
    _currentTabView$.add(pageIndex);
  }

  void resetView() {
    _currentTabView$.add(0);
  }

  void dispose() {
    _currentTabView$.close();
  }
}
