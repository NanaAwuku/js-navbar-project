import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            "About",
            style: TextStyle(
                color: Colors.black, fontFamily: 'Euclid Circular B Bold'),
          ),
          elevation: 0.6,
          titleSpacing: 20.0,
          backgroundColor: Colors.white,
        ),
        body: Container(
     
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                 
                  top: 20,
                ),
                child:  Container(
                 
                    width: 130.0,
                    height: 130.0,
             child: Center(
              child: Image.asset(
                "assets/hosanna_icon.png",
                height: 200.0,
              ),
          ),

                  ),
              ),
                 
              Padding(
                  padding: EdgeInsets.fromLTRB(15, 40, 15, 50),
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                    style: TextStyle(fontSize: 14.0),
                  ),
                ),
              

                 ListTile(
                subtitle: Text("Version 1.0, realeased 16.12.2022",
                textAlign: TextAlign.center,),
                
               
              ),
            ]       
        ),
      ),
      ),
      ),
    );
  }
}
