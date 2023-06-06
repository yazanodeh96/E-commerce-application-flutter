import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobileshop/Home/cubit.dart';
import 'package:mobileshop/Home/state.dart';
import 'package:mobileshop/View/Home/HomeScreen.dart';
import 'package:restart_app/restart_app.dart';

import '../../Reusable_Widgets/Nav_Bar.dart';
import '../Login_Signup/Loginscreen.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: 2,
      ),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 10,
        centerTitle: true,

        title: Text("Settings", style: TextStyle(color: Colors.white)).tr(),

        // actions: [IconButton(onPressed: () {}, icon: Icon(Icons.dark_mode))],
      ),
      body: ListView(children: [
        BlocConsumer<MyAppCubit, MyAppStates>(
          builder: (context, state) {
            return ListTile(
                title: Text("Change Theme").tr(),
                leading: Icon(
                  Icons.color_lens,
                  color: context.read<MyAppCubit>().isDark
                      ? Colors.white
                      : Colors.black,
                ),
                trailing: Switch(
                  value: context.read<MyAppCubit>().isDark,
                  onChanged: (v) {
                    context.read<MyAppCubit>().changeTheme();
                  },
                ));
          },
          listener: (context, state) {},
        ),
        ListTile(
          onTap: () {
            // print(EasyLocalization.of(context)!.currentLocale.toString());

            if (EasyLocalization.of(context)!.currentLocale.toString() !=
                'en_US') {
              EasyLocalization.of(context)!.setLocale(Locale('en', 'US'));
            } else {
              EasyLocalization.of(context)!.setLocale(Locale('ar', 'DZ'));
            }

            Restart.restartApp();
          },
          leading: Icon(
            Icons.language,
            color:
                context.read<MyAppCubit>().isDark ? Colors.white : Colors.grey,
          ),
          title: Text("Language").tr(),
          trailing: Icon(Icons.arrow_forward_ios_rounded),
        ),
        ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                    (route) => false);
              }).catchError((e) {});
            },
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: Text(
              "Sign Out".tr(),
              style: TextStyle(fontSize: 14, color: Colors.red),
            ))
      ]),
    );
  }
}

//  bottomNavigationBar: BottomNavigationBarWidget(
//         currentIndex: 2,
//       ),