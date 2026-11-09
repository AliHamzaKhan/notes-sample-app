import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../features/crud/binding/crud_binding.dart';
import '../features/crud/view/crud_view.dart';
import '../features/home/binding/home_binding.dart';
import '../features/home/view/home_view.dart';
import '../features/search/view/search_view.dart';

abstract final class AppRoutes {
  static const root = '/';
  static const home = '/home';
  static const crud = '/crud';
  static const search = '/search';

  static String withId(String route, String? id) =>
      id == null ? route : '$route?id=${Uri.encodeQueryComponent(id)}';
}

List<GetPage<void>> appPages() => [
  _shellPage(name: AppRoutes.root, page: () => const SizedBox.shrink()),
  _shellPage(
    name: AppRoutes.home,
    page: () => const HomeView(),
    binding: HomeBinding(),
  ),
  _shellPage(name: AppRoutes.crud, page: () => const CrudView(), binding : CrudBinding()),
  _shellPage(name: AppRoutes.search, page: () =>  SearchView()),
];

GetPage<void> _shellPage({
  required String name,
  required Widget Function() page,
  binding,
}) => GetPage(
  name: name,
  page: () => page(),
  transition: Transition.noTransition,
  binding: binding,
);

final unknownPage = GetPage<void>(
  name: '/not-found',
  page: () => Scaffold(
    appBar: AppBar(title: const Text('Not found')),
    body: const Center(child: Text('This screen does not exist.')),
  ),
);
