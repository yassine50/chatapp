import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/view/common%20widgets/forms/InputFild/InputFild.dart';
import 'package:chatapp/view/common%20widgets/forms/InputFild/sendMessage.dart';
import 'package:chatapp/view/common%20widgets/text/text.dart';
import 'package:chatapp/view/messagePage/widget/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  TextEditingController message  = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 24,right: 24,top: 26),
          child: Column(
            children:  [
              Container(     
                child: Row(         
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        child:Icon(Icons.arrow_back_ios_new),
                         ),
                    ),
                      SizedBox(width: size.width*0.08,),
                      Container(
                      margin: EdgeInsets.only(right: 8),
                      height: 45 ,
                      width: 45 ,
                      child:  Hero(
                        tag: "user0",
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
                      // Image.asset("assets/image/messageIcon.png")
                      ),
                     SizedBox(width: size.width*0.08,),
                      AllText.Autotext(text: "Yassine", fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black) ,
                  ],),
              ),
              Container(
          margin: EdgeInsets.only(bottom: 12,top: 12),
          height: 1,
          width: size.width,
          color: Colors.grey,
        ),
              // SizedBox(height: size.height*0.04,),
              Expanded(
                child:ListView.builder(
  itemCount: 5,
  itemBuilder: (context, index) {
    return Message(me: true,);
  },
),
           
              ),
         SendMessage(controller: message, hint: 'type your message here', obscureText: false, size: size,)
        
          ]),
        )
         ),
    );
  }
}