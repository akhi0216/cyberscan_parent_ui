import 'package:cyberscan_parent_ui/constants/color_constants.dart';
import 'package:cyberscan_parent_ui/prsentation/connection_req_page/connection_req_page.dart';
import 'package:cyberscan_parent_ui/prsentation/pending_req_page/pending_req_page.dart';
import 'package:cyberscan_parent_ui/prsentation/login_page/login_page.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class HomePageTwo extends StatefulWidget {
  const HomePageTwo(
      {super.key, required this.userName, required this.password});

  final String userName;
  final String password;

  @override
  State<HomePageTwo> createState() => _HomePageTwoState();
}

class _HomePageTwoState extends State<HomePageTwo> {
  TextEditingController childSystemIdController = TextEditingController();
  dynamic res = "";

  String response = "";
  String body = "";

  Future<String> insertsystemid() async {
    try {
      String uri =
          "https://cybot.avanzosolutions.in/cyberscan/select_recordscan.php";
      res = await http.get(Uri.parse(uri));
      print(res.body);
    } catch (e) {
      print(e);
    }
    String body = res.body;
    return body;
  }

  Future<String> postOP() async {
    try {
      String uri =
          "https://cybot.avanzosolutions.in/cyberscan/select_recordscan.php";
      var res = await http.post(Uri.parse(uri), body: {
        "loginusernamecontroller": widget.userName,
        "loginpasswordcontroller": widget.password,
      });
      body = res.body;
    } catch (e) {
      print(e);
    }
    print(body);
    return body;
  }

  Future<String> connect() async {
    try {
      String uri = "https://cybot.avanzosolutions.in/cyberscan/scanupload.php";
      var res = await http.post(Uri.parse(uri), body: {
        "parentcontroller": response,
        "childcontroller": childSystemIdController.text.trim(),
      });
      body = res.body;
    } catch (e) {
      print(e);
    }
    print(body);

    return body;
  }

  @override
  void initState() {
    super.initState();
    print("username: ${widget.userName}\npassword: ${widget.password}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1e3c72),
        // title: Text(

        //   'Connected Devices',
        //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        // ),
        elevation: 0,
        actions: [
          TextButton(
              onPressed: () {
                var box = Hive.box('loginBox');
                box.put('isLoggined', false);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                  (route) {
                    return false;
                  },
                );
              },
              child: Text(
                "logout",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: ColorConstants.mainGradient,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PendingRequestPage(
                              systemId: response,
                            ),
                          ));
                    },
                    child: Container(
                        padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                        width: double.infinity,
                        height: 55,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Pending Requests",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  // ============================================
                  Container(
                    padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            'System ID: $response',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            // response = await insertsystemid();
                            response = "";
                            response = await postOP();
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.refresh,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: childSystemIdController,
                    onTapOutside: (event) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    decoration: InputDecoration(
                      labelText: "Enter the system ID",
                      labelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        String connectvariable = await connect();
                        print(connectvariable);
                        connectvariable == "success"
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ConnectionRequestPage(
                                    childId:
                                        childSystemIdController.text.trim(),
                                    parentId: response,
                                  ),
                                ))
                            : ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    backgroundColor: ColorConstants.mainRed,
                                    content: Text("ID is not valid")));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade900,
                        // backgroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(fontSize: 18, color: Colors.white
                            // color: Colors.blue
                            ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Connected Devices",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10),
                  ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Text(
                          "",
                          style: TextStyle(color: Colors.white),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(
                            color: Colors.white,
                          ),
                      itemCount: 10)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
