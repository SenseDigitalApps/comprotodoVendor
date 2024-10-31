import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';

import 'data/registration_data.dart';
import 'step_2_payment_screen.dart';
import 'store_setup_model.dart';

class Step1StoreScreen extends StatefulWidget {
  const Step1StoreScreen({super.key});

  @override
  State<Step1StoreScreen> createState() => _Step1StoreScreenState();
}

class _Step1StoreScreenState extends State<Step1StoreScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controladores de texto para cada campo de entrada
  final TextEditingController shopNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController address1Controller = TextEditingController();
  final TextEditingController address2Controller = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController postcodeController = TextEditingController();
  final TextEditingController locationSearchController =
      TextEditingController();
  final TextEditingController shopDescriptionController =
      TextEditingController();

  String? _selectedCountry;
  String? _selectedState;
  File? _storeLogo;
  File? _storeBanner;
  String? idLogo;
  String? idBanner;

  RegistrationModel? registrationModel;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(bool isLogo) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        if (isLogo) {
          _storeLogo = File(image.path);
          idLogo = 'logo';
        } else {
          _storeBanner = File(image.path);
          idBanner = 'banner';
        }
      });
    }
  }

  final List<Map<String, String>> countries = [
    {'name': 'Colombia', 'code': 'CO'},
  ];

  final List<Map<String, String>> regions = [
    {'name': 'Bogotá', 'code': 'CUN'},
  ];
  void _snackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    registrationModel =
        Provider.of<StoreSetupProvider>(context, listen: false).data;
    if (registrationModel == null) return;
    // Inicializar controladores con los valores del modelo
    shopNameController.text = registrationModel!.shopName!;
    phoneController.text = registrationModel!.shopPhone!;
    address1Controller.text = registrationModel!.addressLine1!;
    address2Controller.text = registrationModel!.addressLine2!;
    // cityController.text = registrationModel!.city!;
    postcodeController.text = registrationModel!.postalCode!;

    _selectedCountry = countries.firstWhere(
      (country) => country['code'] == registrationModel!.country,
      orElse: () => {},
    )['name'];

    _selectedState = regions.firstWhere(
      (country) => country['code'] == registrationModel!.region,
      orElse: () => {},
    )['name'];
    super.initState();
  }

  @override
  void dispose() {
    // Liberar controladores para evitar fugas de memoria
    shopNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    address1Controller.dispose();
    address2Controller.dispose();
    cityController.dispose();
    postcodeController.dispose();
    locationSearchController.dispose();
    shopDescriptionController.dispose();
    super.dispose();
  }

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Paso 1 - Tienda',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              const SizedBox(height: 20),

              // // Logo de la tienda
              // _buildSectionTitle('Logo de la Tienda'),
              // _buildImagePickerButton('Subir Logo', _storeLogo, true),
              // const SizedBox(height: 16),
              // _buildSectionTitle('Banner'),
              // const Text(
              //   'Sube un banner para tu tienda. El tamaño del banner es (1650x350) píxeles.',
              //   style: TextStyle(fontSize: 14, color: Colors.black54),
              // ),
              // const SizedBox(height: 8),
              // _buildImagePickerButton('Subir Banner', _storeBanner, false),

              // const SizedBox(height: 30),

              // Nombre de la tienda
              _buildInputField(
                label: 'Nombre de la Tienda',
                hint: 'Ej. Virat',
                controller: shopNameController,
              ),
              const SizedBox(height: 16),

              // Correo electrónico de la tienda
              _buildInputField(
                label: 'Correo Electrónico de la Tienda',
                hint: 'Ej. tienda@ejemplo.com',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              // Teléfono de la tienda
              _buildInputField(
                label: 'Teléfono de la Tienda',
                hint: '+123456...',
                controller: phoneController,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),

              // Dirección de la tienda
              _buildInputField(
                label: 'Dirección de la Tienda 1',
                hint: 'Dirección',
                controller: address1Controller,
              ),
              const SizedBox(height: 16),
              _buildInputField(
                label: 'Dirección de la Tienda 2',
                hint: 'Apartamento, suite, unidad, etc. (opcional)',
                controller: address2Controller,
              ),
              // const SizedBox(height: 16),

              // // Ciudad y código postal
              // _buildInputField(
              //   label: 'Ciudad del Comercio',
              //   hint: 'Ciudad',
              //   controller: cityController,
              // ),
              const SizedBox(height: 16),
              _buildInputField(
                label: 'Código Postal',
                hint: 'Código Postal',
                controller: postcodeController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              // Desplegables de país y estado
              _buildDropdownField(
                label: 'País de la Tienda*',
                value: _selectedCountry,
                items: countries,
                onChanged: (value) {
                  setState(() {
                    // Guardar el código del país seleccionado
                    _selectedCountry = countries.firstWhere(
                        (element) => element['name'] == value)['code'];
                  });
                },
              ),
              const SizedBox(height: 16),
              _buildDropdownField(
                label: 'Estado/Provincia',
                value: _selectedState,
                items: regions,
                onChanged: (value) {
                  setState(() {
                    // Guardar el código del país seleccionado
                    _selectedState = regions.firstWhere(
                        (element) => element['name'] == value)['code'];
                  });
                },
              ),
              const SizedBox(height: 30),

              // // Búsqueda de ubicación
              // _buildSectionTitle('Buscar Ubicación'),
              // _buildInputField(
              //   label: 'Buscar...',
              //   hint: 'Ingresa ubicación',
              //   controller: locationSearchController,
              // ),
              const SizedBox(height: 16),

              // Descripción de la tienda
              _buildSectionTitle('Descripción de la Tienda'),
              TextFormField(
                controller: shopDescriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Ingresa una breve descripción de tu tienda',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa una descripción para tu tienda';
                  } else if (value.length < 10) {
                    return 'La descripción debe tener al menos 10 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),

              // Botones de Continuar y Saltar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Expanded(
                  //   child: _buildPrimaryButton(
                  //     label: 'Saltar este paso',
                  //     color: Colors.grey,
                  //     onPressed: () {
                  //       // Lógica para saltar
                  //     },
                  //   ),
                  // ),
                  // const SizedBox(width: 16),
                  Expanded(
                    child: _buildPrimaryButton(
                      label: 'Continuar',
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // if (_storeLogo == null) {
                          //   _snackBar('Por favor, sube el logo de la tienda.');
                          //   return;
                          // }

                          // if (_storeBanner == null) {
                          //   _snackBar(
                          //       'Por favor, sube el banner de la tienda.');
                          //   return;
                          // }
                          final data = registrationModel!.copyWith(
                              idLogo: idLogo,
                              idBanner: idBanner,
                              emailStore: emailController.text,
                              shopDescription: shopDescriptionController.text);
                          final registrationProvider =
                              Provider.of<StoreSetupProvider>(context,
                                  listen: false);

                          registrationProvider.updateData(data);

                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                      const Step2PaymentScreen()));
                          // Proceder al siguiente paso
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePickerButton(String label, File? image, bool isLogo) {
    return GestureDetector(
      onTap: () => _pickImage(isLogo),
      child: Container(
        height: image == null ? 150 : 350,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey),
        ),
        child: image == null
            ? Center(child: Text(label))
            : Center(child: Image.file(image, fit: BoxFit.cover)),
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
