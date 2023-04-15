import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:App/authentication_module/authen_main.dart';
import 'package:App/profile/addChild.dart';

import 'package:accordion/accordion.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

// class _ProfilePageState extends State<ProfilePage> {
//   // It is the Profile Page here

//   String parent_name = 'Aman';
//   bool parent_edit = false;
//   bool parent_err = false;
//   TextEditingController name = TextEditingController();

//   int mobile_number = 9289857147;
//   bool number_edit = false;
//   bool number_err = false;
//   TextEditingController number = TextEditingController();
//   // take input phone_number

//   List<dynamic> children = []; // list of children
//   TextEditingController email = TextEditingController();

//   // Boolean variables
//   bool loaded_ch = false;

//   Future<void> updateProfile() async {
//     final response = await http.put(
//       Uri.parse('http://10.1.128.246:5000/parent/update/profile'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, dynamic>{
//         'email': widget.email,
//         'mobile_no': mobile_number,
//         'name': parent_name,
//       }),
//     );

//     if (response.statusCode == 200) {
//       print("Updated succssfully");
//     } else {
//       throw Exception('Failed to connect to server');
//     }
//   }

//   void updateParentName(String newname) {
//     // method is called when edit option is set to true

//     setState(() {
//       if (newname.length == 0) {
//         parent_err = true;
//         return;
//       }
//       parent_err = false;
//       parent_edit = false; // edit option false

//       // update in frontend and backend
//       parent_name = newname;
//       updateProfile();
//     });
//   }

//   void updateMobileNumber(String newphone) {
//     setState(() {
//       if (newphone.length != 10) {
//         number_err = true;
//         return;
//       }
//       if (num.tryParse(newphone) == null) {
//         number_err = true;
//         return;
//       }

//       number_err = false;
//       number_edit = false;

//       // update in frontend and backend

//       mobile_number = int.parse(newphone);
//       updateProfile();
//     });
//   }

//   int i = 2; // index in bottomNavigationBar

//   Future<void> fetchProfile() async {
//     final response = await http.post(
//       Uri.parse('http://10.1.128.246:5000/parent/profile'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{
//         'email': widget.email,
//       }),
//     );

//     if (response.statusCode == 200) {
//       name.text = jsonDecode(response.body)["name"];
//       parent_name = name.text;

//       mobile_number = jsonDecode(response.body)["mobile_no"];
//       number.text = mobile_number.toString();

//       // children
//       final childresponse = await http.post(
//         Uri.parse('http://10.1.128.246:5000/parent/children'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(<String, String>{
//           'email': widget.email,
//         }),
//       );

//       if (childresponse.statusCode == 200) {
//         if (!mounted) return;

//         setState(() {
//           final array = jsonDecode(childresponse.body);

//           final ne = [];
//           for (var i = 0; i < array.length; i++) {
//             final e = array[i];
//             final hehe = new Child(
//                 name: e["name"], DOB: e["date_of_birth"], gender: e["gender"]);
//             ne.add(hehe);
//           }

//           children = ne;
//           loaded_ch = true;
//         });
//       }
//     } else {
//       throw Exception('Failed to connect to server');
//     }
//   }

//   Future<void> addChild(String name, String DOB, String gender) async {
//     final response = await http.put(
//       Uri.parse('http://10.1.128.246:5000/parent/update/addchild'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, dynamic>{
//         'parent': widget.email,
//         'name': name,
//         'DOB': DOB,
//         'gender': gender,
//       }),
//     );

//     if (response.statusCode == 200) {
//       print("child appended successfully");
//     } else {
//       throw Exception('Failed to connect to server');
//     }
//     setState(() {
//       children.add(Child(name: name, DOB: DOB, gender: gender));
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     email.text = widget.email;

