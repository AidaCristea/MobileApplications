import 'package:intl/intl.dart';

class Expense {
  static int currentId = 0;
  int? id;
  String title;
  String description;
  int amount;
  String category;
  DateTime date;
  String payment_method;

  /*Expense(this.title, this.description, this.amount, this.category, this.date,
      this.payment_method) {
    id = currentId++;
  }*/


  /*Expense.fromExpense(this.id, this.title, this.description, this.amount,
      this.category, this.date, this.payment_method);*/

  Expense({this.id, required this.title, required this.description, required this.amount, required this.category, required this.date, required this.payment_method});

  factory Expense.fromMap(Map<String, dynamic> json) => Expense(id: json['_id'], title: json['title'], description: json['description'], amount: json['amount'], category: json['category'], date: DateTime.parse(json['date']), payment_method: json['payment_method']);

  Map<String, dynamic> toMap(){
    return{
      '_id': id,
      'title': title,
      'description': description,
      'amount': amount,
      'category': category,
      'date': date.toIso8601String(),
      'payment_method': payment_method
    };
  }


  static List<Expense> init() {
    List<Expense> expenses = [
      Expense(
          title: "Grocery Shopping",
          description: "Weekly groceries including fruits, vegetables, and household essentials.",
          amount: 150,
          category: "Food & Household",
          date: DateTime.parse(
              DateFormat('yyyy-MM-dd').format(DateTime(2023, 04, 03))),
          payment_method: "Card"),
      Expense(
          title: "Internet Bill",
          description: "Monthly payment for internet.",
          amount: 60,
          category: "Utilities",
          date: DateTime.parse(
              DateFormat('yyyy-MM-dd').format(DateTime(2023, 09, 20))),
          payment_method: "Automatic Bank Transfer"),
      Expense(
          title: "Gas Bill",
          description: "Monthly payment for gas.",
          amount: 40,
          category: "Utilities",
          date: DateTime.parse(
              DateFormat('yyyy-MM-dd').format(DateTime(2023, 09, 15))),
          payment_method: "Card"),
      Expense(
          title: "Dinner Out",
          description: "Dining at a local restaurant.",
          amount: 35,
          category: "Food & Dining",
          date: DateTime.parse(
              DateFormat('yyyy-MM-dd').format(DateTime(2023, 09, 25))),
          payment_method: "Credit Card"),
      Expense(
          title: "Movie Night",
          description: "Tickets for a movie night.",
          amount: 25,
          category: "Entertainment",
          date: DateTime.parse(
              DateFormat('yyyy-MM-dd').format(DateTime(2023, 09, 28))),
          payment_method: "Cash")
    ];
    return expenses;
  }
}
