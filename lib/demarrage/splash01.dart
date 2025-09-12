import 'package:flutter/material.dart';
import 'package:rmelapp/demarrage/onboarding1.dart';
import 'package:rmelapp/patient/utils/HexColor.dart';


class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();

    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        _createRoute( Onboarding1()),
      );
    });
  }

  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 900),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.elasticOut, // effet de sursaut
        );

        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1), // arrive du bas (vertical)
            end: Offset.zero,
          ).animate(curved),
          child: child,
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: HexColor('#EFF6FF'),
        child: Center(
          child: FadeTransition(
            opacity: _animation,
            child: Image.asset(
              'assets/images/logo.png',
              width: 165,
              height: 199,
            ),
          ),
        ),
      ),
    );
  }
}
