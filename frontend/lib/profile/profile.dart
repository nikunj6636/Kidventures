import 'package:flutter/material.dart';

import 'package:App/authentication_module/authen_main.dart';
import 'package:App/profile/addChild.dart';

import 'package:accordion/accordion.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  final String email; // email as an arguement

  ProfilePage(this.email, {Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class Child {
  final String name;
  final String DOB;
  final String gender;

  const Child({
    // constructor function
    required this.name,
    required this.DOB,
    required this.gender,
  });
}

class _ProfilePageState extends State<ProfilePage> {
  // It is the Profile Page here

  String parent_name = 'Aman';
  bool parent_edit = false;
  bool parent_err = false;
  TextEditingController name = TextEditingController();

  int mobile_number = 9289857147;
  bool number_edit = false;
  bool number_err = false;
  TextEditingController number = TextEditingController();
  // take input phone_number

  List<dynamic> children = []; // list of children
  TextEditingController email = TextEditingController();

  // Boolean variables
  bool loaded_ch = false;

  Future<void> updateProfile() async {
    final response = await http.put(
      Uri.parse('http://10.1.128.246:5000/parent/update/profile'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email': widget.email,
        'mobile_no': mobile_number,
        'name': parent_name,
      }),
    );

    if (response.statusCode == 200) {
      print("Updated succssfully");
    } else {
      throw Exception('Failed to connect to server');
    }
  }

  void updateParentName(String newname) {
    // method is called when edit option is set to true

    setState(() {
      if (newname.length == 0) {
        parent_err = true;
        return;
      }
      parent_err = false;
      parent_edit = false; // edit option false

      // update in frontend and backend
      parent_name = newname;
      updateProfile();
    });
  }

  void updateMobileNumber(String newphone) {
    setState(() {
      if (newphone.length != 10) {
        number_err = true;
        return;
      }
      if (num.tryParse(newphone) == null) {
        number_err = true;
        return;
      }

      number_err = false;
      number_edit = false;

      // update in frontend and backend

      mobile_number = int.parse(newphone);
      updateProfile();
    });
  }

  int i = 2; // index in bottomNavigationBar

  Future<void> fetchProfile() async {
    final response = await http.post(
      Uri.parse('http://10.1.128.246:5000/parent/profile'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': widget.email,
      }),
    );

    if (response.statusCode == 200) {
      name.text = jsonDecode(response.body)["name"];
      parent_name = name.text;

      mobile_number = jsonDecode(response.body)["mobile_no"];
      number.text = mobile_number.toString();

      // children
      final childresponse = await http.post(
        Uri.parse('http://10.1.128.246:5000/parent/children'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': widget.email,
        }),
      );

      if (childresponse.statusCode == 200) {
        if (!mounted) return;

        setState(() {
          final array = jsonDecode(childresponse.body);

          final ne = [];
          for (var i = 0; i < array.length; i++) {
            final e = array[i];
            final hehe = new Child(
                name: e["name"], DOB: e["date_of_birth"], gender: e["gender"]);
            ne.add(hehe);
          }

          children = ne;
          loaded_ch = true;
        });
      }
    } else {
      throw Exception('Failed to connect to server');
    }
  }

  Future<void> addChild(String name, String DOB, String gender) async {
    final response = await http.put(
      Uri.parse('http://10.1.128.246:5000/parent/update/addchild'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'parent': widget.email,
        'name': name,
        'DOB': DOB,
        'gender': gender,
      }),
    );

    if (response.statusCode == 200) {
      print("child appended successfully");
    } else {
      throw Exception('Failed to connect to server');
    }
    setState(() {
      children.add(Child(name: name, DOB: DOB, gender: gender));
    });
  }

  @override
  void initState() {
    super.initState();
    email.text = widget.email;

    // fetch the details of the parent
    fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          loaded_ch == false
              ? CircularProgressIndicator()
              : SizedBox(
                  width: parent_edit == false ? 160 : 120,
                  child: TextField(
                    controller: name,
                    enabled: parent_edit,
                    decoration: InputDecoration(
                        labelText: parent_edit == false ? "Parent's Name:" : '',
                        errorText: parent_err == true
                            ? 'Please enter a valid name'
                            : '',
                        hintStyle: TextStyle(color: Colors.blue),
                        hintText: "Enter your Name"),
                  ),
                ),
          parent_edit == false
              ? IconButton(
                  // To add an iconButton
                  onPressed: () {
                    setState(() {
                      parent_edit = true;
                    });
                  },
                  icon: Icon(Icons.edit),
                )
              : IconButton(
                  onPressed: () {
                    updateParentName(name.text);
                  },
                  icon: Icon(Icons.done)),
          parent_edit == false
              ? SizedBox()
              : IconButton(
                  onPressed: () {
                    setState(() {
                      name.text = parent_name;
                      parent_edit = false;
                    });
                  },
                  icon: Icon(Icons.cancel_outlined))
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          loaded_ch == false
              ? CircularProgressIndicator()
              : SizedBox(
                  width: number_edit == false ? 160 : 120,
                  child: TextField(
                    enabled: number_edit,
                    maxLength: 10,
                    controller: number,
                    decoration: InputDecoration(
                        labelText: number_edit == false
                            ? "Registered Mobile Number:"
                            : '',
                        errorText: number_err == true
                            ? 'Enter a Valid Mobile Number'
                            : '',
                        hintStyle: TextStyle(color: Colors.blue),
                        hintText: "Enter your Mobile Number"),
                  ),
                ),
          number_edit == false
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      number_edit = true;
                    });
                  },
                  icon: Icon(Icons.edit),
                )
              : IconButton(
                  onPressed: () {
                    updateMobileNumber(number.text);
                  },
                  icon: Icon(Icons.done)),
          number_edit == false
              ? SizedBox()
              : IconButton(
                  onPressed: () {
                    setState(() {
                      number.text = mobile_number.toString();
                      number_edit = false;
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
                labelText: "Your Email Address:",
              ),
            ),
          ),
        ]),
        Text(''),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.purple,
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AddChildPage(
                        addChild); // add child fuction passed as an arguement
                  });
            },
            child: Text('+ ADD A CHILD')),
        children.length == 0
            ? SizedBox()
            : Accordion(
                maxOpenSections: 1,
                children: children.map((e) {
                  var index = children.indexOf(e);
                  var name = children[index].name;
                  var dateOfBirth = children[index].DOB;
                  var gender = children[index].gender;
                  return AccordionSection(
                      header: Text(name),
                      content: Column(
                        children: [
                          Text('Name: ' + name),
                          Text('DOB : ' + dateOfBirth.substring(0, 10)),
                          Text('Gender: ' + gender),
                        ],
                      ));
                }).toList(),
              ),
        Text(''),
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AuthenticationPage()));
            },
            child: Text('Log Out'),
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
            ))
      ]),
    );
  }
}
