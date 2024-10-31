class RegistrationModel {
  // datos usuario
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? shopName;
  final String? addressLine1;
  final String? addressLine2;
  final String? country;
  final String? city;
  final String? region;
  final String? postalCode;
  final String? password;

  // configuracion tienda
  final String? shopPhone;
  final String? idLogo;
  final String? idBanner;
  final String? emailStore;
  final String? shopDescription;

  // metodo de pago tienda
  final String? paymentMethod; // Agregado
  final String? accountName; // Agregado
  final String? accountNumber; // Agregado
  final String? bankName; // Agregado
  final String? emailPayment; // Agregado

  // Parámetros de políticas
  final String? shippingPolicy; // Agregado
  final String? refundPolicy; // Agregado
  final String? cancellationPolicy; // Agregado

  // Parámetros de contacto de soporte
  final String? supportPhone; // Teléfono de contacto de soporte
  final String? supportEmail; // Email de contacto de soporte
  final String? supportAddress1; // Dirección 1 de contacto de soporte
  final String? supportAddress2; // Dirección 2 de contacto de soporte
  final String? supportCountry; // País de contacto de soporte
  final String? supportCity; // Ciudad de contacto de soporte
  final String? supportState; // Estado de contacto de soporte
  final String? supportPostcode; // Código postal de contacto de soporte

  RegistrationModel({
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.shopName,
    this.addressLine1,
    this.addressLine2,
    this.country,
    this.city,
    this.region,
    this.postalCode,
    this.shopPhone,
    this.password,
    this.idLogo,
    this.idBanner,
    this.emailStore,
    this.shopDescription,
    this.paymentMethod, // Agregado
    this.accountName, // Agregado
    this.accountNumber, // Agregado
    this.bankName, // Agregado
    this.emailPayment, // Agregado
    this.shippingPolicy, // Agregado
    this.refundPolicy, // Agregado
    this.cancellationPolicy, // Agregado
    this.supportPhone, // Teléfono de contacto de soporte
    this.supportEmail, // Email de contacto de soporte
    this.supportAddress1, // Dirección 1 de contacto de soporte
    this.supportAddress2, // Dirección 2 de contacto de soporte
    this.supportCountry, // País de contacto de soporte
    this.supportCity, // Ciudad de contacto de soporte
    this.supportState, // Estado de contacto de soporte
    this.supportPostcode, // Código postal de contacto de soporte
  });

  // Método copyWith para actualizar solo los parámetros deseados
  RegistrationModel copyWith({
    String? username,
    String? firstName,
    String? lastName,
    String? email,
    String? shopName,
    String? addressLine1,
    String? addressLine2,
    String? country,
    String? city,
    String? region,
    String? postalCode,
    String? shopPhone,
    String? password,
    String? idLogo,
    String? idBanner,
    String? emailStore,
    String? shopDescription,
    String? paymentMethod, // Agregado
    String? accountName, // Agregado
    String? accountNumber, // Agregado
    String? bankName, // Agregado
    String? emailPayment, // Agregado
    String? shippingPolicy, // Agregado
    String? refundPolicy, // Agregado
    String? cancellationPolicy, // Agregado
    String? supportPhone, // Teléfono de contacto de soporte
    String? supportEmail, // Email de contacto de soporte
    String? supportAddress1, // Dirección 1 de contacto de soporte
    String? supportAddress2, // Dirección 2 de contacto de soporte
    String? supportCountry, // País de contacto de soporte
    String? supportCity, // Ciudad de contacto de soporte
    String? supportState, // Estado de contacto de soporte
    String? supportPostcode, // Código postal de contacto de soporte
  }) {
    return RegistrationModel(
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      shopName: shopName ?? this.shopName,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      country: country ?? this.country,
      city: city ?? this.city,
      region: region ?? this.region,
      postalCode: postalCode ?? this.postalCode,
      shopPhone: shopPhone ?? this.shopPhone,
      password: password ?? this.password,
      idLogo: idLogo ?? this.idLogo,
      idBanner: idBanner ?? this.idBanner,
      emailStore: emailStore ?? this.emailStore,
      shopDescription: shopDescription ?? this.shopDescription,
      paymentMethod: paymentMethod ?? this.paymentMethod, // Agregado
      accountName: accountName ?? this.accountName, // Agregado
      accountNumber: accountNumber ?? this.accountNumber, // Agregado
      bankName: bankName ?? this.bankName, // Agregado
      emailPayment: emailPayment ?? this.emailPayment, // Agregado
      shippingPolicy: shippingPolicy ?? this.shippingPolicy, // Agregado
      refundPolicy: refundPolicy ?? this.refundPolicy, // Agregado
      cancellationPolicy:
          cancellationPolicy ?? this.cancellationPolicy, // Agregado
      supportPhone:
          supportPhone ?? this.supportPhone, // Teléfono de contacto de soporte
      supportEmail:
          supportEmail ?? this.supportEmail, // Email de contacto de soporte
      supportAddress1: supportAddress1 ??
          this.supportAddress1, // Dirección 1 de contacto de soporte
      supportAddress2: supportAddress2 ??
          this.supportAddress2, // Dirección 2 de contacto de soporte
      supportCountry:
          supportCountry ?? this.supportCountry, // País de contacto de soporte
      supportCity:
          supportCity ?? this.supportCity, // Ciudad de contacto de soporte
      supportState:
          supportState ?? this.supportState, // Estado de contacto de soporte
      supportPostcode: supportPostcode ??
          this.supportPostcode, // Código postal de contacto de soporte
    );
  }

  // Método toJson para convertir el objeto a un mapa JSON
  Map<String, dynamic> toJson() {
    return {
      // Registro
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'shopName': shopName,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'country': country,
      'city': city,
      'region': region,
      'postalCode': postalCode,
      'phoneNumberStore': shopPhone,
      'password': password,
      // Paso 1
      'idLogo': idLogo,
      'idBanner': idBanner,
      'emailStore': emailStore,
      'shopDescription': shopDescription,
      // Paso 2
      'paymentMethod': paymentMethod,
      'accountName': accountName,
      'accountNumber': accountNumber,
      'bankName': bankName,
      'emailPayment': emailPayment,
      // Paso3
      'shippingPolicy': shippingPolicy,
      'refundPolicy': refundPolicy,
      'cancellationPolicy': cancellationPolicy,
      // Paso 4
      'supportPhone': supportPhone,
      'supportEmail': supportEmail,
      'supportAddress1': supportAddress1,
      'supportAddress2': supportAddress2,
      'supportCountry': supportCountry,
      'supportCity': supportCity,
      'supportState': supportState,
      'supportPostcode': supportPostcode,
    };
  }

  Map<String, dynamic> toJsonRegisterVendor() {
    return {
      // Registro
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'shopName': shopName,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'country': country,
      'city': city,
      'region': region,
      'postalCode': postalCode,
      'phoneNumberStore': shopPhone,
      'password': password,
    };
  }
}
