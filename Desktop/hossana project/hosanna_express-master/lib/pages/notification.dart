import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

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
            "Notifications",
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
                  left: 24,
                  top: 20,
                ),
                child: Text(
                  "Oct 2022",
                  style: TextStyle(
                    fontFamily: 'Euclid Circular B Bold',
                    fontSize: 16,
                  ),
                ),
              ),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.notifications_outlined),
                  backgroundColor: Colors.grey.shade300,
                  foregroundColor: Colors.black,
                ),
                title: Text("MTN Mobile Money"),
                subtitle: Text("3 Oct, 18:30"),
                trailing: Text(
                  "GHS 18.00",
                  style: TextStyle(
                    fontFamily: "Euclid Circular B Bold",
                    fontSize: 16,
                  ),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.notifications_outlined),
                  backgroundColor: Colors.grey.shade300,
                  foregroundColor: Colors.black,
                ),
                title: Text("Vodafone Cash"),
                subtitle: Text("8 Oct, 18:30"),
                trailing: Text(
                  "GHS 16.00",
                  style: TextStyle(
                      fontSize: 16, fontFamily: "Euclid Circular B Bold"),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.notifications_outlined),
                  backgroundColor: Colors.grey.shade300,
                  foregroundColor: Colors.black,
                ),
                title: Text("MTN Mobile Money"),
                subtitle: Text("10 Oct, 18:30"),
                trailing: Text(
                  "GHS 12.00",
                  style: TextStyle(
                      fontSize: 16, fontFamily: "Euclid Circular B Bold"),
                ),
                onTap: () {},
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 24,
                  top: 20,
                ),
                child: Text(
                  "Nov 2022",
                  style: TextStyle(
                    fontFamily: 'Euclid Circular B Bold',
                    fontSize: 16,
                  ),
                ),
              ),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.notifications_outlined),
                  backgroundColor: Colors.grey.shade300,
                  foregroundColor: Colors.black,
                ),
                title: Text("MTN Mobile Money"),
                subtitle: Text("1 Nov, 18:30"),
                trailing: Text(
                  "GHS 19.00",
                  style: TextStyle(
                      fontSize: 16, fontFamily: "Euclid Circular B Bold"),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.notifications_outlined),
                  backgroundColor: Colors.grey.shade300,
                  foregroundColor: Colors.black,
                ),
                title: Text("VISA Card"),
                subtitle: Text("5 Nov, 18:30"),
                trailing: Text(
                  "GHS 30.00",
                  style: TextStyle(
                      fontSize: 16, fontFamily: "Euclid Circular B Bold"),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.notifications_outlined),
                  backgroundColor: Colors.grey.shade300,
                  foregroundColor: Colors.black,
                ),
                title: Text("MTN Mobile Money"),
                subtitle: Text("9 Nov, 18:30"),
                trailing: Text(
                  "GHS 15.00",
                  style: TextStyle(
                      fontSize: 16, fontFamily: "Euclid Circular B Bold"),
                ),
                onTap: () {},
              ),
            
            ],
          ),
        ),
      ),
      ),
    );
  }
}
