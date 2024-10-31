import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fstore/routes/flux_navigate.dart';
import 'package:provider/provider.dart';

import '../../../../common/config.dart';
import '../../../../common/constants.dart';
import '../../../../common/error_codes/error_codes.dart';
import '../../../../common/extensions/extensions.dart';
import '../../../../common/tools/tools.dart';
import '../../../../generated/l10n.dart';
import '../../../../screens/home/privacy_term_screen.dart';
import '../../../../screens/settings/notification_screen.dart';
import '../../../../widgets/common/edit_product_info_widget.dart';
import '../../../../widgets/common/index.dart' show CustomTextField, FluxImage;
import '../../../vendor_admin/config/app_config.dart';
import '../../models/authentication_model.dart';
import '../store_setup/data/registration_data.dart';
import '../store_setup/store_setup_model.dart';
import '../store_setup/welcome_store_setup_screend.dart';

class RegistrationWidgetV2 extends StatefulWidget {
  final Function callBack;
  final Function(ErrorType? type, {String? message}) onMessage;

  const RegistrationWidgetV2({
    super.key,
    required this.callBack,
    required this.onMessage,
  });

  @override
  State<RegistrationWidgetV2> createState() => _RegistrationWidgetV2State();
}

class _RegistrationWidgetV2State extends State<RegistrationWidgetV2> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _shopNameController = TextEditingController();
  final TextEditingController _addressLine1Controller = TextEditingController();
  final TextEditingController _addressLine2Controller = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  final TextEditingController _regionController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String? firstName,
      lastName,
      emailAddress,
      username,
      storeName,
      addressLine1,
      addressLine2,
      country,
      city,
      region,
      postalCode,
      phoneNumber,
      password,
      confirmPassword;

  bool isChecked = false;

  final firstNameNode = FocusNode();
  final lastNameNode = FocusNode();
  final emailNode = FocusNode();
  final usernameNode = FocusNode();
  final passwordNode = FocusNode();
  final confirmPasswordNode = FocusNode();

  // Agrega estas listas de opciones en la clase _RegistrationWidgetV2State
  final List<Map<String, String>> countries = [
    {'name': 'Colombia', 'code': 'CO'},
  ];

  final List<Map<String, String>> regions = [
    {'name': 'Bogotá', 'code': 'CUN'},
  ];

  // final List<String> cities = ['Bogotá'];
  // final List<String> regions = [
  //   'Bogotá', //
  // ];
