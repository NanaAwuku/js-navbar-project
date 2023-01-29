import 'package:flutter/material.dart';
import 'package:hosanna_shuttle/tabs/alltrips.dart';

class Transactions extends StatelessWidget {
  const Transactions({Key? key}) : super(key: key);

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
            "Billing",
            style: TextStyle(
                color: Colors.black, fontFamily: 'Euclid Circular B Bold'),
          ),
          elevation: 0.6,
          titleSpacing: 20.0,
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: [
           
            Expanded(
              child: TabBarView(
                children: [
                  // All Trips Tab
                  Alltrips(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
