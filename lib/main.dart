import 'package:flutter/material.dart';
import 'package:rmelapp/demarrage/onboarding1.dart';
import '../patient/pages/ordonnances/ordonnance_page.dart';
import 'package:rmelapp/demarrage/splash01.dart';
import 'package:rmelapp/patient/pages/compte/compte_page.dart';
import 'package:rmelapp/patient/pages/dashboard.dart';
import 'package:rmelapp/patient/pages/inscriptionpatient.dart';
import 'package:rmelapp/patient/pages/ordonnances/ordonnance_page.dart';
import 'package:rmelapp/patient/pages/rendez-vous/rdv_list.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../patient/pages/choix_date.dart'; // ton fichier ChoixDate
import '../medecin/pages/inscriptiondoctor.dart';
import '../medecin/pages/dashboard_doctor.dart';





// Import de ta nouvelle page splash

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('fr_FR', null);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Patrimoine App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Point d'entrée
      routes: {
        '/': (context) => DashboardDoctor(), // Page suivante (à créer)
        // Page de splash
        '/onboarding': (context) => const Onboarding1(), // Page d'onboarding\
        'inscription': (context) => const Inscription(),
        '/home': (context) => const DashboardPage(), // Page d'accueil après le splash
        'rendezvous': (context) => const MesRendezVousPage(),
        'ordonnances': (context) => const OrdonnancesPage(),
        'choixdate': (context) =>  ChoixDate(),
        'compte':(context) => MonComptePage(),
        'inscriptiondoctor':(context) => Inscriptiondoctor(),
        'dashboard_doctor':(context)=> DashboardDoctor()
    
      },
    );
  }
}