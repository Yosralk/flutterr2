//import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';



//import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance;

// تسجيل مستخدم جديد
Future<bool> register(String email, String password, String name) async {
  try {
    await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // تحديث اسم المستخدم داخل الحساب
    await firebaseAuth.currentUser?.updateDisplayName(name);

    return true;
  } on FirebaseAuthException catch (e) {
    print('Register Error: ${e.message}');
    return false;
  } catch (e) {
    print(e);
    return false;
  }
}

// تسجيل دخول
Future<bool> login(String email, String password) async {
  try {
    await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return true;
  } on FirebaseAuthException catch (e) {
    print('Login Error: ${e.message}');
    return false;
  } catch (e) {
    print(e);
    return false;
  }
}

//
// FirebaseAuth firebaseAuth=FirebaseAuth.instance;
//
// Future <bool> register(String email , String password)async{
//   try {
//     final credential = await firebaseAuth.createUserWithEmailAndPassword(email:
//     email, password: password
//     );
//     return true;
//   } on FirebaseAuthException catch (e) {
//     if (e.code == 'weak-password') {
//       print('The password provided is too weak.');
//     } else if (e.code == 'email-already-in-use') {
//       print('The account already exists for that email.');
//     }
//     return false;
//   } catch (e) {
//     print(e);
//   }
//   return false;
// }
//
// Future <bool> login(String email, String password)async{
//   try {
//     final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//     return true;
//   } on FirebaseAuthException catch (e) {
//     if (e.code == 'weak-password') {
//       print('The password provided is too weak.');
//     } else if (e.code == 'email-already-in-use') {
//       print('The account already exists for that email.');
//     } return false ;
//   } catch (e) {
//     print(e);
//   }return false;
// }

// Future <bool> register(String e,String pass ){
//   firebaseAuth.createUserWithEmailAndPassword(
//       email:e,
//       password: pass);
//   return true;
// }



// creatuser(String email,String password){
//  firebaseAuth.createUserWithEmailAndPassword
//    (email: email, password: password);
//
// }