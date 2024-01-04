import 'dart:core';
import 'dart:core';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_fin_flutter/Screens/AddExpenseScreen.dart';
import 'package:smart_fin_flutter/server/ExpenseAPI.dart';

import '../Expense.dart';
import '../Screens/UpdateExpenseScreen.dart';
import '../database/dbHelper.dart';

import 'package:lifecycle/lifecycle.dart';

import 'package:connectivity_plus/connectivity_plus.dart';

class AllExpensesScreen extends StatefulWidget {
  const AllExpensesScreen({super.key});

  @override
  State<AllExpensesScreen> createState() => _AllExpensesScreenState();
}

class _AllExpensesScreenState extends State<AllExpensesScreen> {
  DBHelper dbHelper = DBHelper.dbInstance;
  ExpenseAPI expenseAPI = ExpenseAPI();

  late List<Expense> expenses;

  @override
  void initState() {
    super.initState();
    //isNetworkConnected();
    getExpensesFromFuture();
    checkNetworkAndSyncData();
  }

/*  @override
  void onLifecycleEvent(LifecycleEvent event) {
    if (event == LifecycleEvent.active) {
      checkNetworkAndSyncData();
    }
  }*/

  void getExpensesFromFuture() async {
    log("in getALl");
    expenses = await dbHelper.getExpenses();
    log(expenses.toString());
  }

  void checkNetworkAndSyncData() async {
    if (await isNetworkConnected()) {
      syncDataWithServer();
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3), // Adjust the duration as needed
      ),
    );
  }

  Future<void> syncDataWithServer() async {
    try {
      List<Expense> expensesServer = await expenseAPI.retrieveAllExpenses();
      log("data from server");
      for (Expense exp in expensesServer) {
        log(exp.id.toString() + " " + exp.title);
      }

      //getExpensesFromFuture();
      //List<Expense> expensesDatabase = await dbHelper.getExpenses();
      expenses = await dbHelper.getExpenses();
      List<Expense> expensesDatabase = expenses;

      log("data from db");
      for (Expense exp in expensesDatabase) {
        log(exp.id.toString() + " " + exp.title);
      }

      for (Expense e1 in expensesDatabase) {
        bool exists = expensesServer.any((e2) => e1.id == e2.id);

        if (!exists) {
          log("expense to add in server has id " + e1.id.toString());
          //Expense addedExpense = await expenseAPI.createExpenseOnServer(e1);
          await expenseAPI.createExpenseOnServer(e1);
          log("Added item from local db: $e1");
          //e1.id = addedExpense.id;
          //log("The new id of the expense that existed in the db is : " + e1.id.toString());
        }
      }

      for (Expense e2 in expensesServer) {
        bool exists = expensesDatabase.any((e1) => e1.id == e2.id);

        if (!exists) {
          await expenseAPI.deleteExpenseOnServer(e2.id!);
          log("Deleted item from server: $e2");
        }
      }

      for (Expense e1 in expensesDatabase) {
        bool different = expensesServer.any((e2) =>
            e1.id == e2.id &&
            (e1.title != e2.title ||
                e1.description != e2.description ||
                e1.amount != e2.amount ||
                e1.category != e2.category ||
                e1.date != e2.date ||
                e1.payment_method != e2.payment_method));

        if (different) {
          await expenseAPI.updateExpenseOnServer(e1);
          print("Updated item from the server: $e1");
        }
      }
    } catch (e) {
      showSnackBar("Failed to synchronize data with the server!");
      print("Failed to synchronize data with the server: $e");
    }

    log("Data after sync");
    for (Expense exp in expenses) {
      log(exp.id.toString() + " " + exp.title);
    }
  }

  Future<bool> isNetworkConnected() async {
    /*var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      //showConnectionDialog(context, false);
      return false;
    }
    //showConnectionDialog(context, true);
    return true;*/
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }

    var connectivity = await Connectivity().checkConnectivity();
    if (connectivity == ConnectivityResult.mobile ||
        connectivity == ConnectivityResult.wifi) {
      return true;
    }

    return false;
  }

  Expense? getExpenseById(int id) {
    for (Expense e in expenses) {
      if (e.id == id) return e;
    }
  }

  void updateExpense(Expense newExpense) {
    log("In update expenses list that is shown");
    for (int i = 0; i < expenses.length; i++) {
      if (expenses[i].id == newExpense.id) expenses[i] = newExpense;
    }
  }

  void removeFromList(int id) {
    expenses.removeWhere((element) => element.id == id);
  }

  Future<Expense?> searchExpense(Expense newExpense)
  async {
    List<Expense> newExpenses = await dbHelper.getExpenses();
    for(Expense e in newExpenses)
    {
      if(e.title == newExpense.title && e.description == newExpense.description && e.amount == newExpense.amount && e.category==newExpense.category && e.date==newExpense.date && e.payment_method==newExpense.payment_method)
      {
        return e;
      }
    }
    return null;
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
                  onPressed: () async {
                    try {
                      bool conn = await isNetworkConnected();
                      if (conn == true) {
                        await expenseAPI.deleteExpenseOnServer(id);
                      }

                      await dbHelper.deleteExpense(id);

                      setState(() {
                        //removeFromList(id);
                        Navigator.of(context).pop();
                      });
                    } catch (e) {
                      print("Error deleting expense");
                      setState(() {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Error deleting the expense")));
                      });
                    }
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

  void showConnectionDialog(BuildContext context, bool isConnected) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Connection Status'),
          content: Text(isConnected ? 'Connected' : 'Not Connected'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //getExpensesFromFuture();
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

          try {

            await dbHelper.createExpense(expense);
            log("aded in local db");

            Expense? foundExp = await searchExpense(expense);

            //sleep(10 as Duration);
            if(foundExp !=null)
              {
                if(expense != null)
                {
                  bool conn = await isNetworkConnected();
                  //sleep(5 as Duration);
                  log("network connected " + conn.toString());
                  if (conn == true) {

                    log("in is connected add the expense ");
                    //await expenseAPI.createExpenseOnServer(await dbHelper.findByAttributesExceptId(expense));
                    await expenseAPI.createExpenseOnServer(foundExp);

                  }
                }
              }



            



            setState(() {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Added!"),
              ));
              expenses.add(expense);

              log("data from db after add");

            });
          } catch (e) {
            print("Error creating expense");
            setState(() {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Error creatig the expense")));
            });
          }
        },
        backgroundColor: Colors.orange,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildListExpenses() {
    return FutureBuilder(
      builder: (context, expense) {
        if (expense.connectionState == ConnectionState.none &&
            expense.connectionState == null) {
          return Container();
        } else if (!expense.hasData) {
          return Container();
        }
        return ListView.builder(
            itemCount: expense.data!.length,
            itemBuilder: (context, index) {
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

                          try {
                            bool conn = await isNetworkConnected();
                            if (conn == true) {
                              log("In update is connected");
                              await expenseAPI.updateExpenseOnServer(exp);
                            }

                            await dbHelper.updateExpense(exp);

                            setState(() {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Updated!"),
                              ));
                              updateExpense(exp);
                            });
                          } catch (e) {
                            print("Error updating expense");
                            setState(() {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("Error updating the expense")));
                            });
                          }
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
