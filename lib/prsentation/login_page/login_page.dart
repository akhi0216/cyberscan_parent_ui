import 'package:cyberscan_parent_ui/prsentation/home_page_two/home_page_two.dart';
import 'package:cyberscan_parent_ui/prsentation/register_page/register_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController loginusernamecontroller = TextEditingController();
  TextEditingController loginpasswordcontroller = TextEditingController();

  String userName = "";
  String password = "";
  // bool isChecked = false;
  bool passwordObscure = true;

  bool isLoggedin = true;
  //2late Box box1;
  Future<void> insertrecord() async {
    if (loginusernamecontroller.text.isNotEmpty &&
        loginpasswordcontroller.text.isNotEmpty) {
      try {
        String uri =
            "https://cybot.avanzosolutions.in/cyberscan/insert_recordscanlogin.php";
        var res = await http.post(Uri.parse(uri), body: {
          "loginusernamecontroller": loginusernamecontroller.text,
          "loginpasswordcontroller": loginpasswordcontroller.text
        });
        print(res.body);
        var response = "success";
        var resp = "WRONG CREDENTIALS";

        if (res.body == response) {
          print("Record inserted");
          // Save the login state and credentials
          // box1.put('isLoggedIn', true);
          // if (isChecked) {
          //   box1.put('email', loginusernamecontroller.text);
          //   box1.put('pass', loginpasswordcontroller.text);
          // }
          userName = loginusernamecontroller.text.trim();
          password = loginpasswordcontroller.text.trim();
          var box = Hive.box('loginBox');
          box.put('isLoggined', true);
          box.put('userName', userName);
          box.put('password', password);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Login Successfully",
                style: TextStyle(color: Colors.blue),
              ),
              duration: Duration(milliseconds: 1500),
            ),
          );
          Future.delayed(Duration(milliseconds: 1500), () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePageTwo(
                          userName: userName,
                          password: password,
                        )),
                (route) => false);
          });
          loginpasswordcontroller.clear();
          loginusernamecontroller.clear();
        } else if (res.body == resp) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Login Unsuccessful",
                style: TextStyle(color: Colors.red),
              ),
              duration: Duration(seconds: 2),
            ),
          );
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("Please fill all fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://i.pinimg.com/564x/20/06/ca/2006caf34cf7b8b08e12acc0340d1b5e.jpg"),
                fit: BoxFit.cover)),
        // Image.network(
        //   "https://i.pinimg.com/564x/20/06/ca/2006caf34cf7b8b08e12acc0340d1b5e.jpg",
        //   fit: BoxFit.fitHeight,
        // ),
        // Container(
        //   color: Colors.black.withOpacity(0.5),
        // ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Spacer(),
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [Colors.blue, Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                child: Text(
                  'Hello, Welcome!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors
                        .white, // This color is not shown due to ShaderMask
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: loginusernamecontroller,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.3),
                  hintText: 'username',
                  hintStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.person, color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: loginpasswordcontroller,
                obscureText: true,
                obscuringCharacter: "*",
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.3),
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock, color: Colors.white),
                  suffixIcon: IconButton(
                    icon: Icon(
                      passwordObscure ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        passwordObscure = !passwordObscure;
                      });
                    },
                  ),
                  hintStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  // prefixIcon: Icon(Icons.lock, color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  insertrecord();
                  // Handle login action
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => HomePage(),
                  //     ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.blue, fontSize: 18),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "create an account,",
                    style: TextStyle(color: Colors.blue),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterPage(),
                            ));
                      },
                      child: Text(
                        "sign up!",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
              Spacer(),
              Spacer(),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
