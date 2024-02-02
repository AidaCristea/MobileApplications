import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_fin_flutter/Expense.dart';

class UpdateExpenseScreen extends StatefulWidget {
  const UpdateExpenseScreen({super.key, required this.expense});

  final Expense expense;

  @override
  State<UpdateExpenseScreen> createState() => _UpdateExpenseScreenState();
}

class _UpdateExpenseScreenState extends State<UpdateExpenseScreen> {
  final _formKey = GlobalKey<FormState>();

  bool isValidDate(date) {
    try {
      DateTime.parse(date);
    } catch (e) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    String titleVal = widget.expense.title;
    String descriptionVal = widget.expense.description;
    String amountVal = widget.expense.amount.toString();
    String categoryVal = widget.expense.category;
    String dateVal = DateFormat("yyyy-MM-dd").format(widget.expense.date);
    String payment_methodVal = widget.expense.payment_method;

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
                        "Update expense",
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
                      initialValue: widget.expense.title,
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
                      initialValue: widget.expense.description,
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
                      initialValue: widget.expense.amount.toString(),
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
                      initialValue: widget.expense.category,
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
                      initialValue:
                          DateFormat("yyyy-MM-dd").format(widget.expense.date),
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
                      initialValue: widget.expense.payment_method,
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
                              if (_formKey.currentState!.validate())
                                {
                                  Navigator.pop(
                                      context,
                                      Expense(
                                          id: widget.expense.id,
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
