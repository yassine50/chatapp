import 'package:auto_size_text/auto_size_text.dart';
import 'package:chatapp/backend/Tools.dart';
import 'package:chatapp/backend/fb_auth.dart';
import 'package:chatapp/backend/fb_rdb.dart';
import 'package:chatapp/model/Account.dart';
import 'package:chatapp/view/NavBar/Navbar.dart';
import 'package:chatapp/view/chatPage/chatPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool isChecked = false;
  bool login = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Container(
        margin: const EdgeInsets.only(left: 24, right: 24),
        child: Column(children: [
          Container(
            margin: EdgeInsets.only(
                top: size.height * 0.04, left: size.width * 0.03),
            child: AutoSizeText(
              textAlign: TextAlign.center,
              login ? "Welcome Back" : 'Let’s Get Started',
              style: GoogleFonts.rubik(
                textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: AutoSizeText(
              textAlign: TextAlign.center,
              login
                  ? "Please enter your email and password"
                  : 'Create a new account',
              style: GoogleFonts.rubik(
                textStyle: const TextStyle(
                    color: Color(0xFF6D7289),
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          if (!login) ...{
            Container(
                margin: EdgeInsets.only(
                  top: size.height * 0.05,
                ),
                alignment: Alignment.topLeft,
                child: AutoSizeText(
                  textAlign: TextAlign.center,
                  'Full Name',
                  style: GoogleFonts.rubik(
                    textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                )),
            Container(
              height: 50,
              width: size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  border: Border.all(color: const Color(0xFF948B8B))),
              child: TextFormField(
                cursorColor: Colors.black,
                controller: nameController,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                        left: size.width * 0.03, right: size.width * 0.03),
                    hintText: "Full Name",
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusColor: Colors.black),
              ),
            ),
          },
          Container(
              margin: EdgeInsets.only(
                top: size.height * 0.03,
              ),
              alignment: Alignment.topLeft,
              child: AutoSizeText(
                textAlign: TextAlign.center,
                'Email',
                style: GoogleFonts.rubik(
                  textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              )),
          Container(
            height: 50,
            width: size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                border: Border.all(color: const Color(0xFF948B8B))),
            child: TextFormField(
              cursorColor: Colors.black,
              controller: emailController,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                      left: size.width * 0.03, right: size.width * 0.03),
                  hintText: "Email",
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusColor: Colors.black),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: size.height * 0.03, bottom: 8),
              alignment: Alignment.topLeft,
              child: AutoSizeText(
                textAlign: TextAlign.center,
                'Password',
                style: GoogleFonts.rubik(
                  textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              )),
          Container(
            height: 50,
            width: size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                border: Border.all(color: const Color(0xFF948B8B))),
            child: TextFormField(
              obscureText: true,
              cursorColor: Colors.black,
              controller: passController,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                      left: size.width * 0.03, right: size.width * 0.03),
                  hintText: "Password",
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusColor: Colors.black),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: Row(
              children: [
                if (login) ...{
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.only(top: 16, bottom: 8),
                      child: AutoSizeText(
                        textAlign: TextAlign.center,
                        'Forget password ?',
                        style: GoogleFonts.rubik(
                          textStyle: const TextStyle(
                              color: Color(0xFF6485F4),
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  )
                } else ...{
                  Checkbox(
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  AutoSizeText(
                    textAlign: TextAlign.center,
                    "By registering, you agree to  ",
                    style: GoogleFonts.rubik(
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: AutoSizeText(
                      textAlign: TextAlign.center,
                      'Privacy Policy.',
                      style: GoogleFonts.rubik(
                        textStyle: const TextStyle(
                            color: Color(0xFF6485F4),
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  )
                }
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              if (login) {
                if (await FB_Auth()
                        .signIn(emailController.text, passController.text) ==
                    1) {
                  Account().password = passController.text;
                  Account().accountID = Tools.Cast_email(emailController.text);
                  Account().fullName = nameController.text;
                  Account().email = emailController.text;
                  Navigator.pushReplacement<void, void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => NavBar(),
                    ),
                  );
                }
                  var account = Hive.box('account');
    await account.put('user', {'name': Account().fullName,'email': Account().email,'id':Account().accountID,"password":Account().password,});
               Map acc = account.get('user');
               print(acc["email"]);
              } else {
                if ((emailController.text == "") ||
                    passController == "" ||
                    nameController == "") {
                      
                } else {
                  if (GetUtils.isEmail(emailController.text)) {
                    bool value = await FB_Auth()
                        .signUp(emailController.text, passController.text);
                    if (value) {
                      await FB_RBD().Update_Data(
                          "/Accounts/" + Tools.Cast_email(emailController.text),
                          {
                            "fullname": nameController.text,
                          });
                    } else {
                      print(value);
                    }
                  }
                }
              }
            },
            child: Container(
              margin: const EdgeInsets.only(top: 24),
              height: 48,
              width: size.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFF3053EC),
                borderRadius: BorderRadius.circular(48),
              ),
              child: AutoSizeText(
                textAlign: TextAlign.center,
                login ? "Sign In" : "Sign Up",
                style: GoogleFonts.rubik(
                    textStyle:
                        const TextStyle(height: 1.4, color: Colors.white),
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 24),
            child: AutoSizeText(
              textAlign: TextAlign.center,
              "or",
              style: GoogleFonts.rubik(
                textStyle: const TextStyle(
                    color: Color(0xFF6D7289),
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Image.asset(
                    "assets/image/google.png",
                    height: 20,
                    width: 20,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 22, right: 22),
                  alignment: Alignment.center,
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Image.asset(
                    "assets/image/facebook.png",
                    height: 20,
                    width: 20,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Image.asset(
                    "assets/image/apple.png",
                    height: 20,
                    width: 20,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  textAlign: TextAlign.center,
                  login
                      ? "Don’t have an account ?"
                      : "Already have an account ?",
                  style: GoogleFonts.rubik(
                    textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() => {login = !login});
                  },
                  child: AutoSizeText(
                    textAlign: TextAlign.center,
                    login ? " Sign up" : ' Sign In',
                    style: GoogleFonts.rubik(
                      textStyle: const TextStyle(
                          color: Color(0xFF6485F4),
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    ));
  }
}
