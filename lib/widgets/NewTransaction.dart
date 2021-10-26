import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransactionhandler;
  NewTransaction(this.addTransactionhandler);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void submitData() {
    if(_amountController.text.isEmpty)return;
    var amount = double.parse(_amountController.text);
    var title = _titleController.text;
    if (title.isEmpty || amount <= 0 || _selectedDate == null) return;

    widget.addTransactionhandler(
      _titleController.text,
      double.parse(_amountController.text),
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                //onSubmitted: (_) => submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData(),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(_selectedDate == null
                        ? 'No date has chosen!'
                        : 'Date ${DateFormat.yMd().format(_selectedDate)}'),
                  ),
                  Container(
                    height: 40,
                    child: FlatButton(
                        onPressed: () => showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2019),
                                    lastDate: DateTime.now())
                                .then((pickedDate) {
                              if (pickedDate == null) return;
                              setState(() {
                                _selectedDate = pickedDate;
                              });
                            }),
                        child: Text(
                          'Choose Date',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        )),
                  ),
                ],
              ),
              RaisedButton(
                onPressed: submitData,
                child: Text('Add transaction'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
              ),
            ],
          ),
        ));
  }
}
