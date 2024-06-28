import 'package:cyberscan_parent_ui/prsentation/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PendingRequestPage extends StatefulWidget {
  const PendingRequestPage({super.key, required this.systemId});

  final String systemId;
  @override
  State<PendingRequestPage> createState() => _PendingRequestPageState();
}

class _PendingRequestPageState extends State<PendingRequestPage> {
  bool isNotRefreshed = true;
  bool isRefreshed = false;
  String body = "";

  Future<String> requestPending() async {
    try {
      String uri =
          "https://cybot.avanzosolutions.in/cyberscan/requestupload.php";
      var res = await http
          .post(Uri.parse(uri), body: {"requestcontroller": widget.systemId});
      body = res.body;
    } on Exception catch (e) {
      print(e);
    }
    print(body);
    return body;
  }

  Future<String> scanNow() async {
    try {
      String uri = "https://cybot.avanzosolutions.in/cyberscan/scannow.php";
      var res = await http
          .post(Uri.parse(uri), body: {"scancontroller": widget.systemId});
      body = res.body;
    } on Exception catch (e) {
      print(e);
    }
    print(body);
    return body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade900,
              Colors.blue.shade700,
              Colors.blue.shade500,
              Colors.blue.shade300,
              Colors.blue.shade100,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () async {
                String pendingReq = await requestPending();
                if (pendingReq == "success") {
                  isNotRefreshed = false;
                  isRefreshed = true;
                }

                setState(() {});
              },
              child: Center(
                child: Visibility(
                  visible: isNotRefreshed,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Refresh",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: isRefreshed,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * .95,
                    padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Request pending",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(Colors.white70),
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))))),
                      onPressed: () async {
                        String scan = await scanNow();
                        if (scan == "success") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("There is no Request pending")));
                        }
                      },
                      child: Text(
                        "Scan Now",
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
