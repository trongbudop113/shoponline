import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_project/notifier/auth_notifier.dart';

signOut(AuthNotifier authNotifier) async {
  await FirebaseAuth.instance.signOut().catchError((error) => print(error.code));

  //authNotifier.setUser(null);
}
