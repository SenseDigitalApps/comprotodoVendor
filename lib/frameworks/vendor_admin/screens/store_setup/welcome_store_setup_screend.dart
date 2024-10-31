import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../screens/common/app_bar_mixin.dart';
import 'step_1_store_screen.dart';

class WelcomeStoreSetup extends StatefulWidget {
  const WelcomeStoreSetup({super.key});

  @override
  State<WelcomeStoreSetup> createState() => _WelcomeStoreSetupState();
}

class _WelcomeStoreSetupState extends State<WelcomeStoreSetup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración de la Tienda'),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            const Text(
              '¡Bienvenido a Marketplace!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "¡Gracias por elegir marketplace! Este asistente de configuración rápida te ayudará a configurar los ajustes básicos y tendrás tu tienda lista en poco tiempo.",
              style:
                  TextStyle(fontSize: 16, height: 1.5, color: Colors.black54),
            ),
            const SizedBox(height: 20),
            const Text(
              "Si no deseas pasar por el asistente en este momento, puedes omitirlo y volver al panel. Puedes configurar tu tienda desde el panel > ajustes en cualquier momento.",
              style:
                  TextStyle(fontSize: 16, height: 1.5, color: Colors.black54),
            ),
            const SizedBox(height: 30),
            _buildPrimaryButton(
              label: "¡Vamos!",
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => const Step1StoreScreen()),
                );
              },
            ),
            // const SizedBox(height: 16),
            // _buildPrimaryButton(
            //   label: 'No ahora',
            //   color: Colors.grey,
            //   onPressed: () {
            //     // Navegar a la pantalla de inicio de sesión o al panel
            //   },
            // ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildPrimaryButton({
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
