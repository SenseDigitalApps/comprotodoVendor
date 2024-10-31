import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fstore/common/error_codes/error_codes.dart';
import 'package:fstore/frameworks/vendor_admin/vendor_admin_app.dart';
import 'package:provider/provider.dart';

import '../login_screen/login_screen.dart';
import 'store_setup_model.dart';

class Step7FinishingStepScreen extends StatefulWidget {
  const Step7FinishingStepScreen({super.key});

  @override
  State<Step7FinishingStepScreen> createState() =>
      _Step7FinishingStepScreenState();
}

class _Step7FinishingStepScreenState extends State<Step7FinishingStepScreen> {
  void _showMessage(String? message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message ?? ''),
      duration: const Duration(seconds: 3),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finalizando'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '¡Hemos terminado!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              'Tu tienda está lista. Es hora de experimentar las cosas de manera más fácil y tranquila. ¡Agrega tus productos y comienza a contar ventas, diviértete!',
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                _showMessage('Por favor inicia sesión con tus credenciales');

                Navigator.popUntil(context, (route) => route.isFirst);
                // await Navigator.pushAndRemoveUntil(
                //   context,
                //   CupertinoPageRoute(
                //     builder: (context) => const VendorAdminApp(),
                //   ),
                //   (Route<dynamic> route) =>
                //       false, // Elimina todas las rutas anteriores
                // );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Finalizar',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
