import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {required this.onDeleted, required this.expensesList, super.key});
  final List<Expense> expensesList;
  final void Function(Expense expense) onDeleted;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expensesList.length,
      itemBuilder: (ctx, index) => Dismissible(
        background: Container(color: Theme.of(context).colorScheme.error.withOpacity(0.7), margin: Theme.of(context).cardTheme.margin,),
        key: ValueKey(
          expensesList[index],
        ),
        onDismissed: (direction) {
          onDeleted(
            expensesList[index],
          );
        },
        child: ExpenseItem(
          expensesList[index],
        ),
      ),
    );
  }
}
