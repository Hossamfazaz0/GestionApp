import 'package:flutter/material.dart';
import 'package:telekonsul/page/pages.dart';
import 'package:flutter_overboard/flutter_overboard.dart';




class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState () => _OnboardingScreenState ();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OverBoard(
        buttonColor: Colors.black ,
        activeBulletColor: Colors.blue ,
        inactiveBulletColor: Colors.blue.withOpacity(0.5) ,
        pages: pages,
        showBullets: true,
        skipCallback: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LandingPage()
         ));
        },
        finishCallback: (
            ) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LandingPage()),
          );
        },
      ),
    );
  }

  final pages = [
    PageModel(
        color: Colors.white,
        titleColor: Colors.black ,
        imageAssetPath : 'assets/abo1.png',
        title: 'Réservez le Meilleur Médecin.',
        body: 'Comparez les avis des médecins et réservez votre rendez-vous gratuitement puis payez plus tard à la clinique.',
        bodyColor: Colors.blueGrey,
        doAnimateImage: true),
    PageModel(
        color: Colors.white,
        titleColor: Colors.black ,
        imageAssetPath: 'assets/abo2.png',
        title: 'Recherche par Spécialité .',
        body: 'Comparez les évaluations des médecins et réservez votre rendez-vous quatre gratuitement et payez plus tard à la clinique.',
        bodyColor: Colors.blueGrey ,
        doAnimateImage: true),
    PageModel(
        color: Colors.white,
        titleColor: Colors.black ,
        imageAssetPath: 'assets/abo3.png',
        title: 'Réservez par Téléphone.',
        body: 'Vous pouvez désormais consulter facilement les meilleurs médecins tout en restant chez vous grâce à notre service de dégivrage à distance.',
        bodyColor: Colors.blueGrey ,
        doAnimateImage: true),

  ];
}