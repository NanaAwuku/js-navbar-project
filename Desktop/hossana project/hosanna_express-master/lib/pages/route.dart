import 'package:flutter/material.dart';
import 'package:hosanna_shuttle/model/history_model.dart';

class Routes extends StatefulWidget {
  const Routes({Key? key}) : super(key: key);

  @override
  State<Routes> createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  final List<HistoryModel> historyDummy = [
    HistoryModel(
      rideId: "1234",
      source: "Madina, Ritz Junc",
      destination: "Fots Homes, Oyarifa",
      time: "Today 11:41 pm",
    ),
    HistoryModel(
      rideId: "6789",
      source: "Mataheko, Accra",
      destination: "API Technologie",
      time: "Today 1:41 pm",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Route Finding",
          style: TextStyle(
              color: Colors.black, fontFamily: 'Euclid Circular B Bold'),
        ),
        elevation: 0.6,
        titleSpacing: 20.0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                elevation: 10.0,
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          // Icon(Icons.my_location_outlined),
                          SizedBox(
                            height: 5.0,
                          ),
                          Image.asset(
                            "assets/originDestinationDistanceIcon.png",
                            fit: BoxFit.cover,
                            height: 80,
                          ),
                          // Icon(Icons.my_location_outlined),
                        ],
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(historyDummy[index].source),
                            SizedBox(
                              height: 30.0,
                            ),
                            Text(historyDummy[index].destination),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(historyDummy[index].time),
                          SizedBox(
                            height: 10.0,
                          ),
                          ElevatedButton(
                            child: Text("View"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              padding: EdgeInsets.all(4.0),
                              textStyle: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                              // side: BorderSide(
                              //   color: Colors.black87,
                              //   width: 4,
                              // ),
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          itemCount: historyDummy.length,
        ),
      ),
    );
  }
}
