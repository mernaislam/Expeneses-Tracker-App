import 'dart:io';

import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _choosenCategory = Category.leisure;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = now;
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Invalid Expense!'),
          content: const Text(
              'Please make sure to enter a valid title, amount, date and category'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Ok'),
            )
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Expense!'),
          content: const Text(
              'Please make sure to enter a valid title, amount, date and category'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Ok'),
            )
          ],
        ),
      );
    }
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final inValidAmount = enteredAmount == null || enteredAmount <= 0;
    if (inValidAmount ||
        _selectedDate == null ||
        _titleController.text.trim().isEmpty) {
      _showDialog();
      return;
    }

    widget.onAddExpense(
      Expense(
          amount: enteredAmount,
          category: _choosenCategory,
          date: _selectedDate!,
          title: _titleController.text),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
                child: Column(
                  children: [
                    if (width > height)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _titleController,
                              maxLength: 50,
                              decoration: const InputDecoration(
                                label: Text('Title'),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 24,
                          ),
                          Expanded(
                            child: TextField(
                              controller: _amountController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                prefixText: '\$ ',
                                label: Text('Amount'),
                              ),
                            ),
                          ),
                        ],
                      )
                    else
                      TextField(
                        controller: _titleController,
                        maxLength: 50,
                        decoration: const InputDecoration(
                          label: Text('Title'),
                        ),
                      ),
                    const SizedBox(
                      height: 30,
                    ),
                    if (width > height)
                      Row(
                        children: [
                          DropdownButton(
                            value: _choosenCategory,
                            items: Category.values
                                .map(
                                  (category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(
                                      category.name.toUpperCase(),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              if (value == null) {
                                return;
                              }
                              setState(() {
                                _choosenCategory = value;
                              });
                            },
                          ),
                          const Spacer(),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  _selectedDate == null
                                      ? 'No Date Selected'
                                      : formatter.format(_selectedDate!),
                                ),
                                IconButton(
                                  onPressed: _presentDatePicker,
                                  icon: const Icon(Icons.calendar_month),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    else
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _amountController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                prefixText: '\$ ',
                                label: Text('Amount'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  _selectedDate == null
                                      ? 'No Date Selected'
                                      : formatter.format(_selectedDate!),
                                ),
                                IconButton(
                                  onPressed: _presentDatePicker,
                                  icon: const Icon(Icons.calendar_month),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    const SizedBox(
                      height: 30,
                    ),
                    if (width > height)
                      Row(
                        children: [
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: _submitExpenseData,
                            child: const Text('Save'),
                          )
                        ],
                      )
                    else
                      Row(
                        children: [
                          DropdownButton(
                            value: _choosenCategory,
                            items: Category.values
                                .map(
                                  (category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(
                                      category.name.toUpperCase(),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              if (value == null) {
                                return;
                              }
                              setState(() {
                                _choosenCategory = value;
                              });
                            },
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: _submitExpenseData,
                            child: const Text('Save'),
                          ),
                        ],
                      ),
                  ],
                )),
          ),
        );
      },
    );
  }
}
