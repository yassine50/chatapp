import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/view/common%20widgets/forms/InputFild/InputFild.dart';
import 'package:chatapp/view/common%20widgets/text/text.dart';
import 'package:chatapp/view/messagePage/MessagePage.dart';
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
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(left: 24,right: 24,top: 26),
        child: Column(
          children:  [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Row(children: [
                Container(
                  margin: EdgeInsets.only(right: 8),
                  height: 24 ,
                  width: 24 ,
                  child: Icon(Icons.message,color: Colors.blueAccent,)
                  // Image.asset("assets/image/messageIcon.png")
                  ),
                  AllText.Autotext(text: "Messages", fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black) ,
              ],),
             Search(controller: search, hint: 'Search', obscureText: false, size:size,),
            ],),
            SizedBox(height: size.height*0.04,),

            Expanded(
              child: ListView.builder(
  itemCount: 5,
  itemBuilder: (context, index) {
    return Column(
      children: [
        GestureDetector(
          onTap:  () {
              Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => MessagePage()),
  );
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  Row(children: [
              Hero(
                tag: "user"+index.toString(),
                child: ClipRRect(
                        borderRadius: BorderRadius.circular(5000.0),
                        child:  CachedNetworkImage(
                                  imageUrl:"https://hips.hearstapps.com/hmg-prod/images/beautiful-smooth-haired-red-cat-lies-on-the-sofa-royalty-free-image-1678488026.jpg?crop=1xw:0.84415xh;center,top&resize=1200:*",
                                  height: 45,
                                  width: 45,
                                 fit: BoxFit.cover,
                                ),
                      ),
              ),
                  Container(
                    margin: EdgeInsets.only(left: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      AllText.Autotext(text: "yassine", fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
                       AllText.Autotext(text: "where are you ? ", fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey)
                    ],),
                  )
                  ],),       
       AllText.Autotext(text: "Today", fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)
       
            ],),
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
),
            ),
        ]),
      )
       );
  }
}