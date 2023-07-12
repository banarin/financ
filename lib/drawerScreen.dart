import 'package:finance/ContisationScreen.dart';
import 'package:finance/add_carnetScreen.dart';
import 'package:finance/homeScreen.dart';
import 'package:finance/rembousement.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'add_CotisationScreen.dart';
import 'add_rembourScreen.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  int page = 1;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          Center(
            child: DrawerHeader(
                child: Padding(padding: EdgeInsets.only(top: 40.0),
                 child: Text(
              user.email!,
              style: const TextStyle(fontSize: 20),
            ),
                )
                ),
          ),
          ListTile(
            title: Text(
              'Liste des Carnets',
              style: TextStyle(
                  fontSize: page == 1 ? 25 : 20,
                  color: page == 1 ? Colors.green : Colors.black),
            ),
            onTap: () {
              setState(() {
                page = 1;
              });
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>  HomePage()));

              print(page);
            },
          ),  
          ListTile(
            title: const Text(
              'Ajout de la Cotisation',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const Add_carnetScreen())));
            },
          ),
          ListTile(
            title: Text(
              'Cotisations',
              style: TextStyle(
                  fontSize: page == 2 ? 25 : 20,
                  color: page == 2 ? Colors.green : Colors.black),
            ),
            onTap: () {
              setState(() {
                page = 2;
              });
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const CotisationScreen())));

              print(page);
            },
          ),
          ListTile(
            title: const Text(
              'Ajout de Cotisation',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const addCotisation())));
            },
          ),
          ListTile(
            title: Text(
              'Remboursements',
              style: TextStyle(
                  fontSize: page == 3 ? 25 : 20,
                  color: page == 3 ? Colors.green : Colors.black),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const RemboursScreen())));
              setState(() {
                page = 3;
              });
              print(page);
            },
          ),
          ListTile(
            title: const Text(
              'Ajout de remboursement',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const add_rembour())));
            },
          ),
      
          ListTile(
            title: const Text(
              'Déconnexion',
              style: TextStyle(fontSize: 20, color: Colors.red),
            ),
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
          )
        ],
      ),
    );
  }
}
