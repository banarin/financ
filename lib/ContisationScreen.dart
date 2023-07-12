import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance/drawerScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class CotisationScreen extends StatefulWidget {
  const CotisationScreen({super.key});

  @override
  State<CotisationScreen> createState() => _CotisationScreenState();
}

class _CotisationScreenState extends State<CotisationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerScreen(),
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
        backgroundColor: Color(0xff11998e),
        centerTitle: true,
        title: const Text(
          'Liste des Cotisations',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        ),
        body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: EdgeInsets.all(5.0),
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection("Cotisations").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (!snapshot.hasData) {
                return Text('pas de cotisation enregistré');
              }
              List<dynamic> Cotisation = [];
              snapshot.data!.docs.forEach((element) {
                Cotisation.add(element);
              });
              return Column(
                children: [
                  Table(
                    border: TableBorder.all(color: Colors.black38),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: const [
                      TableRow(
                        decoration: BoxDecoration(color: Colors.amberAccent),
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
                              child: Text('carnet'),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Type'),
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
                              child: Text('Nom Prenom'),
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
                              child: Text('Zone'),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('telephone'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Table(
                    border: TableBorder.all(color: Colors.black38),
                    children: [
                      ...Cotisation.map(
                        (e) => TableRow(children: [
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
                              padding: EdgeInsets.all(8.0),
                              child: Text(e['Carnet']),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(e['typeCarnet']),
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
                              child: Text(e['zone']),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(e['tel']),
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