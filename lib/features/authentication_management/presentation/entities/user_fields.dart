enum UserFields {
  firstName,
  lastName,
  email,
  password,
  newPassword,
  confirmNewPassword,
  emailOrPhone,
  mobile,
  month,
  establishmentNumber,
  birthDate,
  idNumber,
  gender,
  country,
  state;

  String get field {
    switch (this) {
      case UserFields.firstName:
        return 'firstName';
      case UserFields.lastName:
        return 'lastName';
      case UserFields.email:
        return 'email';
      case UserFields.password:
        return 'password';
      case UserFields.newPassword:
        return 'newPassword';
      case UserFields.confirmNewPassword:
        return 'confirmNewPassword';
      case UserFields.emailOrPhone:
        return 'emailOrPhone';
      case UserFields.mobile:
        return 'mobile';
      case UserFields.month:
        return 'month';
      case UserFields.establishmentNumber:
        return 'establishmentNumber';
      case UserFields.birthDate:
        return 'birthDate';
      case UserFields.idNumber:
        return 'idNumber';
      case UserFields.gender:
        return 'gender';
      case UserFields.country:
        return 'country';
      case UserFields.state:
        return 'state';
      default:
        return '';
    }
  }
}
