import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'step_3_policie_screen.dart';
import 'store_setup_model.dart';

class Step2PaymentScreen extends StatefulWidget {
  const Step2PaymentScreen({super.key});

  @override
  State<Step2PaymentScreen> createState() => _Step2PaymentScreenState();
}

class _Step2PaymentScreenState extends State<Step2PaymentScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controladores de texto para cada campo de entrada
  final TextEditingController accountNameController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  String? _selectedPaymentMethod;
  @override
  void dispose() {
    // Liberar controladores para evitar fugas de memoria
    accountNameController.dispose();
    accountNumberController.dispose();
    bankNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración de Pago'),
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
                'Paso 2 - Pago',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              const SizedBox(height: 20),

              // Configuración de pago
              _buildSectionTitle('Configuración de Pago'),
              const SizedBox(height: 20),

              // Método de pago preferido
              _buildDropdownField(
                label: 'Método de Pago Preferido',
                value: _selectedPaymentMethod,
                items: const ['Transferencia Bancaria', 'PayPal', 'Skrill'],
                onChanged: (value) =>
                    setState(() => _selectedPaymentMethod = value),
              ),
              const SizedBox(height: 20),

              // Mostrar campos adicionales según el método de pago seleccionado
              if (_selectedPaymentMethod == 'Transferencia Bancaria') ...[
                _buildInputField(
                  label: 'Nombre de la Cuenta',
                  hint: 'Tu nombre de cuenta bancaria',
                  controller: accountNameController,
                ),
                const SizedBox(height: 16),
                _buildInputField(
                  label: 'Número de Cuenta',
                  hint: 'Número de tu cuenta bancaria',
                  controller: accountNumberController,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                _buildInputField(
                  label: 'Nombre del Banco',
                  hint: 'Nombre del banco',
                  controller: bankNameController,
                ),
                const SizedBox(height: 30),
              ] else if (_selectedPaymentMethod == 'PayPal' ||
                  _selectedPaymentMethod == 'Skrill') ...[
                _buildInputField(
                  label: 'Correo Electrónico',
                  hint: 'Tu correo electrónico',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa tu correo electrónico';
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                        .hasMatch(value)) {
                      return 'Por favor ingresa un correo electrónico válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
              ],

              // Botón de Continuar
              Center(
                child: _buildPrimaryButton(
                  label: 'Continuar',
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Proceder al siguiente paso
                      final registrationModel = Provider.of<StoreSetupProvider>(
                              context,
                              listen: false)
                          .data;
                      final data = registrationModel.copyWith(
                        paymentMethod: _selectedPaymentMethod,
                        accountName: accountNameController.text,
                        accountNumber: accountNumberController.text,
                        bankName: bankNameController.text,
                        emailPayment: emailController.text,
                      );
                      final registrationProvider =
                          Provider.of<StoreSetupProvider>(context,
                              listen: false);

                      registrationProvider.updateData(data);

                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const Step3PoliciesScreen(),
                        ),
                      );
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
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator, // Acepta un validador opcional
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
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey),
            ),
          ),
          validator: validator ??
              (value) {
                // Validar que el campo no esté vacío
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa $label';
                }
                return null;
              },
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(color: Colors.grey), // Añade un borde
            ),
          ),
          validator: (value) {
            if (value == null) {
              return 'Por favor selecciona $label';
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