//     // fetch the details of the parent
//     fetchProfile();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(children: [
//         Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               loaded_ch == false
//                   ? CircularProgressIndicator()
//                   : SizedBox(
//                       // width: parent_edit == false ? 160 : 120,
//                       width: parent_edit == false
//                           ? MediaQuery.of(context).size.width - 20 >
//                                   parent_name.length * 8 + 25 + 40
//                               ? parent_name.length * 8 + 25 + 40
//                               : MediaQuery.of(context).size.width - 20
//                           : MediaQuery.of(context).size.width - 20 >
//                                   parent_name.length * 8 + 25
//                               ? parent_name.length * 8 + 25
//                               : MediaQuery.of(context).size.width - 20,
//                       child: TextField(
//                         controller: name,
//                         enabled: parent_edit,
//                         decoration: InputDecoration(
//                             isDense: true,
//                             prefixIcon: Icon(Icons.person),
//                             // prefixIconColor: Colors.amber,
//                             labelText:
//                                 parent_edit == false ? "Parent's Name:" : '',
//                             errorText: parent_err == true
//                                 ? 'Please enter a valid name'
//                                 : '',
//                             hintStyle: TextStyle(color: Colors.blue),
//                             hintText: "Enter your Name"),
//                       ),
//                     ),
//               parent_edit == false
//                   ? IconButton(
//                       // To add an iconButton
//                       onPressed: () {
//                         setState(() {
//                           parent_edit = true;
//                         });
//                       },
//                       icon: Icon(Icons.edit),
//                     )
//                   : IconButton(
//                       onPressed: () {
//                         print(name.text.length);
//                         updateParentName(name.text);
//                       },
//                       icon: Icon(Icons.done)),
//               parent_edit == false
//                   ? SizedBox()
//                   : IconButton(
//                       onPressed: () {
//                         setState(() {
//                           name.text = parent_name;
//                           parent_edit = false;
//                         });
//                       },
//                       icon: Icon(Icons.cancel_outlined))
//             ]),
//         Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//           loaded_ch == false
//               ? CircularProgressIndicator()
//               : SizedBox(
//                   width: number_edit == false
//                       ? MediaQuery.of(context).size.width >
//                               widget.email.length * 8 + 25 + 40
//                           ? widget.email.length * 8 + 25 + 40
//                           : MediaQuery.of(context).size.width - 10
//                       : MediaQuery.of(context).size.width >
//                               widget.email.length * 8 + 25
//                           ? widget.email.length * 8 + 25
//                           : MediaQuery.of(context).size.width - 10,
//                   child: TextField(
//                     enabled: number_edit,
//                     maxLength: 10,
//                     controller: number,
//                     decoration: InputDecoration(
//                         prefixIcon: Icon(Icons.phone),
//                         labelText: number_edit == false
//                             ? "Registered Mobile Number:"
//                             : '',
//                         errorText: number_err == true
//                             ? 'Enter a Valid Mobile Number'
//                             : '',
//                         hintStyle: TextStyle(color: Colors.blue),
//                         hintText: "Enter your Mobile Number"),
//                   ),
//                 ),
//           number_edit == false
//               ? IconButton(
//                   onPressed: () {
//                     setState(() {
//                       number_edit = true;
//                     });
//                   },
//                   icon: Icon(Icons.edit),
//                 )
//               : IconButton(
//                   onPressed: () {
//                     updateMobileNumber(number.text);
//                   },
//                   icon: Icon(Icons.done)),
//           number_edit == false
//               ? SizedBox()
//               : IconButton(
//                   onPressed: () {
//                     setState(() {
//                       number.text = mobile_number.toString();
//                       number_edit = false;
//                     });
//                   },
//                   icon: Icon(Icons.cancel_outlined))
//         ]),
//         Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//           SizedBox(
//             width: true == false
//                 ? MediaQuery.of(context).size.width >
//                         widget.email.length * 8 + 25 + 40
//                     ? widget.email.length * 8 + 25 + 40
//                     : MediaQuery.of(context).size.width - 10
//                 : MediaQuery.of(context).size.width >
//                         widget.email.length * 8 + 25
//                     ? widget.email.length * 8 + 25
//                     : MediaQuery.of(context).size.width - 10,
//             child: TextField(
//               enabled: false,
//               controller: email,
//               decoration: InputDecoration(
//                 labelText: "Your Email Address:",
//               ),
//             ),
//           ),
//         ]),
//         Text(''),
//         ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               primary: Colors.purple,
//             ),
//             onPressed: () {
//               showDialog(
//                   context: context,
//                   builder: (context) {
//                     return AddChildPage(
//                         addChild); // add child fuction passed as an arguement
//                   });
//             },
//             child: Text('+ ADD A CHILD')),
//         children.length == 0
//             ? SizedBox()
//             : Accordion(
//                 maxOpenSections: 1,
//                 children: children.map((e) {
//                   var index = children.indexOf(e);
//                   var name = children[index].name;
//                   var dateOfBirth = children[index].DOB;
//                   var gender = children[index].gender;
//                   return AccordionSection(
//                       header: Text(name),
//                       content: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           RichText(
//                             text: TextSpan(
//                                 style: const TextStyle(
//                                   fontSize: 14.0,
//                                   color: Colors.black,
//                                 ),
//                                 children: [
//                                   TextSpan(
//                                       text: 'Name: ',
//                                       style: const TextStyle(
//                                           fontWeight: FontWeight.bold)),
//                                   TextSpan(text: name),
//                                 ]),
//                           ),
//                           RichText(
//                             text: TextSpan(
//                                 style: const TextStyle(
//                                   fontSize: 14.0,
//                                   color: Colors.black,
//                                 ),
//                                 children: [
//                                   TextSpan(
//                                       text: 'DOB : ',
//                                       style: const TextStyle(
//                                           fontWeight: FontWeight.bold)),
//                                   TextSpan(text: dateOfBirth.substring(0, 10)),
//                                 ]),
//                           ),
//                           RichText(
//                             text: TextSpan(
//                                 style: const TextStyle(
//                                   fontSize: 14.0,
//                                   color: Colors.black,
//                                 ),
//                                 children: [
//                                   TextSpan(
//                                       text: 'Gender: ',
//                                       style: const TextStyle(
//                                           fontWeight: FontWeight.bold)),
//                                   TextSpan(text: gender),
//                                 ]),
//                           ),
//                         ],
//                       ));
//                 }).toList(),
//               ),
//       ]),
//     );
//   }
// }

