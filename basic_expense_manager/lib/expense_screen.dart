import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() {
    return _ExpenseScreenState();
  }
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  String income = '';
  String amount = '';
  String category = '';
  String description = '';
  DateTime date = DateTime.now();
  List<Map<String, dynamic>> expenses = [];
  List<double> incomes = [];
  int? editingIndex;
  String search = '';
  String? selectedCategory;

  double get total {
    return expenses.fold(
      0,
      (sum, expense) => sum + double.parse(expense['amount']),
    );
  }

  double get totalIncome {
    return incomes.fold(0, (sum, income) => sum + income);
  }

  double get balance {
    return totalIncome - total;
  }

  Future<void> saveExpenses() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      'expenses',
      jsonEncode(expenses),
    );
  }

  Future<void> loadExpenses() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString('expenses');

    if (data != null) {
      setState(() {
        expenses = List<Map<String, dynamic>>.from(
          jsonDecode(data),
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expense Manager')),
      body: Column(
        children: [
          TextField(
            decoration: const InputDecoration(labelText: 'Income'),
            onChanged: (value) {
              income = value;
            },
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Amount'),
            onChanged: (value) {
              amount = value;
            },
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Category'),
            onChanged: (value) {
              category = value;
            },
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Description'),
            onChanged: (value) {
              description = value;
            },
          ),
          ElevatedButton(
            onPressed: () async {
              DateTime? selectedDate = await showDatePicker(
                context: context,
                initialDate: date,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );

              if (selectedDate != null) {
                setState(() {
                  date = selectedDate;
                });
              }
            },
            child: Text('Date: ${date.toString().split(' ')[0]}'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (income.isNotEmpty) {
                  incomes.add(double.parse(income));
                }

                if (editingIndex == null) {
                  expenses.add({
                    'amount': amount,
                    'category': category,
                    'description': description,
                    'date': date.toString(),
                  });
                } else {
                  expenses[editingIndex!] = {
                    'amount': amount,
                    'category': category,
                    'description': description,
                    'date': date.toString(),
                  };

                  editingIndex = null;
                }
              });

              saveExpenses();
            },
            child: const Text('Add Expense'),
          ),
          Text('Total Expenditure: $total'),
          Text('Total Income: $totalIncome'),
          Text('Balance: $balance'),
          TextField(
            decoration: const InputDecoration(labelText: 'Search'),
            onChanged: (value) {
              setState(() {
                search = value;
              });
            },
          ),
          DropdownButton<String>(
            value: selectedCategory,
            hint: const Text('Category'),
            items: const [
              DropdownMenuItem(value: 'Food', child: Text('Food')),
              DropdownMenuItem(value: 'Travel', child: Text('Travel')),
              DropdownMenuItem(value: 'Shopping', child: Text('Shopping')),
            ],
            onChanged: (value) {
              setState(() {
                selectedCategory = value;
              });
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                final expense = expenses[index];

                if ((!expense['category']
                            .toString()
                            .toLowerCase()
                            .contains(search.toLowerCase()) &&
                        !expense['description']
                            .toString()
                            .toLowerCase()
                            .contains(search.toLowerCase())) ||
                    (selectedCategory != null &&
                        expense['category'] != selectedCategory)) {
                  return const SizedBox();
                }

                return ListTile(
                  title: Text(expense['category']),
                  subtitle: Text(expense['description']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          setState(() {
                            editingIndex = index;
                            amount = expense['amount'];
                            category = expense['category'];
                            description = expense['description'];
                            date = DateTime.parse(expense['date']);
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            expenses.removeAt(index);
                          });

                          saveExpenses();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
