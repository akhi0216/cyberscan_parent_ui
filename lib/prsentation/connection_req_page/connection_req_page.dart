import 'package:cyberscan_parent_ui/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ConnectionRequestPage extends StatefulWidget {
  const ConnectionRequestPage(
      {super.key, required this.childId, required this.parentId});

  final String childId;
  final String parentId;

  @override
  State<ConnectionRequestPage> createState() => _ConnectionRequestPageState();
}

class _ConnectionRequestPageState extends State<ConnectionRequestPage> {
  Future<String> refresh() async {
    String body = "";
    try {
      String url =
          "https://cybot.avanzosolutions.in/cyberscan/parentverify.php";
      var res = await http.post(Uri.parse(url), body: {
        "activecontroller": widget.childId,
      });
      body = res.body;
    } on Exception catch (e) {
      print(e);
    }
    print(body);
    return body;
  }

  String active = "";

  bool isNotRefreshed = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            //  color: Colors.blue[300],
            gradient: ColorConstants.mainGradient,
          ),
          child: isNotRefreshed
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width * .95,
                      decoration: BoxDecoration(
                        gradient: ColorConstants.containerGradient,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Scanning is initialized",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                        onPressed: () async {
                          active = await refresh();
                          isNotRefreshed = false;
                          setState(() {});
                        },
                        child: Text("Refresh"))
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("scanning......"),
                  ],
                ),
        ),
      ),
    );
  }
}
