import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget{
  const ExpenseItem(this.expense, {super.key});
  
  final Expense expense;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Text(expense.title),
            const SizedBox(height: 15,),
            Row(
              children: [
                Text(expense.amount.toStringAsFixed(2)),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcon[expense.category]),
                    const SizedBox(width: 8,),
                    Text(expense.formattedDate)
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}