import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'drawerScreen.dart';

class RemboursScreen extends StatefulWidget {
  const RemboursScreen({super.key});

  @override
  State<RemboursScreen> createState() => _RemboursScreenState();
}

class _RemboursScreenState extends State<RemboursScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:const  DrawerScreen(),
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
          'Liste des remboursements',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection("Rembousements").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (!snapshot.hasData) {
                return  const Text('pas de remboursement enregistré');
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
                              child: Text('Nom & Prenom'),
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
                              child: Text('credit'),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('mise'),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Restant'),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Date Echeance Credit'),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Retard payement'),
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
                        (e) => TableRow(children: [
                           TableCell(
                            child: Builder(
                            builder: (context) {
                               DateTime date1 = DateTime.fromMillisecondsSinceEpoch(e['Date'].seconds*1000);
                              return Text(DateFormat("dd/MM/yyy").format(date1));
                            }
                          )
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(e["nomPrenom"]),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(e['numCarnet'].toString()),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(e['mtnCredit'].toString()),
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
                              child: Text(e['mtnRestant'].toString()),
                            ),
                          ),
                           TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Builder(
                            builder: (context) {
                               DateTime date1 = DateTime.fromMillisecondsSinceEpoch(e['echeanceDate'].seconds*1000);
                              return Text(DateFormat("dd/MM/yyy").format(date1));
                            }
                          ),
                            ),
                          ),
                           TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Builder(
                            builder: (context) {
                               DateTime date1 = DateTime.fromMillisecondsSinceEpoch(e['retardPaye'].seconds*1000);
                              return Text(DateFormat("dd/MM/yyy").format(date1));
                            }
                          ),
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