import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dropdownfield2/dropdownfield2.dart';

class AddChildPage extends StatefulWidget {
  final Function addChild;
  const AddChildPage(this.addChild, {super.key});

  @override
  State<AddChildPage> createState() => _AddChildPageState();
}

class _AddChildPageState extends State<AddChildPage> {
  TextEditingController childName = TextEditingController(); // name of child
  TextEditingController DateOfBirth = TextEditingController();
  String childGender = '';

  // current date
  DateTime current = DateTime.now();

  // List of genders
  var items = [
    'Male',
    'Female',
    'Others',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            child: AlertDialog(
      title: Text('Add A Child'),
      content: Container(
          child: Column(
        children: [
          TextField(
            controller: childName,
            decoration: InputDecoration(
                labelText: 'Name Of The Child',
                hintText: 'Enter Name Of The Child',
                hintStyle: TextStyle(
                  color: Colors.purple,
                )),
          ),

          TextField(
            controller: DateOfBirth,
            decoration: InputDecoration(
                icon: Icon(Icons.calendar_today),
                labelText: 'Enter Date Of Birth'),
            onTap: () async {
              DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: new DateTime(
                      current.year - 10, current.month, current.day),
                  firstDate: new DateTime(
                      current.year - 18, current.month, current.day),
                  lastDate: DateTime.now());

              if (picked != null) {
                setState(() {
                  DateOfBirth.text = DateFormat('yyyy-MM-dd').format(picked);
                });
                print(DateOfBirth);
              }
            },
          ),
          DropDownField(
            hintText: 'Select Gender',
            items: items,
            itemsVisibleInDropdown: 3,
            onValueChanged: (value) => {
              setState(() {
                childGender = value;
              })
            },
          ),
        ],
      )),
      actions: [
        TextButton(
            onPressed: () {
              if (childName.text.length == 0 ||
                  DateOfBirth == null ||
                  childGender.length == 0) {
                return;
              }

              widget.addChild(childName.text, DateOfBirth.text, childGender);

              Navigator.pop(context);
            },
            child: Text('ADD CHILD')),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('CANCEL'))
      ],
    )));
  }
}