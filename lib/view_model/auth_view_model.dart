import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/model/user_model.dart';
import 'package:mvvm/repository/auth_repository.dart';
import 'package:mvvm/utils/routes/routesName.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/user_view_model.dart';

class AuthViewModel extends ChangeNotifier {
  final _myRepo = AuthRepository();
  bool _loading = false;
  bool get loading => _loading;

  setloading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setloading(true);
    _myRepo.loginApi(data).then((value) {
      if (value is Exception) {
        setloading(false);
        print(value.toString());
        Utils.flushbarErrorMessage(value.toString(), context);
      } else {
        setloading(false);
        UserModel user = UserModel.fromJson(value);
        UserViewModel().saveUser(user);
        print(value.toString());
        print('api hit');
        Utils.toastMessage('Login Successfully');
        Navigator.pushNamed(context, RoutesName.home);
      }
    });
  }
}
