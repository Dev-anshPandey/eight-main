import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: const [
        UserAccountsDrawerHeader(
          accountName: Text(
            'devanshpandey87@gmail.com',
            style: TextStyle(color: Colors.black),
          ),
          accountEmail: Text(""),
          currentAccountPicture: CircleAvatar(
            radius: 1,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.account_circle_rounded,
              size: 60,
              color: Color(0xff8BDF85),
            ),
          ),
          decoration: BoxDecoration(color: Colors.white),
          currentAccountPictureSize: Size.fromRadius(30),
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text("Logout"),
          iconColor: Color(0xff8BDF85),
        ),
        ListTile(
          leading: Icon(Icons.people),
          title: Text("About Us"),
          iconColor: Color(0xff8BDF85),
        ),
        ListTile(
          leading: Icon(Icons.location_on),
          title: Text("Your Location"),
          iconColor: Color(0xff8BDF85),
        ),
        ListTile(
          leading: Icon(Icons.favorite),
          title: Text("Likes"),
          iconColor: Color(0xff8BDF85),
        ),
        ListTile(
          leading: Icon(Icons.history),
          title: Text("Order History"),
          iconColor: Color(0xff8BDF85),
        ),
        ListTile(
          leading:Icon(Icons.people),
          title: Text("Our Chief"),
          iconColor: Color(0xff8BDF85),
        ),
        ListTile(
          leading: Icon(Icons.contact_page),
          title: Text("Contact Ous"),
          iconColor: Color(0xff8BDF85),
        ),
      ]),
    );
  }
}
