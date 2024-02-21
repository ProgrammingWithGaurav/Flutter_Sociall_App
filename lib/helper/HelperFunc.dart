import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// display error message to user
void displayMessageToUser(String message, BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(message),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("OK"))
            ],
          ));
}

// formate date time
String formateDate(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  // year
  String year = dateTime.year.toString();
  // get month
  String month = dateTime.month.toString();
  // day
  String day = dateTime.day.toString();
  // final formatted date
  String formattedData = "$day/$month/$year";
  return formattedData;
}