class ProfilePage1 extends StatefulWidget {
  final String email; // email as an arguement

  ProfilePage1(this.email, {Key? key}) : super(key: key);

  @override
  State<ProfilePage1> createState() => _ProfilePageState1();
}

class _ProfilePageState1 extends State<ProfilePage1> {
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
<<<<<<< HEAD
      Uri.parse('http://10.1.128.246:5000/parent/update/profile'),
=======
      Uri.parse('http://192.168.122.1:5000/parent/update/profile'),
>>>>>>> 3a419d8300b56d668f6c57f66fb9d393eab69542
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
<<<<<<< HEAD
      Uri.parse('http://10.1.128.246:5000/parent/profile'),
=======
      Uri.parse('http://192.168.122.1:5000/parent/profile'),
>>>>>>> 3a419d8300b56d668f6c57f66fb9d393eab69542
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
<<<<<<< HEAD
        Uri.parse('http://10.1.128.246:5000/parent/children'),
=======
        Uri.parse('http://192.168.122.1:5000/parent/children'),
>>>>>>> 3a419d8300b56d668f6c57f66fb9d393eab69542
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
<<<<<<< HEAD
      Uri.parse('http://10.1.128.246:5000/parent/update/addchild'),
=======
      Uri.parse('http://192.168.122.1:5000/parent/update/addchild'),
>>>>>>> 3a419d8300b56d668f6c57f66fb9d393eab69542
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

  // bOOLEAN TO SHOW CHILDREN
  bool showChildren = false;

