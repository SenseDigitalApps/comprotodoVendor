import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../screens/store_setup/data/registration_data.dart';

class StoreSetupService {
  final String baseUrl = 'https://compratodo.com/wp-json/v1'; // URL base

  /// Registro de usuario
  Future<bool> register(RegistrationModel registrationData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/vendor'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(registrationData.toJson()),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        final errorBody = jsonDecode(response.body);
        throw Exception(errorBody['msg'] ?? 'Error desconocido');
      }
    } catch (e) {
      print('Excepción durante el registro: $e');
      return false;
    }
  }

  /// Subir imagen al servidor
  Future<bool> uploadImage({
    required File imageFile,
    required String jwtToken,
    String postId = '0',
  }) async {
    try {
      // Usar el endpoint específico para subir imágenes
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://compratodo.com/wp-json/wp/v2/media'),
      );

      // Agregar encabezados con el token JWT
      request.headers.addAll({
        'Authorization': 'Bearer $jwtToken',
      });

      // Adjuntar el archivo de imagen
      request.files.add(await http.MultipartFile.fromPath(
        'file',
        imageFile.path,
      ));

      // Agregar el postId (opcional)
      request.fields['post'] = postId;

      // Enviar la solicitud y obtener la respuesta
      var response = await request.send();

      if (response.statusCode == 201) {
        print('Imagen subida con éxito');
        return true;
      } else {
        print('Error al subir la imagen: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Excepción al subir imagen: $e');
      return false;
    }
  }
}
