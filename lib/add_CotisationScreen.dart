import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

import 'component/dropDownMenu.dart';
import 'component/myButton.dart';
import 'component/myTextFormField.dart';

class addCotisation extends StatefulWidget {
  const addCotisation({super.key});

  @override
  State<addCotisation> createState() => _addCotisationState();
}

class _addCotisationState extends State<addCotisation> {
  DateTime dateController = DateTime.now();
  final zoneController = TextEditingController();
  final numeroController = TextEditingController();
  final telController = TextEditingController();
  final miseController = TextEditingController();
  final montantController = TextEditingController();
  final nomPrenomController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String selected = "";
  void clearData() {
    zoneController.clear();
    numeroController.clear();
    miseController.clear();
    montantController.clear();
    nomPrenomController.clear();
    telController.clear();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    zoneController.dispose();
    numeroController.dispose();
    miseController.dispose();
    montantController.dispose();
    nomPrenomController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              });
        }),
        backgroundColor: Color(0xff11998e),
        title: const  Text(
          'Ajouter un carnet',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child:  Container(
            child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: DateTimeFormField(
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    hintStyle: TextStyle(color: Colors.black45),
                    errorStyle: TextStyle(color: Colors.redAccent),
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.event_note),
                    labelText: 'Dates',
                  ),
                  mode: DateTimeFieldPickerMode.date,
                  autovalidateMode: AutovalidateMode.always,
                  validator: (e) => (e?.day ?? 0) == 1
                      ? 'le choix de la date est obligatoire'
                      : null,
                  onDateSelected: (DateTime value) {
                    setState(() {
                      dateController = value;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              myTextFormField(
                controler: numeroController,
                hindText: 'Entrez le numero du carnet',
                obscured: false,
                type: TextInputType.name,
                labelText: 'Carnet',
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: DropdownButtonFormField(
                  items: const [
                    DropdownMenuItem(
                        value: "Nouveau", child: Text("Nouveau Carnet")),
                    DropdownMenuItem(
                        value: "Ancien", child: Text("Ancien Carnet")),
                  ],
                  value: "Nouveau",
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    fillColor: Colors.white,
                  ),
                  onChanged: (value) {
                    selected = value!;
                  },
                ),
              ),
             const SizedBox(
                height: 20,
              ),
              myTextFormField(
                controler: montantController,
                hindText: 'Montant du Carnet',
                obscured: false,
                type: TextInputType.number,
                labelText: 'Entrez le montant du Carnet',
              ),
              const SizedBox(
                height: 20,
              ),
              myTextFormField(
                controler: nomPrenomController,
                hindText: 'Nom & Prenom du client',
                obscured: false,
                type: TextInputType.text,
                labelText: 'Entrez le Nom et Prenom du client',
              ),
              const SizedBox(
                height: 20,
              ),
              myTextFormField(
                controler: miseController,
                hindText: 'Mise',
                obscured: false,
                type: TextInputType.number,
                labelText: 'Entrez la mise',
              ),
              const SizedBox(
                height: 20,
              ),
              myTextFormField(
                controler: zoneController,
                hindText: 'Entrez la zone de la collecte',
                obscured: false,
                type: TextInputType.name,
                labelText: 'Zone',
              ),
              const SizedBox(
                height: 20,
              ),
              myTextFormField(
                controler: telController,
                hindText: 'Entrez le numero  de telephone ',
                obscured: false,
                type: TextInputType.phone,
                labelText: 'Numero',
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Mybutton(
                  text: "Enregistré",
                  onTap: () async {
                    print(selected);
                    if (_formKey.currentState!.validate()) {
                      final date = dateController;
                      final carnet = numeroController.text;
                      final zone = zoneController.text;
                      final telephone = telController.text;
                      final mise = int.parse(miseController.text);
                      final montant = int.parse(montantController.text);
                      final nom_prenom = nomPrenomController.text;
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Enregistrement en cours !!'),
                      ));
                      FocusScope.of(context).requestFocus(FocusNode());
                      CollectionReference cotisationRef =
                          await FirebaseFirestore.instance
                              .collection("Cotisations");
                      cotisationRef.add({
                        'Dates': date,
                        'Carnet': carnet,
                        'mise': mise,
                        'montant': montant,
                        'nomPrenom': nom_prenom,
                        'tel': telephone,
                        'typeCarnet': selected,
                        'zone': zone,
                      });
                      clearData();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.green,
                        content: Text('Enregistrement terminer !!'),
                      ));
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
