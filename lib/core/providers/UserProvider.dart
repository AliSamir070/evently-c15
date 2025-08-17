import 'package:evently_c15/model/User.dart'as MyUser;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../remote/network/FirestoreManager.dart';

class UserProvider extends ChangeNotifier{
  MyUser.User? user;

  fetchUser()async{
    user = await FirestoreManager.getUser(FirebaseAuth.instance.currentUser!.uid);
    notifyListeners();
  }
}