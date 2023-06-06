import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mobileshop/Home/cubit.dart';
import 'package:mobileshop/Home/state.dart';
import 'package:mobileshop/Utils/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mobileshop/View/Orders/myOrders.dart';
import 'package:mobileshop/model/Home_model.dart';
import 'package:mobileshop/viewModel/login/cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Reusable_Widgets/Cards.dart';
import '../../Reusable_Widgets/Nav_Bar.dart';
import '../../model/users_model.dart';
import '../Cart/Cart.dart';
import '../Login_Signup/Loginscreen.dart';
import '../Map/Map.dart';
import '../Profile/Profile.dart';
import '../Settings/Settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final _auth = FirebaseAuth.instance;
  String? email = "";
  String? image = "";
  SharedPreferences? prefs;
  int _selectedindex = 0;

  displayData() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs!.getString("email");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    displayData();
  }

  final usermodel = UserModel();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getData(),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          bottomNavigationBar: const BottomNavigationBarWidget(
            currentIndex: 0,
          ),
          appBar: PreferredSize(
            preferredSize: const Size(double.infinity, 75),
            child: AppBar(
              centerTitle: true,
              title: const Text("Mobile Shop"),
              elevation: 10,
              backgroundColor: Colors.purple,
            ),
          ),
          drawer: Drawer(
            backgroundColor:
                context.read<MyAppCubit>().isDark ? Colors.black : Colors.white,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      DrawerHeader(
                          child: Column(
                        children: [
                          const CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                                "https://www.tu-ilmenau.de/unionline/fileadmin/_processed_/0/0/csm_Person_Yury_Prof_Foto_AnLI_Footgrafie__2_.JPG_94f12fbf25.jpg"),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            email!,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: context.read<MyAppCubit>().isDark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ],
                      )),
                      Divider(
                        thickness: 1,
                        height: 1,
                        color: context.read<MyAppCubit>().isDark
                            ? Colors.white
                            : Colors.purple,
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Myprofile(),
                              ));
                        },
                        leading: Icon(
                          Icons.person,
                          color: context.read<MyAppCubit>().isDark
                              ? Colors.white
                              : Colors.black,
                        ),
                        title: Text(
                          "My Profile".tr(),
                          style: TextStyle(
                            fontSize: 14,
                            color: context.read<MyAppCubit>().isDark
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: context.read<MyAppCubit>().isDark
                              ? Colors.white
                              : Colors.black,
                          size: 20,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ));
                        },
                        leading: Icon(
                          Icons.home,
                          color: context.read<MyAppCubit>().isDark
                              ? Colors.white
                              : Colors.black,
                        ),
                        title: Text(
                          "Home".tr(),
                          style: TextStyle(fontSize: 14),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: context.read<MyAppCubit>().isDark
                              ? Colors.white
                              : Colors.black,
                          size: 20,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TheMap(),
                              ));
                        },
                        leading: Icon(
                          Icons.map_sharp,
                          color: context.read<MyAppCubit>().isDark
                              ? Colors.white
                              : Colors.black,
                        ),
                        title: Text(
                          "Map".tr(),
                          style: TextStyle(fontSize: 14),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: context.read<MyAppCubit>().isDark
                              ? Colors.white
                              : Colors.black,
                          size: 20,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Settings(),
                              ));
                        },
                        leading: Icon(
                          Icons.settings,
                          color: context.read<MyAppCubit>().isDark
                              ? Colors.white
                              : Colors.black,
                        ),
                        title: Text(
                          "Settings".tr(),
                          style: TextStyle(fontSize: 14),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: context.read<MyAppCubit>().isDark
                              ? Colors.white
                              : Colors.black,
                          size: 20,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyOrders(),
                              ));
                        },
                        leading: Icon(
                          Icons.shopping_bag_rounded,
                          color: context.read<MyAppCubit>().isDark
                              ? Colors.white
                              : Colors.black,
                        ),
                        title: Text(
                          "My Orders".tr(),
                          style: TextStyle(fontSize: 14),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: context.read<MyAppCubit>().isDark
                              ? Colors.white
                              : Colors.black,
                          size: 20,
                        ),
                      )
                    ],
                  ),
                ),
                ListTile(
                  onTap: () {
                    FirebaseAuth.instance.signOut().then((value) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()),
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
                  ),
                )
              ],
            ),
          ),
          body: BlocConsumer<HomeCubit, HomeStates>(
            builder: (context, state) {
              return ListView(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                    child: Text(
                      "Samsung Items".tr(),
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 320,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return mobilecards(
                          title: context.read<HomeCubit>().data0[index].title,
                          image: context.read<HomeCubit>().data0[index].image,
                          price: context.read<HomeCubit>().data0[index].price,
                          description: context
                              .read<HomeCubit>()
                              .data0[index]
                              .description,
                          productID:
                              context.read<HomeCubit>().data0[index].productID,
                        );
                      },
                      itemCount: context.read<HomeCubit>().data0.length,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: Row(
                        children: [
                          Text(
                            "Apple Items".tr(),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            "(5% off) ",
                            style: TextStyle(
                                fontSize: 16, color: Color(0xff4cA300)),
                          )
                        ],
                      )),
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return mobilecards(
                          title: context.read<HomeCubit>().data1[index].title,
                          image: context.read<HomeCubit>().data1[index].image,
                          price: context.read<HomeCubit>().data1[index].price,
                          description: context
                              .read<HomeCubit>()
                              .data1[index]
                              .description,
                          productID:
                              context.read<HomeCubit>().data1[index].productID,
                        );
                      },
                      itemCount: context.read<HomeCubit>().data1.length,
                    ),
                  ),
                ],
              );
            },
            listener: (context, state) {},
          ),
        ),
      ),
    );
  }
}

class FireStorageService extends ChangeNotifier {
  FireStorageService();

  static Future<dynamic> loadImage(BuildContext context, String Image) async {
    return await FirebaseStorage.instance.ref().child(Image).getDownloadURL();
  }
}
