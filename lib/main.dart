import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app/core/extensions/theme_ext.dart';
import 'package:test_app/features/relations/presentation/views/relations.dart';

import 'generated/codegen_loader.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    ProviderScope(
      child: EasyLocalization(
        supportedLocales: [Locale('en')],
        path: 'assets/translations',
        fallbackLocale: Locale('en'),
        useOnlyLangCode: true,
        assetLoader: CodegenLoader(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1366, 1024),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            scaffoldBackgroundColor: Colors.white,
            listTileTheme: ListTileThemeData(
              selectedTileColor: Color.fromRGBO(28, 61, 137, 1),
              subtitleTextStyle: TextStyle(
                color: Color.fromRGBO(65, 70, 84, 1),
              ),
              contentPadding: EdgeInsetsDirectional.symmetric(
                vertical: 8.w,
                horizontal: 12.w,
              ),
              horizontalTitleGap: 12.w,
              selectedColor: Colors.white,
            ),
            extensions: [
              AppThemeExtension(
                mainDividerColor: Color.fromRGBO(0, 0, 0, 0.25),
                personImageShadowColor: Color.fromRGBO(0, 0, 0, 0.11),
                relationsListsBackgroundColor: Color.fromRGBO(250, 250, 250, 1),
                relationTypePositiveColor: Color.fromRGBO(48, 109, 85, 1),
                relationTypeNegativeColor: Color.fromRGBO(109, 60, 48, 1),
                relationTypeNeutralColor: Color.fromRGBO(48, 70, 109, 1),
                relationDragHandleColor: Color.fromRGBO(153, 165, 193, 1),
                relationBackgroundColor: Colors.white,
                peopleViewTitleColor: Color.fromRGBO(13, 34, 81, 1),
                personViewTitleColor: Color.fromRGBO(55, 55, 55, 1),
                relationsViewTitleColor: Color.fromRGBO(48, 70, 109, 1),
                relationViewTitleColor: Color.fromRGBO(28, 61, 137, 1),
              ),
            ],
          ),
          home: child,
          builder: (context, widget) {
            return MediaQuery(
              ///Setting font does not change with system font size
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: widget!,
            );
          },
        );
      },
      child: RelationsPage(),
    );
  }
}
