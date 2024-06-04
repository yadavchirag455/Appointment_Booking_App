import 'dart:developer';
import 'package:appointment_app/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminBooking extends StatefulWidget {
  const AdminBooking({super.key});

  @override
  State<AdminBooking> createState() => _AdminBookingState();
}

class _AdminBookingState extends State<AdminBooking> {
  getonTheLoad() async {
    BookingStream = await Databasemethods().getBookingDetails();

    setState(() {});
  }

  Stream? BookingStream;

  Widget allBookings() {
    return StreamBuilder(
        stream: BookingStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];

                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color(0xFFB91635),
                            Color(0xff621d3c),
                            Color(0xFF311937)
                          ]),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Service: ${ds["Services"]}',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white70),
                          ),
                          Text(
                            'Name:${ds["userName"]}',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white70),
                          ),
                          Text(
                            'Email: ' + ds["email"],
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white70),
                          ),
                          Text(
                            'Date: ' + ds["Date"],
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white70),
                          ),
                          Text(
                            'Time: ${ds["Time"]}',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white70),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () async {
                                    log('Tapped // Done TextButton // on the Admin Booking Page');

                                    await Databasemethods()
                                        .deletUserBooking(ds.id);
                                  },
                                  child: Text(
                                    "Done",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white70),
                                  ))
                            ],
                          )
                        ],
                      ),
                    );
                  })
              : Container(
                  child: Text(
                    'No Booking are There',
                    style: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getonTheLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50, right: 20, left: 20),
        child: Column(
          children: [
            Center(
              child: Text(
                'All Bookings',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            // Container(
            //   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            //   width: MediaQuery.of(context).size.width,
            //   decoration: BoxDecoration(
            //       gradient: LinearGradient(colors: [
            //         Color(0xFFB91635),
            //         Color(0xff621d3c),
            //         Color(0xFF311937)
            //       ]),
            //       borderRadius: BorderRadius.circular(10)),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         'Service: Hair Cutting',
            //         style: TextStyle(
            //             fontSize: 20,
            //             fontWeight: FontWeight.w500,
            //             color: Colors.white70),
            //       ),
            //       Text(
            //         'Name: Heet',
            //         style: TextStyle(
            //             fontSize: 20,
            //             fontWeight: FontWeight.w500,
            //             color: Colors.white70),
            //       ),
            //       Text(
            //         'Email: test@gmail.com',
            //         style: TextStyle(
            //             fontSize: 20,
            //             fontWeight: FontWeight.w500,
            //             color: Colors.white70),
            //       ),
            //       Text(
            //         'Date: -----------',
            //         style: TextStyle(
            //             fontSize: 20,
            //             fontWeight: FontWeight.w500,
            //             color: Colors.white70),
            //       ),
            //       Text(
            //         'Time: -----------',
            //         style: TextStyle(
            //             fontSize: 20,
            //             fontWeight: FontWeight.w500,
            //             color: Colors.white70),
            //       ),
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.end,
            //         children: [
            //           TextButton(
            //               onPressed: () {
            //                 log('Tapped // Done TextButton // on the Admin Booking Page');
            //               },
            //               child: Text(
            //                 "Done",
            //                 style: TextStyle(
            //                     fontSize: 16,
            //                     fontWeight: FontWeight.bold,
            //                     color: Colors.white70),
            //               ))
            //         ],
            //       )
            //     ],
            //   ),
            // )
            SizedBox(
              height: 20,
            ),

            Expanded(child: allBookings()),
          ],
        ),
      ),
    );
  }
}
