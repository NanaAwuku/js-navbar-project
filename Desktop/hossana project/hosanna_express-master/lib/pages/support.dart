import 'package:open_whatsapp/open_whatsapp.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Support extends StatelessWidget {
  const Support({Key? key}) : super(key: key);



  void launchWhatsapp()async{


    
    // await canLaunchUrl(url)? launchUrl(url): print("can't open whatsapp");
  }
@override
 Widget build(BuildContext context) {

  final Uri whatsapp = Uri.parse('https://wa.me/1241699096');
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: (() {
              Navigator.pop(context);
            }),
          ),
          title: Text(
            "Support",
            style: TextStyle(
                color: Colors.black, fontFamily: 'Euclid Circular B Bold'),
          ),
          elevation: 0.6,
          titleSpacing: 20.0,
          backgroundColor: Colors.white,
        ),
       body: Center(
            child: ElevatedButton(
             onPressed: (() async {
                launchUrl(whatsapp);
            }),
              child: Text('Show Flutter homepage'),
            ),
          ),
     ),
       );
 }
 }