// CO/CUN
  String? selectedCountry;
  String? selectedCity;
  String? selectedRegion;

  String? selectedCountryCode;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    firstNameNode.dispose();
    lastNameNode.dispose();
    emailNode.dispose();
    usernameNode.dispose();
    passwordNode.dispose();
    confirmPasswordNode.dispose();
    super.dispose();
  }

  void _snackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  bool _validateFields() {
    // Verificar campos requeridos
    if (_usernameController.text.isEmpty) {
      _snackBar('El nombre de usuario es requerido.');
      return false;
    }
    if (_firstNameController.text.isEmpty) {
      _snackBar('El nombre es requerido.');
      return false;
    }
    if (_lastNameController.text.isEmpty) {
      _snackBar('El apellido es requerido.');
      return false;
    }
    if (_emailController.text.isEmpty ||
        !_isValidEmail(_emailController.text)) {
      _snackBar('Ingrese un correo electrónico válido.');
      return false;
    }
    if (_passwordController.text.isEmpty ||
        _passwordController.text.length < 6) {
      _snackBar('La contraseña debe tener al menos 6 caracteres.');
      return false;
    }
    if (_confirmPasswordController.text != _passwordController.text) {
      _snackBar('Las contraseñas no coinciden.');
      return false;
    }
    if (_shopNameController.text.isEmpty) {
      _snackBar('El nombre de la tienda es requerido.');
      return false;
    }
    if (_addressLine1Controller.text.isEmpty) {
      _snackBar('La dirección (línea 1) es requerida.');
      return false;
    }
    if (_countryController.text.isEmpty) {
      _snackBar('El país es requerido.');
      return false;
    }
    // if (_cityController.text.isEmpty) {
    //   _snackBar('La ciudad/pueblo es requerida.');
    //   return false;
    // }
    if (_regionController.text.isEmpty) {
      _snackBar('La región/provincia es requerida.');
      return false;
    }
    if (_postalCodeController.text.isEmpty) {
      _snackBar('El código postal es requerido.');
      return false;
    }
    if (_phoneNumberController.text.isEmpty) {
      _snackBar('El teléfono de la tienda es requerido.');
      return false;
    }
    return true;
  }

  bool _isValidEmail(String email) {
    // Regex para validar el correo electrónico
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  Future<void> _submitRegister(BuildContext context) async {
    if (!_validateFields()) return;

    final registrationProvider =
        Provider.of<StoreSetupProvider>(context, listen: false);

    var data = RegistrationModel(
      username: _usernameController.text,
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      shopName: _shopNameController.text,
      addressLine1: _addressLine1Controller.text,
      addressLine2: _addressLine2Controller.text,
      country: _countryController.text,
      city: _cityController.text,
      region: _regionController.text,
      postalCode: _postalCodeController.text,
      shopPhone: _phoneNumberController.text,
    );

    registrationProvider.updateData(data);
    widget.callBack();
    // Navegar a la siguiente pantalla
    await Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => const WelcomeStoreSetup()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final modelLogin =
        Provider.of<VendorAdminAuthenticationModel>(context, listen: false);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 10.0),
                Center(
                  child: Image.asset(
                    kAppLogo,
                    height: 150.0,
                  ),
                ),
                const SizedBox(height: 30.0),
                Center(
                  child: Text(
                    'Registro',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                const SizedBox(height: 16.0),
                EditProductInfoWidget(
                  label: '${S.of(context).username}*',
                  fontSize: 12.0,
                  controller: _usernameController,
                ),
                EditProductInfoWidget(
                  label: '${S.of(context).email}*',
                  fontSize: 12.0,
                  controller: _emailController,
                ),
                EditProductInfoWidget(
                  label: '${S.of(context).firstName}*',
                  fontSize: 12.0,
                  controller: _firstNameController,
                ),
                EditProductInfoWidget(
                  label: '${S.of(context).lastName}*',
                  fontSize: 12.0,
                  controller: _lastNameController,
                ),

                EditProductInfoWidget(
                  label: '${S.of(context).shopName}*',
                  fontSize: 12.0,
                  controller: _shopNameController,
                ),

                const SizedBox(height: 2.0),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text('https://compratodo.com/store/[tu_tienda]',
                      style: TextStyle(color: Colors.grey)),
                ),

                EditProductInfoWidget(
                  label: 'Dirección, línea 1*',
                  fontSize: 12.0,
                  controller: _addressLine1Controller,
                ),
                EditProductInfoWidget(
                  label: 'Dirección, línea 2 (Opcional)',
                  fontSize: 12.0,
                  controller: _addressLine2Controller,
                ),
                // Reemplaza estos campos en el método build de _RegistrationWidgetV2State
                EditProductInfoWidget(
                  label: 'País',
                  fontSize: 12.0,
                  controller:
                      _countryController, // Opcional si quieres mostrarlo.
                  isMultiline: false,
                  suffixIcon: DropdownButtonFormField<String>(
                    value: selectedCountry,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.only(left: 20, right: 10),
                      fillColor: Theme.of(context).primaryColorLight,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9.0),
                      ),
                    ),
                    items: countries.map((country) {
                      return DropdownMenuItem(
                        value: country['name'],
                        child: Text(country['name']!),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCountry = value;

                        // Guardar el código del país seleccionado
                        selectedCountryCode = countries.firstWhere(
                            (element) => element['name'] == value)['code'];
                        _countryController.text = selectedCountryCode ?? '';
                      });
                    },
                  ),
                ),

                // EditProductInfoWidget(
                //   label: 'Ciudad/Pueblo',
                //   fontSize: 12.0,
                //   controller: _cityController, // Opcional si no lo necesitas
                //   isMultiline: false,
                //   suffixIcon: DropdownButtonFormField<String>(
                //     value: selectedCity,
                //     decoration: InputDecoration(
                //       contentPadding:
                //           const EdgeInsets.only(left: 20, right: 10),
                //       fillColor: Theme.of(context).primaryColorLight,
                //       filled: true,
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(9.0),
                //       ),
                //     ),
                //     items: cities.map((city) {
                //       return DropdownMenuItem(
                //         value: city,
                //         child: Text(city),
                //       );
                //     }).toList(),
                //     onChanged: (value) {
                //       setState(() {
                //         selectedCity = value;
                //         _cityController.text = selectedCity ?? '';
                //       });
                //     },
                //   ),
                // ),

                EditProductInfoWidget(
                  label: 'Región/Provincia',
                  fontSize: 12.0,
                  controller: _regionController, // Opcional si no lo necesitas
                  isMultiline: false,
                  suffixIcon: DropdownButtonFormField<String>(
                    value: selectedRegion,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.only(left: 20, right: 10),
                      fillColor: Theme.of(context).primaryColorLight,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9.0),
                        // borderSide: BorderSide.none,
                      ),
                    ),
                    items: regions.map((country) {
                      return DropdownMenuItem(
                        value: country['name'],
                        child: Text(country['name']!),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedRegion = value;
                        _regionController.text = regions.firstWhere((element) =>
                                element['name'] == value)['code'] ??
                            '';
                      });
                    },
                  ),
                ),

                EditProductInfoWidget(
                  label: 'Código Postal',
                  fontSize: 12.0,
                  keyboardType: TextInputType.number,
                  controller: _postalCodeController,
                ),

                EditProductInfoWidget(
                  label: 'Teléfono de la tienda',
                  fontSize: 12.0,
                  keyboardType: TextInputType.number,
                  controller: _phoneNumberController,
                ),

                PasswordController(
                  controller: _passwordController,
                  text: S.of(context).password,
                ),
                PasswordController(
                  controller: _confirmPasswordController,
                  text: S.of(context).confirmPassword,
                ),

                // Row(
                //   children: <Widget>[
                //     Checkbox(
                //       value: isChecked,
                //       onChanged: (value) => setState(() {
                //         isChecked = value!;
                //       }),
                //     ),
                //     const Text('Acepto los términos y condiciones.'),
                //   ],
                // ),
                const SizedBox(height: 20.0),
                Consumer<StoreSetupProvider>(
                  builder: (context, registrationProvider, child) {
                    return GestureDetector(
                      // onTap: () => model.login(widget.onMessage),
                      onTap: () => _submitRegister(context),

                      child: Container(
                        height: 44,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: const Center(
                          child: Text(
                            'Registrar',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '${S.of(context).or.toLowerCase()} ',
                      ),
                      InkWell(
                        onTap: () {
                          widget.callBack();
                        },
                        child: Text(
                          S.of(context).loginToYourAccount,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            decoration: TextDecoration.underline,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PasswordController extends StatefulWidget {
  final controller;
  final text;

  const PasswordController({super.key, this.controller, this.text});

  @override
  State<PasswordController> createState() => _PasswordControllerState();
}

class _PasswordControllerState extends State<PasswordController> {
  bool isObscure = true;

  void _updateObsucure() {
    isObscure = !isObscure;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return EditProductInfoWidget(
      key: const Key('vendorAdminLoginPassword'),
      label: widget.text,
      fontSize: 12.0,
      controller: widget.controller,
      isObscure: isObscure,
      suffixIcon: GestureDetector(
          onTap: _updateObsucure,
          child: Icon(
            isObscure ? Icons.visibility_off : Icons.visibility,
            color: Theme.of(context).iconTheme.color,
          )),
    );
  }
}
