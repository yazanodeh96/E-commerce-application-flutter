import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mobileshop/Home/cubit.dart';
import 'package:mobileshop/Home/state.dart';
import 'package:mobileshop/View/Home/HomeScreen.dart';
import 'package:mobileshop/services/bloc/Bloc.dart';
import 'package:easy_localization/easy_localization.dart';
// import 'Screens_view/Onboarding.dart';
import 'Utils/theme.dart';
import 'View/Onboarding/Onboarding.dart';
import 'binding.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  runApp(EasyLocalization(
      path: 'assets/Lang',
      supportedLocales: [
        Locale('en', 'US'),
        Locale('ar', 'DZ'),
      ],
      fallbackLocale: Locale('en', 'US'),
      child: MyApp()));
}
//  Locale('ar', 'DZ')

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyAppCubit(),
      child: BlocConsumer<MyAppCubit, MyAppStates>(
        builder: (context, state) {
          return GetMaterialApp(
            initialBinding: Binding(),
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: lightTheme,
            darkTheme: DarkTheme,
            home: const Onboarding(),
            themeMode: context.read<MyAppCubit>().isDark
                ? ThemeMode.dark
                : ThemeMode.light,
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