  @override
  void initState() {
    super.initState();
    email.text = widget.email;

    // fetch the details of the parent
    fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile Page')),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(parent_name, style: TextStyle(fontSize: 20)),
              accountEmail:
                  Text(widget.email, style: TextStyle(color: Colors.grey)),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.network(
                    'https://t3.ftcdn.net/jpg/00/64/67/80/360_F_64678017_zUpiZFjj04cnLri7oADnyMH0XBYyQghG.jpg',
                    fit: BoxFit.cover,
                    width: 90,
                    height: 90,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
              ),
            ),
            ListTile(
              leading: Icon(Icons.schedule),
              title: Text(
                'My Bookings',
              ),
              onTap: () => null,
            ),
            ListTile(
              leading: Icon(Icons.child_care),
              title: Text('My Children'),
              onTap: () {
                setState(() {
                  showChildren = !showChildren;
                });
              },
            ),
            showChildren == true
                ? Accordion(
                    maxOpenSections: 1,
                    headerBackgroundColor: Colors.transparent,
                    contentBorderColor: Colors.transparent,
                    contentBackgroundColor: Colors.transparent,
                    children: children.map((e) {
                      var index = children.indexOf(e);
                      var name = children[index].name;
                      var dateOfBirth = children[index].DOB;
                      var gender = children[index].gender;
                      return AccordionSection(
                          header: Text(name,
                              style: TextStyle(
                                fontSize: 15,
                              )),
                          content: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(dateOfBirth.substring(0, 10),
                                        style: TextStyle(
                                          color: Colors.grey,
                                        )),
                                  ],
                                ),

                                // TextSpan(
                                //     text: 'Gender: ',
                                //     style: const TextStyle(
                                //         fontWeight: FontWeight.bold)),
                                Text(gender,
                                    style: TextStyle(
                                      color: Colors.grey,
                                    )),
                              ]));
                    }).toList(),
                  )
                : SizedBox(),
            ListTile(
              leading: Icon(Icons.logout_outlined),
              title: Text('Log Out'),
              onTap: () => null,
            ),
          ],
        ),
      ),
      body: loaded_ch == true
          ? Column(
              children: [
                const Expanded(flex: 2, child: _TopPortion()),
                // _TopPortion(),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          parent_name,
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        // const _ProfileInfoRow(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FloatingActionButton.extended(
                              onPressed: () {},
                              heroTag: 'follow',
                              elevation: 0,
                              label: const Text("My Bookings"),
                              icon: const Icon(Icons.schedule),
                            ),
                            const SizedBox(width: 16.0),
                            FloatingActionButton.extended(
                              onPressed: () {},
                              heroTag: 'mesage',
                              elevation: 0,
                              backgroundColor: Colors.red,
                              label: const Text("Book A Center"),
                              icon: const Icon(Icons.bookmark),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Center(
              child: Column(
              children: [
                CircularProgressIndicator(),
                Text('Please wait for profile to load...'),
              ],
            )),
    );
  }
}

class _ProfileInfoRow extends StatelessWidget {
  const _ProfileInfoRow({Key? key}) : super(key: key);

  final List<ProfileInfoItem> _items = const [
    ProfileInfoItem("Posts", 900),
    ProfileInfoItem("Followers", 120),
    ProfileInfoItem("Following", 200),
    ProfileInfoItem('HEHEH', 1992),
    ProfileInfoItem('ieiee', 2882)
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      constraints: const BoxConstraints(maxWidth: 400),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _items
            .map((item) => Expanded(
                    child: Row(
                  children: [
                    if (_items.indexOf(item) != 0) const VerticalDivider(),
                    Expanded(child: _singleItem(context, item)),
                  ],
                )))
            .toList(),
      ),
    );
  }

  Widget _singleItem(BuildContext context, ProfileInfoItem item) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item.value.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Text(
            item.title,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      );
}

class ProfileInfoItem {
  final String title;
  final int value;
  const ProfileInfoItem(this.title, this.value);
}

class _TopPortion extends StatelessWidget {
  const _TopPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color.fromARGB(255, 54, 89, 149),
                    Color(0xff006df1)
                  ]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(200),
                bottomRight: Radius.circular(200),
              )),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://t3.ftcdn.net/jpg/00/64/67/80/360_F_64678017_zUpiZFjj04cnLri7oADnyMH0XBYyQghG.jpg')),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
