import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/view/common%20widgets/text/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class Message extends StatelessWidget {
  final bool me ; 
  const Message({super.key, required this.me});

  @override
  Widget build(BuildContext context) {
        Size size = MediaQuery.of(context).size;
    return me ? 
     Container(
           constraints: BoxConstraints(maxWidth:size.width*0.5 ),
          padding: EdgeInsets.all(12),
          alignment: Alignment.topRight,
          margin: EdgeInsets.only(left: 24,bottom: 12),
            decoration: BoxDecoration(
    borderRadius: BorderRadius.only(topLeft: Radius.circular(8) ,bottomRight:Radius.circular(8) ,bottomLeft:Radius.circular(8) ),
    color: Colors.blue,
  ),
          child: AllText.Autotext(text: "hello yassinedan wdwad adadawdawdawdawda awdawd awd aw daw da d awd ad a d", fontSize: 12, fontWeight: FontWeight.normal, color: Colors.black,textAlign: TextAlign.end),
        )
    
    :
    Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5000.0),
          child: CachedNetworkImage(
            imageUrl:
                "https://hips.hearstapps.com/hmg-prod/images/beautiful-smooth-haired-red-cat-lies-on-the-sofa-royalty-free-image-1678488026.jpg?crop=1xw:0.84415xh;center,top&resize=1200:*",
            height: 30,
            width: 30,
            fit: BoxFit.cover,
          ),
        ),
        Container(
           constraints: BoxConstraints(maxWidth:size.width*0.5 ),
          padding: EdgeInsets.all(12),
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(left: 24,bottom: 12),
            decoration: BoxDecoration(
    borderRadius: BorderRadius.only(topRight: Radius.circular(8) ,bottomRight:Radius.circular(8) ,bottomLeft:Radius.circular(8) ),
    color: Color(0xFFDCDCDC),
  ),
          child: AllText.Autotext(text: "hello yassinedan wdwad adadawdawdawdawda awdawd awd aw daw da d awd ad a d", fontSize: 12, fontWeight: FontWeight.normal, color: Colors.black),
        )
      ],
    );
  }
}
