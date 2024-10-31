import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'step_5_finished_screen.dart';
import 'store_setup_model.dart';

class Step4CustomerSupportScreen extends StatefulWidget {
  const Step4CustomerSupportScreen({super.key});

  @override
  State<Step4CustomerSupportScreen> createState() =>
      _Step4CustomerSupportScreenState();
}

class _Step4CustomerSupportScreenState
    extends State<Step4CustomerSupportScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controladores de texto para cada campo
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController address1Controller = TextEditingController();
  final TextEditingController address2Controller = TextEditingController();
  String? selectedCountry;
  String? selectedCity;
  String? selectedState;
  final TextEditingController postcodeController = TextEditingController();
  bool isLoading = false;
  // // Listas de opciones para los dropdowns
  // final List<String> countries = ['Colombia', 'México', 'Argentina'];
  // final List<String> cities = ['Bogotá', 'Medellín', 'Cali'];
  // final List<String> states = ['Cundinamarca', 'Antioquia', 'Valle del Cauca'];
  final List<Map<String, String>> countries = [
    {'name': 'Colombia', 'code': 'CO'},
  ];

  final List<Map<String, String>> regions = [
    {'name': 'Bogotá', 'code': 'CUN'},
  ];

  void _showMessage(String? message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message ?? ''),
      duration: const Duration(seconds: 3),
    ));
  }

  @override
  void dispose() {
    // Liberar controladores para evitar fugas de memoria
    phoneController.dispose();
    emailController.dispose();
    address1Controller.dispose();
    address2Controller.dispose();
    postcodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración de Soporte al Cliente'),
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
                'Paso 4 - Soporte al Cliente',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              const SizedBox(height: 20),

              // Configuración de soporte
              _buildSectionTitle('Configuración de Soporte'),
              const SizedBox(height: 20),

              // Teléfono
              _buildInputField(
                label: 'Teléfono',
                hint: 'Número de teléfono',
                controller: phoneController,
              ),
              const SizedBox(height: 20),

              // Correo electrónico
              _buildInputField(
                label: 'Correo Electrónico',
                hint: 'Tu correo electrónico',
                controller: emailController,
              ),
              const SizedBox(height: 20),

              // Dirección 1
              _buildInputField(
                label: 'Dirección 1',
                hint: 'Dirección principal',
                controller: address1Controller,
              ),
              const SizedBox(height: 20),

              // Dirección 2 (opcional)
              _buildInputField(
                label: 'Dirección 2',
                hint: 'Apartamentos, suite, unidad, etc. (opcional)',
                controller: address2Controller,
              ),
              const SizedBox(height: 20),

              // País
              _buildDropdownField(
                label: 'País',
                value: selectedCountry,
                items: countries,
                onChanged: (value) {
                  setState(() {
                    selectedCountry = value;
                    // Guardar el código del país seleccionado
                  });
                },
              ),
              const SizedBox(height: 20),

              // Ciudad/Pueblo
              // _buildDropdownField(
              //   label: 'Ciudad/Pueblo',
              //   value: selectedCity,
              //   items: cities,
              //   onChanged: (value) {
              //     setState(() {
              //       selectedCity = value;
              //     });
              //   },
              // ),
              // const SizedBox(height: 20),

              // Estado/Condado
              _buildDropdownField(
                label: 'Estado/Condado',
                value: selectedState,
                items: regions,
                onChanged: (value) {
                  setState(() {
                    selectedState = value;
                  });
                },
              ),
              const SizedBox(height: 20),

              // Código Postal
              _buildInputField(
                label: 'Código Postal',
                hint: 'Código postal',
                controller: postcodeController,
              ),
              const SizedBox(height: 30),

              // Botón de Continuar
              Center(
                child: _buildPrimaryButton(
                  isLoading: isLoading,
                  label: 'Continuar',
                  color: Theme.of(context).primaryColor,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() => isLoading = true);
                      // Proceder al siguiente paso
                      final model = Provider.of<StoreSetupProvider>(context,
                          listen: false);
                      final data = model.data.copyWith(
                        supportPhone: phoneController.text,
                        supportEmail: emailController.text,
                        supportAddress1: address1Controller.text,
                        supportAddress2: address2Controller.text,
                        supportCountry: selectedCountry,
                        supportCity: selectedCity,
                        supportState: selectedState,
                        supportPostcode: postcodeController.text,
                      );

                      model.updateData(data);

                      final result = await model.register(_showMessage);

                      setState(() => isLoading = false);
                      if (result) {
                        await Navigator.pushAndRemoveUntil(
                          context,
                          CupertinoPageRoute(
                            builder: (context) =>
                                const Step7FinishingStepScreen(),
                          ),
                          (Route<dynamic> route) =>
                              false, // Elimina todas las rutas anteriores
                        );
                      }
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

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<Map<String, String>> items,
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
          items: items.map((country) {
            return DropdownMenuItem(
              value: country['name'],
              child: Text(country['name']!),
            );
          }).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
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
    required bool isLoading,
    required VoidCallback? onPressed,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onPressed,
      child: isLoading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          : Text(label, style: const TextStyle(fontSize: 16)),
    );
  }
}
