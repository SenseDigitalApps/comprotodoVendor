import 'package:flutter/material.dart';
import 'package:fstore/common/error_codes/error_codes.dart';
import '../../services/store_setup_service.dart';
import 'data/registration_data.dart';

class StoreSetupProvider with ChangeNotifier {
  RegistrationModel _data = RegistrationModel();
  final StoreSetupService _storeSetupService = StoreSetupService();

  RegistrationModel get data => _data;

  void updateData(RegistrationModel newData) {
    _data = newData;
    notifyListeners();
  }

  Future<bool> register(Function(String? message) showMessage) async {
    try {
      // Intentar el registro
      var success = await _storeSetupService.register(_data);

      if (success) {
        showMessage('Se ha realizado un registro exitoso');
        return true;
      } else {
        // Mostrar mensaje de error en caso de fallo
        showMessage('Error al realizar el registro');
        return false;
      }
    } catch (e) {
      // Manejar excepciones inesperadas
      showMessage('Ocurrió un error: ${e.toString()}');
      return false;
    }
  }
}
