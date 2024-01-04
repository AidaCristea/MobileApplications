import 'dart:developer';

import 'package:flutter/material.dart';

import '../Expense.dart';
//import 'package:smart_fin_flutter/Expense.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();

  bool isValidDate(date) {
    try {
      DateTime.parse(date);
    } catch (e) {
      return false;
    }
    return true;
  }

  String titleVal = "";
  String descriptionVal = "";
  String amountVal = "";
  String categoryVal = "";
  String dateVal = "";
  String payment_methodVal = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        title: Row(
          children: [
            Text(
              "SmartFin",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(width: 9.0),
            Image(
              image: AssetImage("assets/flying-money-4385660-3640566.png"),
              width: 75,
              height: 75,
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.green[200],
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: Text(
                        "Create expense",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 310, 0),
                  child: Text(
                    "Title",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: SizedBox(
                    width: 370,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Fill up all the fields!";
                        } else
                          return null;
                      },
                      onChanged: (value) => titleVal = value,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.green[50],
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 21,
                        ),
                        hintText: 'Title...',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 250, 0),
                  child: Text(
                    "Description",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: SizedBox(
                    width: 370,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Fill up all the fields!";
                        } else
                          return null;
                      },
                      onChanged: (value) => descriptionVal = value,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.green[50],
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 21,
                        ),
                        hintText: 'Description...',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 280, 0),
                  child: Text(
                    "Amount",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: SizedBox(
                    width: 370,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Fill up all the fields!";
                        } else
                          return null;
                      },
                      onChanged: (value) => amountVal = value,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.green[50],
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 21,
                        ),
                        hintText: 'Amount...',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 270, 0),
                  child: Text(
                    "Category",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: SizedBox(
                    width: 370,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Fill up all the fields!";
                        } else
                          return null;
                      },
                      onChanged: (value) => categoryVal = value,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.green[50],
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 21,
                        ),
                        hintText: 'Category...',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 310, 0),
                  child: Text(
                    "Date",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: SizedBox(
                    width: 370,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Add some text";
                        } else if (!isValidDate(value)) {
                          return "For the date use the format: yyyy-MM-dd";
                        } else
                          return null;
                      },
                      onChanged: (value) => dateVal = value,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.green[50],
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 21,
                        ),
                        hintText: 'Date...',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 190, 0),
                  child: Text(
                    "Payment Method",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: SizedBox(
                    width: 370,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Fill up all the fields!";
                        } else
                          return null;
                      },
                      onChanged: (value) => payment_methodVal = value,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.green[50],
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 21,
                        ),
                        hintText: 'Payment method...',
                      ),
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(50, 10, 0, 0),
                        child: SizedBox(
                          width: 120,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () => {
                              log("Save button pressed"),
                              if (_formKey.currentState!.validate())
                                {
                                  Navigator.pop(
                                      context,
                                      Expense(
                                          title: titleVal,
                                          description: descriptionVal,
                                          amount: int.parse(amountVal),
                                          category: categoryVal,
                                          date: DateTime.parse(dateVal),
                                          payment_method: payment_methodVal))
                                }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[900],
                            ),
                            child: Text(
                              "Save",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(80, 10, 0, 0),
                        child: SizedBox(
                          width: 120,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () => {Navigator.pop(context)},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[300],
                            ),
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
