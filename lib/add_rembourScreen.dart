import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

import 'component/myButton.dart';
import 'component/myTextFormField.dart';

class add_rembour extends StatefulWidget {
  const add_rembour({super.key});

  @override
  State<add_rembour> createState() => _add_rembourState();
}

class _add_rembourState extends State<add_rembour> {
  DateTime dateController = DateTime.now();
  DateTime dateEcheController = DateTime.now();
  DateTime dateRetardController = DateTime.now();
  final numeroController = TextEditingController();
  final miseController = TextEditingController();
  final montantRestantController = TextEditingController();
  final montantCreditController = TextEditingController();
  final nomPrenomController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void clearData() {
    montantRestantController.clear();
    numeroController.clear();
    miseController.clear();
    montantCreditController.clear();
    nomPrenomController.clear();
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
        title: const Text(
          'Ajouter un remboursement',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
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
              SizedBox(
                height: 20,
              ),
              myTextFormField(
                controler: nomPrenomController,
                hindText: 'Nom & Prenom du client',
                obscured: false,
                type: TextInputType.text,
                labelText: 'Entrez le Nom et Prenom du client',
              ),
              SizedBox(
                height: 20,
              ),
              myTextFormField(
                controler: numeroController,
                hindText: 'Entrez le numero du carnet',
                obscured: false,
                type: TextInputType.name,
                labelText: 'Carnet',
              ),
              SizedBox(
                height: 20,
              ),
              myTextFormField(
                controler: montantCreditController,
                hindText: 'Montant du credit',
                obscured: false,
                type: TextInputType.number,
                labelText: 'Entrez le montant du credit',
              ),
              SizedBox(
                height: 20,
              ),
              myTextFormField(
                controler: miseController,
                hindText: 'Mise',
                obscured: false,
                type: TextInputType.number,
                labelText: 'Entrez la mise',
              ),
              SizedBox(
                height: 20,
              ),
              myTextFormField(
                controler: montantRestantController,
                hindText: 'Montant du restant',
                obscured: false,
                type: TextInputType.number,
                labelText: 'Entrez le montant restant ',
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: DateTimeFormField(
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    hintStyle: TextStyle(color: Colors.black45),
                    errorStyle: TextStyle(color: Colors.redAccent),
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.event_note),
                    labelText: 'Echéance du credit',
                  ),
                  mode: DateTimeFieldPickerMode.date,
                  autovalidateMode: AutovalidateMode.always,
                  validator: (e) => (e?.day ?? 0) == 1
                      ? 'le choix de la date est obligatoire'
                      : null,
                  onDateSelected: (DateTime value) {
                    setState(() {
                      dateEcheController = value;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: DateTimeFormField(
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    hintStyle: TextStyle(color: Colors.black45),
                    errorStyle: TextStyle(color: Colors.redAccent),
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.event_note),
                    labelText: 'retard du payement',
                  ),
                  mode: DateTimeFieldPickerMode.date,
                  autovalidateMode: AutovalidateMode.always,
                  validator: (e) => (e?.day ?? 0) == 1
                      ? 'le choix de la date est obligatoire'
                      : null,
                  onDateSelected: (DateTime value) {
                    setState(() {
                      dateRetardController = value;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Mybutton(
                  text: "Enregistré",
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      final date = dateController;
                      final date_Echeance = dateEcheController;
                      final date_Retard = dateRetardController;
                      final carnet = numeroController.text;
                      final mise = int.parse(miseController.text);
                      final montantRest =
                          int.parse(montantRestantController.text);
                      final montantCredit =
                          int.parse(montantCreditController.text);
                      final nom_prenom = nomPrenomController.text;
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Enregistrement en cours !!'),
                      ));
                      FocusScope.of(context).requestFocus(FocusNode());
                      CollectionReference cotisationRef =
                          await FirebaseFirestore.instance
                              .collection("Rembousements");
                      cotisationRef.add({
                        'Date': date,
                        'numCarnet': carnet,
                        'mise': mise,
                        'mtnCredit': montantCredit,
                        'mtnRestant': montantRest,
                        'nomPrenom': nom_prenom,
                        'echeanceDate': date_Echeance,
                        'retardPaye': date_Retard,
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
