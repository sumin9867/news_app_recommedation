<<<<<<< HEAD
import 'dart:math'; // For generating random numbers
import 'package:flutter_bloc/flutter_bloc.dart';
=======
import 'package:flutter_bloc/flutter_bloc.dart';

>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d
import 'package:flutter/foundation.dart' show debugPrint;

import '../../domain/signup_model.dart';
import '../../infrastructure/auth_repositary.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepo;

  AuthCubit(this.authRepo) : super(AuthInitial());

  Future<void> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String location,
    required String password,
    required String repassword,
    required String phoneNumber,
  }) async {
    emit(AuthLoading());
    try {
      debugPrint('Attempting to sign up with email: $email');
<<<<<<< HEAD

      // Generate random longitude and latitude
      final random = Random();
      final double randomLongitude = -180 + random.nextDouble() * 360; // Range: -180 to 180
      final double randomLatitude = -90 + random.nextDouble() * 180;   // Range: -90 to 90

=======
>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d
      final signUpModel = SignUpModel(
        id: '',
        name: name,
        email: email,
        location: location,
        password: password,
        repassword: repassword,
        phoneNumber: phoneNumber,
        admin: false,
        categories: [],
<<<<<<< HEAD
        longitude: randomLongitude, // Assign random longitude
        latitude: randomLatitude,   // Assign random latitude
=======
>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d
      );

      await authRepo.createUserWithEmailAndPassword(signUpModel);
      emit(AuthLoaded());
<<<<<<< HEAD
      debugPrint('User signed up successfully with coordinates: '
          'Longitude = $randomLongitude, Latitude = $randomLatitude');
=======
      debugPrint('User signed up successfully');
>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d
    } catch (e) {
      debugPrint('Error signing up: $e');
      emit(AuthError(e.toString()));
    }
  }
}
