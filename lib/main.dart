import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'app/core/bindings/initial_binding.dart';
import 'app/core/constraints/app_constraints.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  appHelper.setStatusBarBlack();
  await ScreenUtil.ensureScreenSize();

  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      builder: (BuildContext context, child) {
        return GetMaterialApp(
          // navigatorObservers: [LifecycleNavigatorObserver()],
          title: "Newspaper App",
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          debugShowCheckedModeBanner: false,
          initialBinding: InitialBinding(),
          builder: EasyLoading.init(),
          themeMode: ThemeMode.light,
          defaultTransition: transition,
          transitionDuration: const Duration(milliseconds: transitionDuration),
          theme: ThemeData(),
        );
      },
    ),
  );
}
