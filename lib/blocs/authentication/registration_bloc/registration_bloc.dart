import 'dart:convert';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tebbi/configs/app_constants.dart';
import 'package:tebbi/models/autentication_response_model.dart';
import 'package:tebbi/models/registration_request_model.dart';
import 'package:tebbi/repositories/authentication_repository.dart';
import 'package:tebbi/shared/utilities/local_storage_utility.dart';

part 'registration_event.dart';

part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final AuthenticationRepository _authenticationRepository;

  RegistrationBloc(this._authenticationRepository)
    : super(const RegistrationInitial()) {
    on<RegistrationStarted>((
      RegistrationStarted event,
      Emitter<RegistrationState> emit,
    ) async {
      emit(const RegistrationLoading());
      try {
        final String? encodedValue = await const FlutterSecureStorage().read(
          key: AppConstants.encryptionKey,
        );

        final Uint8List encryptionKey = base64Url.decode(encodedValue!);

        final Box<dynamic> encryptedBox = await Hive.openBox(
          AppConstants.encryptionKey,
          encryptionCipher: HiveAesCipher(encryptionKey),
        );
        final AuthenticationResponse response = await _authenticationRepository
            .register(request: event.request)
            .catchError((Object? error, StackTrace stackTrace) {
              throw error is Exception ? error : Exception();
            });

        LocalStorageUtility.saveUserTokens(
          accessToken: response.data?.token ?? "",
        );
        await encryptedBox.put(
          LocalStorageUtility.emailKey,
          event.request.email,
        );
        await encryptedBox.put(
          LocalStorageUtility.passwordKey,
          event.request.password,
        );
        await LocalStorageUtility.setUserExistsOnDevice(value: true);
        emit(RegistrationSuccess(data: response));
      } on Exception catch (_) {
        emit(const RegistrationFailure());
      }
    });
  }
}
