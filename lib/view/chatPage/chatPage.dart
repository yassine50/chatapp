import 'package:chatapp/view/common%20widgets/forms/InputFild/InputFild.dart';
import 'package:chatapp/view/common%20widgets/text/text.dart';
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
        margin: const EdgeInsets.only(left: 24,right: 24,top: 24),
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
                  child: Image.asset("assets/image/messageIcon.png")),
                  AllText.Autotext(text: "Messages", fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black) ,
              ],),
             Search(controller: search, hint: 'Search', obscureText: false, size:size,),
            ],),

//             Expanded(
//               child: ListView.builder(
//   itemCount: 5,
//   itemBuilder: (context, index) {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//               Row(children: [
//           ClipRRect(
//                   borderRadius: BorderRadius.circular(30.0),
//                   child:  CachedNetworkImage(
//                             imageUrl:"https://hips.hearstapps.com/hmg-prod/images/beautiful-smooth-haired-red-cat-lies-on-the-sofa-royalty-free-image-1678488026.jpg?crop=1xw:0.84415xh;center,top&resize=1200:*",
//                             height: 32,
//                             width: 32,
//                           ),
//                 ),
              
//               ],),       
//         ],),
//       ],
//     );
//   },
// ),
//             ),
        ]),
      )
       );
  }
}