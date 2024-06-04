import 'dart:developer';
import 'package:appointment_app/services/database.dart';
import 'package:flutter/material.dart';

import '../services/shared_pref.dart';

class Booking extends StatefulWidget {
  Booking({required this.service});
  String service;

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        firstDate: DateTime(2024),
        lastDate: DateTime(2030),
        initialDate: _selectedDate);

    if (picked != null && picked != _selectedDate) {
      _selectedDate = picked;
      setState(() {});
    }
  }

  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: _selectedTime);

    if (picked != null && picked != _selectedTime) {
      _selectedTime = picked;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    onTheLoad();
  }

  onTheLoad() async {
    await getDataFromSharedPref();
    log(name!);
    log(email!);
    // log(id!);
  }

  getDataFromSharedPref() async {
    // id = await SharedPreferanceHelper().getUserId();
    email = await SharedPreferanceHelper().getUserEmail();
    name = await SharedPreferanceHelper().getUserDisplayName();
    setState(() {});
  }

  String? name, email;
  // , id

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2b1615),
      body: Container(
        margin: EdgeInsets.only(left: 12, right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                log('Back button icons is tapped on the booking page');
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsets.only(top: 50),
                child: Icon(
                  Icons.arrow_back, size: 30,

                  // color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Let\'s play \nwith your hairs',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.white60),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Image.asset('images/discount.png'),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              widget.service,
              style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              // height: 150,
              decoration: BoxDecoration(
                  color: Color(0xffb4817e),
                  borderRadius: BorderRadius.circular(20)),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Text(
                    'Set a Date',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: Icon(Icons.calendar_month)),
                      Text(
                        '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              // height: 150,
              decoration: BoxDecoration(
                  color: Color(0xffb4817e),
                  borderRadius: BorderRadius.circular(20)),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Text(
                    'Select Time',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                            _selectTime(context);
                          },
                          child: Icon(Icons.watch_later_outlined)),
                      Text(
                        _selectedTime.format(context),
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () async {
                log('tapped //  Book Now button // booking page ');

                Map<String, dynamic> usersBookingInfoMap = {
                  "Services": widget.service,
                  "Date":
                      "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}"
                          .toString(),
                  "Time": _selectedTime.format(context).toString(),
                  "userName": name,
                  "email": email
                };

                await Databasemethods()
                    .addUserBooking(usersBookingInfoMap)
                    .then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                    'Booking Done bro',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )));
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                decoration: BoxDecoration(
                    color: Color(0xfffe8f33),
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Text(
                    'Book Now',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
