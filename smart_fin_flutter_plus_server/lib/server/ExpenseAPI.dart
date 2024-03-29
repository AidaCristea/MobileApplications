import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:smart_fin_flutter/Expense.dart';

class ExpenseAPI {
  String baseURL = "http://10.0.2.2:8080/expense";
  final http.Client server = http.Client();

  Future<List<Expense>> retrieveAllExpenses() async {
    var url = Uri.parse(baseURL);
    http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    print(response.body);

    if (response.statusCode == 200) {
      final List<dynamic> jsonExpenses = json.decode(response.body);
      List<Expense> expenses =
          jsonExpenses.map((json) => Expense.fromMapServer(json)).toList();
      log("retreives expenses done");
      return expenses;
    } else {
      throw Exception('Failed to load expenses');
    }
  }

  Future<Expense> createExpenseOnServer(Expense newExpense) async {
    log("in create expense");
    log("New expense has id " + newExpense.id.toString());
    final response = await server.post(
      Uri.parse(baseURL),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json
          .encode(newExpense.toMapServer()), // Convert the newExpense to JSON
    );
    print(response.body);

    if (response.statusCode == 201) {
      // If the server returns a 201 Created response, parse the JSON response
      // into an Expense object and return it
      final dynamic jsonExpense = json.decode(response.body);

      return Expense.fromMapServer(jsonExpense);
    } else {
      // If the server did not return a 201 Created response, throw an exception
      throw Exception('Failed to create expense on server');
    }
  }

  Future<Expense> updateExpenseOnServer(Expense updatedExpense) async {
    var url = Uri.parse(baseURL);
    log("updatedExp " +
        updatedExpense.id.toString() +
        " " +
        updatedExpense.title);
    http.Response response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(
          updatedExpense.toMapServer()), // Convert the updatedExpense to JSON
    );
    print(response.body);

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON response
      // into an Expense object and return it
      final dynamic jsonExpense = json.decode(response.body);
      return Expense.fromMapServer(jsonExpense);
    } else {
      // If the server did not return a 200 OK response, throw an exception
      throw Exception('Failed to update expense on server');
    }
  }

  Future<void> deleteExpenseOnServer(int expenseId) async {
    final response = await server.delete(
      Uri.parse('$baseURL/$expenseId'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 204) {
      // If the server returns a 204 No Content response, the expense was successfully deleted
      print('Expense deleted on server successfully');
    } else {
      // If the server did not return a 204 No Content response, throw an exception
      throw Exception('Failed to delete expense on server');
    }
  }

  void closeServer() {
    server.close();
  }
}
