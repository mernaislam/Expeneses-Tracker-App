import 'package:expense_tracker/new_expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _selectedExpenses = [
    Expense(amount: 19.5, title: 'Flutter Course', category: Category.work, date: DateTime.now()),
    Expense(amount: 30.14, title: 'Ski Egypt', category: Category.leisure, date: DateTime.now()),
  ];

  void _openAddExpenseOverlay(){
    showModalBottomSheet(context: context, builder: (ctx) {
      return const NewExpense();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter ExpenseTracker'),
        actions: [
          IconButton(onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          const Text('The chart'),
          Expanded(child: ExpensesList(_selectedExpenses)),
        ],
      ),
    );
  }
}
