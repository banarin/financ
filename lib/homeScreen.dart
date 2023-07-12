
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance/drawerScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerScreen(),
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              });
        }),
        centerTitle: true,
        backgroundColor: Color(0xff11998e),
        title: const Text(
          'Liste des Carnets',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: EdgeInsets.all(5.0),
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection("Carnets").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (!snapshot.hasData) {
                return Text('pas de carnet enregistré');
              }
              List<dynamic> Carnet = [];
              snapshot.data!.docs.forEach((element) {
                Carnet.add(element);
              });
              return Column(
                children: [
                  Table(
                    border: TableBorder.all(color: Colors.black38),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: const [
                      TableRow(
                        decoration: BoxDecoration(color: Colors.redAccent),
                        children: [
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Dates'),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Zone'),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('carnet'),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Mise'),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('nbre'),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Montant'),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Nom & prenom'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Table(
                    border: TableBorder.all(color: Colors.black38),
                    children: [
                      ...Carnet.map(
                        (e) => TableRow(children:    [
                          
                          TableCell(child: Builder(
                            builder: (context) {
                               DateTime date1 = DateTime.fromMillisecondsSinceEpoch(e['Dates'].seconds*1000);
                              return Text(DateFormat("dd/MM/yyy").format(date1));
                            }
                          )),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(e['Zone']),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(e['Carnet']),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(e['mise'].toString()),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(e['nbrmise'].toString()),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(e['montant'].toString()),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(e['nomPrenom']),
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        )),
      ),
    );
  }
}

