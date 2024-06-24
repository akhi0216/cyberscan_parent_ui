import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePageTwo extends StatefulWidget {
  const HomePageTwo({super.key});

  @override
  State<HomePageTwo> createState() => _HomePageTwoState();
}

class _HomePageTwoState extends State<HomePageTwo> {
  TextEditingController systemidcontroller = TextEditingController();
  TextEditingController answercontroller = TextEditingController();
  dynamic res = "";

  @override
  void initState() {
    super.initState();
    insertsystemid();
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is disposed
    systemidcontroller.dispose();
    answercontroller.dispose();
    super.dispose();
  }

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
      ),
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: systemidcontroller,
                          // readOnly: true,

                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.2),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              suffixIcon: IconButton(
                                  onPressed: () async {
                                    String response = await insertsystemid();
                                    systemidcontroller.text = response;
                                  },
                                  icon: Icon(
                                    Icons.refresh,
                                    color: Colors.white,
                                  ))),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 10),
                      // Icon(
                      //   Icons.refresh_outlined,
                      //   color: Colors.white,
                      //   size: 30,
                      // )
                    ],
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  TextFormField(
                    controller: answercontroller,
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
                      onPressed: () {
                        // Handle submit action
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
                  // SizedBox(
                  //   height: 230,
                  //   child: ListView.separated(
                  //     shrinkWrap: true,
                  //     scrollDirection: Axis.horizontal,
                  //     itemBuilder: (context, index) {
                  //       return Container(
                  //         height: 200,
                  //         width: 200,
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.all(Radius.circular(10)),
                  //           border: Border.all(color: Colors.white, width: 3),
                  //           color: Colors.blue.shade700.withOpacity(0.5),
                  //           boxShadow: [
                  //             BoxShadow(
                  //               color: Colors.black.withOpacity(0.3),
                  //               spreadRadius: 3,
                  //               blurRadius: 5,
                  //               offset: Offset(0, 3),
                  //             ),
                  //           ],
                  //         ),
                  //         child: Center(
                  //           child: Text(
                  //             "Device ${index + 1}",
                  //             style: TextStyle(
                  //               fontWeight: FontWeight.bold,
                  //               color: Colors.white,
                  //               fontSize: 18,
                  //             ),
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //     separatorBuilder: (context, index) => SizedBox(
                  //       width: 15,
                  //     ),
                  //     itemCount: 10,
                  //   ),
                  // ),

                  // --------------------------------------grid view=====================
                  // Expanded(
                  //   child: GridView.builder(
                  //     shrinkWrap: true,
                  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //         crossAxisCount: 2,
                  //         crossAxisSpacing: 12,
                  //         mainAxisSpacing: 50,
                  //         mainAxisExtent: 150),
                  //     itemBuilder: (context, index) {
                  //       return Container(
                  //         decoration: BoxDecoration(
                  //             // color: Colors.white,
                  //             color: const Color.fromARGB(255, 209, 217, 231),
                  //             border:
                  //                 Border.all(color: Colors.blueGrey, width: 5),
                  //             borderRadius: BorderRadius.all(Radius.circular(5))),
                  //         child: Center(
                  //           child: Text("poco x3"),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                  // =================================================gggrid view end=======================================
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
