import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './DrawerOption.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    // log the user out
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Theme.of(context).colorScheme.background,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  // header
                  DrawerHeader(
                      child: Icon(
                    Icons.work,
                    size: 25,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  )),

                  const SizedBox(height: 25),

                   DrawerOption(
                    title: "H O M E",
                    icon: Icons.person,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),      // list of items
                  DrawerOption(
                    title: "P R O F I L E",
                    icon: Icons.person,
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.pushNamed(context, '/profile_page');
                    },
                  ), 
                 DrawerOption(
                    title: "U S E R S",
                    icon: Icons.group,
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.pushNamed(context, '/users_page');
                    },
                  ), 
                  DrawerOption(
                      title: "S E T T I N G S",
                      icon: Icons.settings,
                      onTap: () {
                        Navigator.pop(context);
  
                        Navigator.pushNamed(context, '/settings_page');
                      },
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0, bottom: 25),
                child: ListTile(
                  title: Text("L O G O U T", style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary)),
                  leading: Icon(
                    Icons.logout,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    logout();
                  },
                ),
              ),
            ]));
  }
}
