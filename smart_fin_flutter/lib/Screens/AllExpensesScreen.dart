import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_fin_flutter/Screens/AddExpenseScreen.dart';

import '../Expense.dart';
import '../Screens/UpdateExpenseScreen.dart';
import '../database/dbHelper.dart';

class AllExpensesScreen extends StatefulWidget {
  const AllExpensesScreen({super.key});

  @override
  State<AllExpensesScreen> createState() => _AllExpensesScreenState();
}

class _AllExpensesScreenState extends State<AllExpensesScreen> {

  DBHelper dbHelper = DBHelper.dbInstance;

  late List<Expense> expenses;

  void getExpensesFromFuture() async{
    log("in getALl");
    expenses = await dbHelper.getExpenses();
    log(expenses.toString());
  }


  Expense? getExpenseById(int id) {
    for (Expense e in expenses) {
      if (e.id == id) return e;
    }
  }

  void updateExpense(Expense newExpense) {
    for (int i = 0; i < expenses.length; i++) {
      if (expenses[i].id == newExpense.id) expenses[i] = newExpense;
    }
  }

  void removeFromList(int id) {
    expenses.removeWhere((element) => element.id == id);
  }

  _showDialog(BuildContext context, int id) {
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Text("CupertinoAlertDialog"),
              content: Text("Are you sure you want to delete this expense?"),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text("Yes"),
                  onPressed: () async{
                    await dbHelper.deleteExpense(id);
                    setState(() {
                      //removeFromList(id);
                      Navigator.of(context).pop();
                    });
                  },
                ),
                CupertinoDialogAction(
                  child: Text("No"),
                  onPressed: () {
                    setState(() {
                      Navigator.of(context).pop();
                    });
                  },
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    getExpensesFromFuture();
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
      body: Center(
        child: Container(
          color: Colors.green[100],
          child: _buildListExpenses(),
          /*ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                return templateExpense(expenses[index]);
              }),*/
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Expense expense = await Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddExpenseScreen()));
              await dbHelper.createExpense(expense);
          setState(() {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Added!"),
            ));
            expenses.add(expense);
          });
        },
        backgroundColor: Colors.orange,
        child: Icon(Icons.add),
      ),
    );
  }



  Widget _buildListExpenses(){
    return FutureBuilder(
        builder: (context, expense){
          if(expense.connectionState == ConnectionState.none && expense.connectionState==null){
            return Container();
          }
          else if(!expense.hasData){
            return Container();
          }
          return ListView.builder(
              itemCount: expense.data!.length,
              itemBuilder: (context, index){
                return templateExpense(expense.data![index]);
              });
        },
        future: dbHelper.getExpenses(),
    );
  }

  Widget templateExpense(expense) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.fromLTRB(40, 20, 40, 0),
      child: Container(
        color: Colors.green,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.green[200],
              border: Border.all(
                color: Colors.black,
                width: 5,
              ),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                child: Text(
                  "${expense.title}\n${expense.description}\n${expense.amount}\n${expense.category}\n${DateFormat('yyyy-MM-dd').format(expense.date)}\n${expense.payment_method}",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(110, 0, 0, 0),
                    child: IconButton(
                      onPressed: () => {_showDialog(context, expense.id)},
                      icon: Icon(
                        CupertinoIcons.delete,
                        size: 18,
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: IconButton(
                        onPressed: () async {
                          Expense exp = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      UpdateExpenseScreen(expense: expense!)));
                                      await dbHelper.updateExpense(exp);
                          setState(() {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Updated!"),
                            ));
                            updateExpense(exp);
                          });
                        },
                        icon: Icon(
                          CupertinoIcons.pen,
                          size: 20,
                        ),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
