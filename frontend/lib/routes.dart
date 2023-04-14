import 'package:App/authentication_module/authen_main.dart';
import 'package:flutter/material.dart';
import 'package:App/booking_module/booking.dart';
import 'package:App/profile/profile.dart';

class MainPage extends StatefulWidget {
  final String email;
  const MainPage(this.email, {super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (_selectedIndex) {
      case 0:
        page = ProfilePage(widget.email);
        break;
      case 1:
        page = MyBookingModule(widget.email);
        break;
      default:
        // throw UnimplementedError('no widget for $_selectedIndex');
        page = SizedBox();
    }

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text((_selectedIndex == 0) ? 'Profile Page' : 'Booking'),
              actions:
              _selectedIndex == 0 ? 
              <Widget>[ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AuthenticationPage()));
            },
            // child: Text('Log Out'),
            child : const Icon(Icons.logout),
            style: const ButtonStyle(
              
              backgroundColor: MaterialStatePropertyAll<Color>(Colors.transparent),
            )),
            ]
            :
            []
            ,
            ),
            body: SingleChildScrollView(
              child: Center(child: page),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: [
                const BottomNavigationBarItem(
                  label: 'Profile',
                  icon: Icon(Icons.people),
                ),
                const BottomNavigationBarItem(
                  label: 'Book A Center',
                  icon: Icon(Icons.bookmark_border),
                ),
                const BottomNavigationBarItem(
                  label: 'My Bookings',
                  icon: Icon(Icons.work_history_sharp),
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            )));
  }
}
