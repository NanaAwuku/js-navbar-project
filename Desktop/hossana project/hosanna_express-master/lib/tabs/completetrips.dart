import 'package:flutter/material.dart';

class CompleteTrips extends StatelessWidget {
  const CompleteTrips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: Icon(Icons.local_taxi_outlined),
                  backgroundColor: Colors.grey.shade300,
                  foregroundColor: Colors.black,
                ),
                title: Text("Madina, Ritz Junc"),
                subtitle: Text("3 Oct, 18:30"),
                trailing: Text(
                  "GHS 18.00",
                  style: TextStyle(
                      fontSize: 16, fontFamily: "Euclid Circular B Bold"),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.local_taxi_outlined),
                  backgroundColor: Colors.grey.shade300,
                  foregroundColor: Colors.black,
                ),
                title: Text("Accra Mall, Accra"),
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
                  child: Icon(Icons.local_taxi_outlined),
                  backgroundColor: Colors.grey.shade300,
                  foregroundColor: Colors.black,
                ),
                title: Text("Oyarifa Mall, Accra"),
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
                  child: Icon(Icons.local_taxi_outlined),
                  backgroundColor: Colors.grey.shade300,
                  foregroundColor: Colors.black,
                ),
                title: Text("Teiman, Oyarifa Rd"),
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
                  child: Icon(Icons.local_taxi_outlined),
                  backgroundColor: Colors.grey.shade300,
                  foregroundColor: Colors.black,
                ),
                title: Text("Mataheko, Accra"),
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
                  child: Icon(Icons.local_taxi_outlined),
                  backgroundColor: Colors.grey.shade300,
                  foregroundColor: Colors.black,
                ),
                title: Text("Fots Homes, Oyarifa"),
                subtitle: Text("9 Nov, 18:30"),
                trailing: Text(
                  "GHS 15.00",
                  style: TextStyle(
                      fontSize: 16, fontFamily: "Euclid Circular B Bold"),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.local_taxi_outlined),
                  backgroundColor: Colors.grey.shade300,
                  foregroundColor: Colors.black,
                ),
                title: Text("Madina Market"),
                subtitle: Text("10 Nov, 18:30"),
                trailing: Text(
                  "GHS 10.00",
                  style: TextStyle(
                      fontSize: 16, fontFamily: "Euclid Circular B Bold"),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.local_taxi_outlined),
                  backgroundColor: Colors.grey.shade300,
                  foregroundColor: Colors.black,
                ),
                title: Text("Pantang Junc, Accra"),
                subtitle: Text("15 Nov, 18:30"),
                trailing: Text(
                  "GHS 38.00",
                  style: TextStyle(
                      fontSize: 16, fontFamily: "Euclid Circular B Bold"),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.local_taxi_outlined),
                  backgroundColor: Colors.grey.shade300,
                  foregroundColor: Colors.black,
                ),
                title: Text("Oyarifa Mall, Accra"),
                subtitle: Text("18 Nov, 18:30"),
                trailing: Text(
                  "GHS 23.00",
                  style: TextStyle(
                      fontSize: 16, fontFamily: "Euclid Circular B Bold"),
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
