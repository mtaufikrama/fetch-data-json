part of 'app_pages.dart';
// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const CREATE = _Paths.CREATE;
  static String EDIT(int id) => '/edit/$id';
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const CREATE = '/create';
  static const EDIT = '/edit/:id';
}
