import 'package:App/booking_module.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dropdownfield2/dropdownfield2.dart';
import 'package:accordion/accordion.dart';
import 'login_page.dart';

void main() {
  runApp(MaterialApp(
    home: MyLoginPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  final String email;
  final List<String> Name;
  final List<String> Age;
  final List<String> Gender;
  MyApp(
    this.Name,
    this.Age,
    this.Gender,
    this.email, {
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String username = 'Hi';

  // Parent name,  please change it
  String parent_name = 'Aman';
  bool edit_parent = false;
  bool parent_err = false;
  String new_name = '';
  TextEditingController name = TextEditingController();

  // Mobile number, please change it
  int mobile_number = 9013233244;
  bool edit_number = false;
  bool number_err = false;
  int new_number = 0;
  TextEditingController number = TextEditingController();

  // Email ID, please change it
  String email_id = 'hehe@gmail.com';
  bool edit_email = false;
  bool email_err = false;
  String new_email = '';
  TextEditingController email = TextEditingController();

  // ADD CHILD DETAILS
  String name_child = '';
  TextEditingController child = TextEditingController();

  String date_child = '';
  TextEditingController date = TextEditingController();

  String gender_child = '';
  TextEditingController gender_controller = TextEditingController();
  String? gender = 'Male';

  // Editing handlers, can be changed

  // Parent name update, Only add the API to connect to database
  void updateParentName(String newname) {
    setState(() {
      if (newname.length == 0) {
        parent_err = true;
        return;
      }

      parent_err = false;
      new_name = newname;
      edit_parent = false;
    });
  }

  // Mobile number, only add the API to connect to database.
  void updateMobileNumber(String newphone) {
    setState(() {
      if (newphone.length < 10) {
        number_err = true;
        return;
      }
      if (num.tryParse(newphone) == null) {
        number_err = true;
        return;
      }

      number_err = false;
      new_number = int.parse(newphone);
      edit_number = false;
    });
  }

  // current date
  DateTime current = new DateTime(1000);

  // List of children of the parent
  var ListOfChildren = [];

  // List of names, ages and genders of the children
  List<String> Name = [];
  List<String> Age = [];
  List<String> Gender = [];

  // List of genders
  var items = [
    'Male',
    'Female',
    'Others',
  ];

  int i = 2;

  @override
  void initState() {
    email_id = widget.email;
    Name = widget.Name;
    Age = widget.Age;
    Gender = widget.Gender;
    
    print("Inside main module");
    print(Name);

    new_email = email_id;
    new_number = mobile_number;
    new_name = parent_name;

    name.text = parent_name;
    number.text = mobile_number.toString();
    email.text = email_id;
    gender_controller.text = '';

    current = DateTime.now();

    super.initState();

    name.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Profile Page'),
        ),
        body: Center(
          child: SingleChildScrollView(
              child: Container(
            child: Column(children: [
              Text(
                'PROFILE',
                style: TextStyle(
                    fontFamily: AutofillHints.name,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Colors.purple),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(
                  width: edit_parent == false ? 160 : 120,
                  child: TextField(
                    controller: name,
                    enabled: edit_parent,
                    decoration: InputDecoration(
                        labelText: edit_parent == false ? "Parent's Name:" : '',
                        errorText: parent_err == true
                            ? 'Please enter a valid name'
                            : '',
                        hintStyle: TextStyle(color: Colors.blue),
                        hintText: "Enter your Name"),
                  ),
                ),
                edit_parent == false
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            edit_parent = true;
                          });
                        },
                        icon: Icon(Icons.edit),
                      )
                    : IconButton(
                        onPressed: () {
                          updateParentName(name.text);
                        },
                        icon: Icon(Icons.done)),
                edit_parent == false
                    ? SizedBox()
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            name.text = new_name;

                            edit_parent = false;
                          });
                        },
                        icon: Icon(Icons.cancel_outlined))
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(
                  width: edit_number == false ? 160 : 120,
                  child: TextField(
                    enabled: edit_number,
                    maxLength: 10,
                    controller: number,
                    decoration: InputDecoration(
                        labelText: edit_number == false
                            ? "Registered Mobile Number:"
                            : '',
                        errorText: number_err == true
                            ? 'Enter a Valid Mobile Number'
                            : '',
                        hintStyle: TextStyle(color: Colors.blue),
                        hintText: "Enter your Mobile Number"),
                  ),
                ),
                edit_number == false
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            edit_number = true;
                          });
                        },
                        icon: Icon(Icons.edit),
                      )
                    : IconButton(
                        onPressed: () {
                          updateMobileNumber(number.text);
                        },
                        icon: Icon(Icons.done)),
                edit_number == false
                    ? SizedBox()
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            number.text = new_number.toString();

                            edit_number = false;
                          });
                        },
                        icon: Icon(Icons.cancel_outlined))
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(
                  width: 200,
                  child: TextField(
                    enabled: false,
                    controller: email,
                    decoration: InputDecoration(
                        labelText:
                            edit_email == false ? "Your Email Address:" : '',
                        errorText: email_err == true
                            ? 'Enter a Valid Email Address'
                            : '',
                        hintStyle: TextStyle(color: Colors.blue),
                        hintText: "Enter your Email Address"),
                  ),
                ),
              ]),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return SingleChildScrollView(
                              child: Container(
                                  child: AlertDialog(
                            title: Text('Add A Child'),
                            content: Container(
                                child: Column(
                              children: [
                                TextField(
                                  controller: child,
                                  decoration: InputDecoration(
                                      labelText: 'Name Of The Child',
                                      hintText: 'Enter Name Of The Child',
                                      hintStyle: TextStyle(
                                        color: Colors.purple,
                                      )),
                                ),
                                TextField(
                                  controller: date,
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.calendar_today),
                                      labelText: 'Enter Date Of Birth'),
                                  readOnly: true,
                                  onTap: () async {
                                    DateTime? picked = await showDatePicker(
                                        context: context,
                                        initialDate: new DateTime(
                                            current.year - 10,
                                            current.month,
                                            current.day),
                                        firstDate: new DateTime(
                                            current.year - 18,
                                            current.month,
                                            current.day),
                                        lastDate: DateTime.now());

                                    if (picked != null) {
                                      String formatDate =
                                          DateFormat('yyyy-MM-dd')
                                              .format(picked);

                                      setState(() {
                                        date.text = formatDate;
                                      });
                                    }
                                  },
                                ),
                                DropDownField(
                                  controller: gender_controller,
                                  hintText: 'Select Gender',
                                  enabled: true,
                                  items: items,
                                  itemsVisibleInDropdown: 3,
                                  onValueChanged: (value) => {
                                    setState(() {
                                      gender = value;
                                    })
                                  },
                                ),
                              ],
                            )),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    if (child.text.length == 0 ||
                                        date.text == null ||
                                        gender_controller.text.length == 0) {
                                      return;
                                    }

                                    setState(() {
                                      ListOfChildren.add({
                                        "name": child.text,
                                        "dob": date.text,
                                        "gender": gender_controller.text,
                                      });
                                      Name.add(child.text);
                                      Age.add(date.text);
                                      Gender.add(gender_controller.text);
                                    });

                                    // print(ListOfChildren);
                                    Navigator.pop(context);
                                    return;
                                  },
                                  child: Text('ADD CHILD')),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('CANCEL'))
                            ],
                          )));
                        });
                  },
                  child: Text('+ ADD A CHILD')),
              Name.length == 0
                  ? SizedBox()
                  : Accordion(
                      maxOpenSections: 1,
                      children: Name.map((e) {
                        var index = Name.indexOf(e);
                        var name = Name[index];
                        var age = Age[index];
                        var gender = Gender[index];
                        return AccordionSection(
                            header: Text(name),
                            content: Column(
                              children: [
                                Text('Name: ' + name),
                                Text('DOB : ' + age),
                                Text('Gender: ' + gender),
                              ],
                            ));
                      }).toList(),
                    ),
              Text(''),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyLoginPage()));
                  },
                  child: Text('Log Out'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.red),
                  ))
            ]),
          )),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              label: 'Previous Bookings',
              icon: Icon(Icons.work_history_sharp),
            ),
            BottomNavigationBarItem(
              label: 'Book A Center',
              icon: Icon(Icons.bookmark_border),
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(Icons.people),
            )
          ],
          currentIndex: i,
          onTap: (int index) {
            if (index == 1) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MyBookingModule(Name, Age, Gender, email.text)));
              return;
            }
            if (index == 2) {
              return;
            }
            if (index == 0) {
              return;
            }
            setState(() {
              i = index;
            });
          },
        ),
      ),
    );
  }
}
