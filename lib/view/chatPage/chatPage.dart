import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/backend/Tools.dart';
import 'package:chatapp/backend/fb_rdb.dart';
import 'package:chatapp/backend/fb_storage.dart';
import 'package:chatapp/model/Account.dart';
import 'package:chatapp/model/users.dart';
import 'package:chatapp/view/common%20widgets/forms/InputFild/InputFild.dart';
import 'package:chatapp/view/common%20widgets/text/text.dart';
import 'package:chatapp/view/messagePage/MessagePage.dart';
import 'package:chatapp/view/messagePage/widget/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Chatpage extends StatefulWidget {
  const Chatpage({super.key});

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  TextEditingController search = TextEditingController();
  final DatabaseReference _messagesRef =
      FirebaseDatabase.instance.reference().child("/Accounts/");
  List<Users> users = [];
  getPhoto(String id, int index,verif) async {
    if (users[index].photo == "") {
      FB_RBD fb = FB_RBD();
       print(id);
      if (verif == true) {
        FB_Storage storage = FB_Storage();
        users[index].photo = await storage.Get_file(id + "_profilepic.jpg");
        return users[index].photo;
      } else {
        users[index].photo = "false";
        return null;
      }
    } else {
      return users[index].photo;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Container(
      margin: const EdgeInsets.only(left: 24, right: 24, top: 26),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                    margin: EdgeInsets.only(right: 8),
                    height: 24,
                    width: 24,
                    child: Icon(
                      Icons.message,
                      color: Colors.blueAccent,
                    )
                    // Image.asset("assets/image/messageIcon.png")
                    ),
                AllText.Autotext(
                    text: "Messages",
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ],
            ),
            Search(
              controller: search,
              hint: 'Search',
              obscureText: false,
              size: size,
            ),
          ],
        ),
        SizedBox(
          height: size.height * 0.04,
        ),
        Expanded(
          child: StreamBuilder(
            stream: _messagesRef.onValue,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                DatabaseEvent data = snapshot.data as DatabaseEvent;
                if (data.snapshot.value != null && data.snapshot.value is Map) {
                  (data.snapshot.value as Map<dynamic, dynamic>)
                      .entries
                      .map((entry) {
                    Users user = Users();
                    user.name = entry.value["fullname"];
                    user.id = entry.key;
                    user.AllowProfilePic = entry.value["Allow_profile_pic"] ; 
                    users.add(user);
                  }).toList();
                  // messages.sort((a, b) =>
                  //     b.TimeStamp.compareTo(a.TimeStamp));
                }
                return ListView.builder(
                  itemCount:users.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MessagePage(user: users[index],)),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Hero(
                                      tag: users[index].id,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5000.0),
                                          child: FutureBuilder(
                                              future: getPhoto(users[index].id, index,users[index].AllowProfilePic),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  return Container(
                                                    height: 34,
                                                    width: 34,
                                                    child: snapshot.data
                                                                    .toString() ==
                                                                "" ||
                                                            snapshot.data
                                                                    .toString() ==
                                                                "false"
                                                        ? Image.asset(
                                                            'assets/image/profilepicture1.png',
                                                            height: 45,
                                                            width: 45,
                                                            fit: BoxFit.cover,
                                                          )
                                                        : ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        500),
                                                            child:
                                                                CachedNetworkImage(
                                                              height: 45,
                                                              width: 45,
                                                              fit: BoxFit.cover,
                                                              imageUrl: snapshot
                                                                  .data
                                                                  .toString(),
                                                            ),
                                                          ),
                                                  );
                                                } else if (snapshot.hasError) {
                                                  return Container(
                                                    height: 34,
                                                    width: 34,
                                                    child: Image.asset(
                                                      'assets/image/profilepicture1.png',
                                                      height: 45,
                                                      width: 45,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  );
                                                }
                                                return Container(
                                                  height: 34,
                                                  width: 34,
                                                  child: Image.asset(
                                                    'assets/image/profilepicture1.png',
                                                    height: 45,
                                                    width: 45,
                                                    fit: BoxFit.cover,
                                                  ),
                                                );
                                              })),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AllText.Autotext(
                                              text: users[index].name,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                          AllText.Autotext(
                                              text: "where are you ? ",
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey)
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                AllText.Autotext(
                                    text: "Today",
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey)
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 12),
                          height: 1,
                          width: size.width,
                          color: Colors.grey,
                        )
                      ],
                    );
                  },
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ]),
    ));
  }
}
