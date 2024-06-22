import 'package:cyberscan_parent_ui/constants/color_constants.dart';
// import 'package:cyberscan_parent_ui/presentation/home_page_two/home_page_two.dart';
import 'package:cyberscan_parent_ui/prsentation/home_page_two/home_page_two.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // backgroundColor: Colors.blue,
      //   title: Text('Home'),
      //   elevation: 0,
      // ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff1e3c72),
                  Color(0xff2a5298),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePageTwo(),
                      ),
                    );
                  },
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Color(0xff3572EF),
                      border: Border.all(
                        color: const Color.fromARGB(255, 13, 17, 49),
                        width: 3,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.qr_code_scanner,
                            size: 50,
                            color: Colors.white,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "SCAN A DEVICE",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // SizedBox(height: 30),
                //
              ],
            ),
          ),
        ],
      ),
    );
  }
}
