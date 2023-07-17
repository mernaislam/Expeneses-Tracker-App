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
    Expense(
        amount: 19.5,
        title: 'Flutter Course',
        category: Category.work,
        date: DateTime.now()),
    Expense(
        amount: 30.14,
        title: 'Ski Egypt',
        category: Category.leisure,
        date: DateTime.now()),
  ];

  void _addExpense(Expense expense) {
    setState(() {
      _selectedExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _selectedExpenses.indexOf(expense);

    setState(() {
      _selectedExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _selectedExpenses.insert(expenseIndex, expense);
              });
            }),
        content: const Text('Expense Deleted.'),
      ),
    );
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return NewExpense(onAddExpense: _addExpense);
        });
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(child: Text('No expenses found \n  Try adding some!', style: Theme.of(context).textTheme.titleLarge,));
    if (_selectedExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expensesList: _selectedExpenses,
        onDeleted: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          const Text('The chart'),
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}
