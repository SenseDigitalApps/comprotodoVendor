import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'step_4_support_screen.dart';
import 'store_setup_model.dart';

class Step3PoliciesScreen extends StatefulWidget {
  const Step3PoliciesScreen({super.key});

  @override
  State<Step3PoliciesScreen> createState() => _Step3PoliciesScreenState();
}

class _Step3PoliciesScreenState extends State<Step3PoliciesScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controladores de texto para cada política
  final TextEditingController shippingPolicyController =
      TextEditingController();
  final TextEditingController refundPolicyController = TextEditingController();
  final TextEditingController cancellationPolicyController =
      TextEditingController();

  @override
  void dispose() {
    // Liberar controladores para evitar fugas de memoria
    shippingPolicyController.dispose();
    refundPolicyController.dispose();
    cancellationPolicyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración de Políticas'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Paso 3 - Políticas',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              const SizedBox(height: 20),

              // Configuración de políticas
              _buildSectionTitle('Configuración de Políticas'),
              const SizedBox(height: 20),

              // Política de envío
              _buildInputField(
                label: 'Política de Envío',
                hint: 'Descripción de la política de envío',
                controller: shippingPolicyController,
                maxLines: 5,
              ),
              const SizedBox(height: 20),

              // Política de reembolso
              _buildInputField(
                label: 'Política de Reembolso',
                hint: 'Descripción de la política de reembolso',
                controller: refundPolicyController,
                maxLines: 5,
              ),
              const SizedBox(height: 20),

              // Política de cancelación/devolución/intercambio
              _buildInputField(
                label: 'Política de Cancelación/Devolución/Intercambio',
                hint:
                    'Descripción de la política de cancelación/devolución/intercambio',
                controller: cancellationPolicyController,
                maxLines: 5,
              ),
              const SizedBox(height: 30),

              // Botón de Continuar
              Center(
                child: _buildPrimaryButton(
                  label: 'Continuar',
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Proceder al siguiente paso

                      // Proceder al siguiente paso
                      final registrationModel = Provider.of<StoreSetupProvider>(
                              context,
                              listen: false)
                          .data;
                      final data = registrationModel.copyWith(
                        shippingPolicy: shippingPolicyController.text,
                        refundPolicy: refundPolicyController.text,
                        cancellationPolicy: cancellationPolicyController.text,
                      );
                      final registrationProvider =
                          Provider.of<StoreSetupProvider>(context,
                              listen: false);

                      registrationProvider.updateData(data);

                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) =>
                                  const Step4CustomerSupportScreen()));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildInputField({
    required String label,
    required String hint,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor ingresa $label';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildPrimaryButton({
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
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
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
