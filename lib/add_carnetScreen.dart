
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

import 'component/myButton.dart';
import 'component/myTextFormField.dart';

class Add_carnetScreen extends StatefulWidget {
  const Add_carnetScreen({super.key});

  @override
  State<Add_carnetScreen> createState() => _Add_carnetScreenState();
}

class _Add_carnetScreenState extends State<Add_carnetScreen> {
  DateTime dateController = DateTime.now();
  final zoneController = TextEditingController();
  final numeroController = TextEditingController();
  final miseController = TextEditingController();
  final nbrMiseController = TextEditingController();
  final nomPrenomController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void clearData() {
    zoneController.clear();
    numeroController.clear();
    miseController.clear();
    nbrMiseController.clear();
    nomPrenomController.clear();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    zoneController.dispose();
    numeroController.dispose();
    miseController.dispose();
    nbrMiseController.dispose();
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
        title: Text(
          'Ajouter un carnet',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 30,
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
                height: 30,
              ),
              myTextFormField(
                controler: zoneController,
                hindText: 'Entrez la zone',
                obscured: false,
                type: TextInputType.name,
                labelText: 'Zone',
              ),
              SizedBox(
                height: 30,
              ),
              myTextFormField(
                controler: numeroController,
                hindText: 'Entrez le numero du carnet',
                obscured: false,
                type: TextInputType.name,
                labelText: 'Carnet',
              ),
              SizedBox(
                height: 30,
              ),
              myTextFormField(
                controler: miseController,
                hindText: 'Mise',
                obscured: false,
                type: TextInputType.number,
                labelText: 'Entrez la mise',
              ),
              SizedBox(
                height: 30,
              ),
              myTextFormField(
                controler: nbrMiseController,
                hindText: 'Nombre de mise',
                obscured: false,
                type: TextInputType.number,
                labelText: 'Entrez le nombre mise',
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
              Mybutton(
                text: "Enregistré",
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    final date = dateController;
                    final zone = zoneController.text;
                    final carnet = numeroController.text;
                    final mise = int.parse(miseController.text);
                    final nbrmise = int.parse(nbrMiseController.text);
                    final nom_prenom = nomPrenomController.text;
                    final montant = mise * nbrmise;
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Enregistrement en cours !!'),
                    ));
                    FocusScope.of(context).requestFocus(FocusNode());
                    CollectionReference CarnetsRef =
                        await FirebaseFirestore.instance.collection("Carnets");
                    CarnetsRef.add({
                      'Dates': date,
                      'Zone': zone,
                      'Carnet': carnet,
                      'mise': mise,
                      'nbrmise': nbrmise,
                      'montant': montant,
                      'nomPrenom': nom_prenom,
                    });
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.green,
                      content: Text('Enregistrement terminer !!'),
                    ));
                  }
                  return null;
                },
              )
            ],
          ),
        )),
      ),
    );
  }
}
