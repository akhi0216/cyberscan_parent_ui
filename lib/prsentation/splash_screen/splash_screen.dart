import 'package:cyberscan_parent_ui/prsentation/home_page_two/home_page_two.dart';
import 'package:cyberscan_parent_ui/prsentation/login_page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    var box = Hive.box('loginBox');
    Future.delayed(Duration(seconds: 2)).then(
      (value) {
        if (box.get('isLoggined', defaultValue: false)) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePageTwo(),
              ));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ));
        }
      },
    );
  }

  splashFunction() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("CyberScan"),
      ),
    );
  }
}
