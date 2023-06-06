import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:onboarding/onboarding.dart';

// import 'Login.dart';
import '../../Utils/utils_colors.dart';
import '../Login_Signup/Loginscreen.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  Widget dotpageView() {
    return Builder(builder: ((context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < 3; i++)
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: i == Pagenumber
                      ? hexStringToColor("CB2B93")
                      : Colors.white,
                  border: i == Pagenumber
                      ? Border.all(color: hexStringToColor("CB2B93"))
                      : Border.all(color: hexStringToColor("CB2B93"))),
            )
        ],
      );
    }));
  }

  PageController nextpage = PageController();
  int Pagenumber = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("CB2B93"),
          hexStringToColor("9546C4"),
          hexStringToColor("5E61F4")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: PageView(
          onPageChanged: (value) {
            setState(() {
              Pagenumber = value;
            });
          },
          controller: nextpage,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 90,
                ),
                Container(
                  height: 250,
                  width: 250,
                  child: Image.asset(
                    'assets/images/MobileShopLogo2.png',
                    fit: BoxFit.fill,
                    color: Colors.white,
                  ),
                ),
                // Text(
                //   'Mobile Shop',
                //   style: TextStyle(
                //       fontSize: 20,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.white70),
                // ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Welcome to our App',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                dotpageView(),
                SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: () {
                    nextpage.animateToPage(1,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                  },
                  child: Container(
                    width: 146,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        'Next',
                        style: TextStyle(color: Colors.purple, fontSize: 14),
                      ).tr(),
                    ),
                  ),
                ),
              ],
            ),
            // Page 2
            Column(
              children: [
                SizedBox(
                  height: 75,
                ),
                Container(
                    height: 250,
                    width: 250,
                    child: Image.asset(
                      'assets/images/Signup.gif',
                      fit: BoxFit.fill,
                    )),
                Text(
                  'REGISTER ',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Download , Sign Up , BUY ',
                  style: TextStyle(fontSize: 15, color: Colors.white70),
                ),
                SizedBox(
                  height: 50,
                ),
                dotpageView(),
                SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: () {
                    nextpage.animateToPage(2,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                  },
                  child: Container(
                    width: 146,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        'Next',
                        style: TextStyle(color: Colors.purple, fontSize: 14),
                      ).tr(),
                    ),
                  ),
                ),
              ],
            ),
            //Page 3
            Column(
              children: [
                SizedBox(
                  height: 75,
                ),
                Container(
                    height: 250,
                    width: 250,
                    child: Image.asset(
                      'assets/images/onboarding1.gif',
                      fit: BoxFit.fill,
                    )),
                Text(
                  'ORDER ONLINE',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Make an order from your Home ',
                  style: TextStyle(fontSize: 15, color: Colors.white70),
                ),
                SizedBox(
                  height: 50,
                ),
                dotpageView(),
                SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: 146,
                    height: 48,
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(5),
                    //   color: Colors.white,
                    // ),
                    child: Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white, minimumSize: Size(300, 50)),
                        child: Text(
                          'Get Started',
                          style: TextStyle(color: Colors.purple),
                        ).tr(),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()));
                        },
                      ),
                      // child: Text(

                      //   'Get Started',
                      //   style: TextStyle(color: Colors.white, fontSize: 14),

                      // ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
