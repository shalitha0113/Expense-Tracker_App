import 'package:expense_tracker_app/expense_components/expense_list.dart';
import 'package:expense_tracker_app/expense_components/new_expense.dart';
import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const filePath = 'assets/json/expense_data.json';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  List<Expense> expenses = [];

  @override
  void initState() {
    _loadExpenses();
    super.initState();
  }

  void _loadExpenses() async {
    List<Expense> loadedExpenses =
        (await readJsonFile(filePath)).map((dynamic item) {
      return Expense.fromJson(item as Map<String, dynamic>);
    }).toList();
    setState(() {
      expenses = loadedExpenses;
    });
  }

  void _openAddExpenseOverlay() {
    // #TODO - Add show bottom model
    showModalBottomSheet(context: context, builder: (ctx)=> NewExpense(onAddExpense: addExpense));
  }

  // #TODO - addExpense function to expense List and pass to NewExpense widget;
  void addExpense(Expense expense){

  }

  // #TODO - removeExpense function to expense List and pass to NewExpense widget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Flutter ExpenseTracker',style: GoogleFonts.aboreto(color: Colors.black,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: ExpensesList(expenses: expenses)),
        ],
      ),
    );
  }
}
