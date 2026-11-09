import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_notes_app/app/routes.dart';
import '../core/theme/app_theme.dart';
import 'bindings/app_binding.dart';

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Notes App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.dark,
      initialRoute: AppRoutes.home,
      initialBinding: InitialBinding(),
      getPages: appPages(),
      unknownRoute: unknownPage,
      defaultTransition: Transition.fadeIn,
    );
  }
}
