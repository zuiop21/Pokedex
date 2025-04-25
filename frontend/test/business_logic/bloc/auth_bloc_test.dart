import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/business_logic/bloc/auth_bloc.dart';
import 'package:frontend/data/models/processed/user.dart';
import 'package:frontend/data/repositories/auth_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class FakeFile extends Fake implements File {}

void main() {
  late MockAuthRepository mockedPokemonRepo;
  late User testUser;
  late String testToken;

  setUpAll(() {
    registerFallbackValue(FakeFile());
  });

  setUp(() {
    mockedPokemonRepo = MockAuthRepository();
    testToken = "userToken";
    testUser = const User(
      id: 1,
      email: "userEmail",
      name: "userName",
      role: "admin",
      regionId: 1,
      isLocked: false,
      imgUrl: "userImage",
    );
  });

  group("Profile picture event", () {
    blocTest<AuthBloc, AuthState>(
      'emits [loading, success] when profile picture is uploaded.',
      setUp: () {
        when(() => mockedPokemonRepo.uploadImage(any(), any()))
            .thenAnswer((_) async => testUser);
      },
      build: () => AuthBloc(mockedPokemonRepo),
      act: (bloc) => bloc.add(UploadProfilePictureEvent(
          image: File(testUser.imgUrl!), token: testToken)),
      expect: () => [
        const AuthState(status: AuthStatus.loading),
        AuthState(
          status: AuthStatus.success,
          user: testUser,
        ),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [loading, failure] when profile picture upload fails.',
      setUp: () {
        when(() => mockedPokemonRepo.uploadImage(any(), any()))
            .thenThrow(Exception("Upload failed"));
      },
      build: () => AuthBloc(mockedPokemonRepo),
      act: (bloc) => bloc.add(UploadProfilePictureEvent(
          image: File(testUser.imgUrl!), token: testToken)),
      expect: () => [
        const AuthState(status: AuthStatus.loading),
        const AuthState(
          status: AuthStatus.failure,
          error: "Exception: Upload failed",
        ),
      ],
    );
  });

  group("Asyncronous auth event", () {
    blocTest<AuthBloc, AuthState>(
      'emits [loading, success] when login is successful.',
      setUp: () {
        when(() => mockedPokemonRepo.login(any(), any()))
            .thenAnswer((_) async => testUser);
      },
      build: () => AuthBloc(mockedPokemonRepo),
      act: (bloc) =>
          bloc.add(LoginEvent(email: testUser.email, password: "userPassword")),
      expect: () => [
        const AuthState(status: AuthStatus.loading),
        AuthState(
          status: AuthStatus.success,
          user: testUser,
        ),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [loading, failure] when login fails.',
      setUp: () {
        when(() => mockedPokemonRepo.login(any(), any()))
            .thenThrow(Exception("Login failed"));
      },
      build: () => AuthBloc(mockedPokemonRepo),
      act: (bloc) =>
          bloc.add(LoginEvent(email: testUser.email, password: "userPassword")),
      expect: () => [
        const AuthState(status: AuthStatus.loading),
        const AuthState(
          status: AuthStatus.failure,
          error: "Exception: Login failed",
        ),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [loading, success] when register is successful.',
      setUp: () {
        when(() => mockedPokemonRepo.register(any(), any()))
            .thenAnswer((_) async => testUser);
      },
      build: () => AuthBloc(mockedPokemonRepo),
      act: (bloc) => bloc
          .add(RegisterEvent(email: testUser.email, password: "userPassword")),
      expect: () => [
        const AuthState(status: AuthStatus.loading),
        AuthState(
          status: AuthStatus.success,
          user: testUser,
        ),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [loading, failure] when register fails.',
      setUp: () {
        when(() => mockedPokemonRepo.register(any(), any()))
            .thenThrow(Exception("Register failed"));
      },
      build: () => AuthBloc(mockedPokemonRepo),
      act: (bloc) => bloc
          .add(RegisterEvent(email: testUser.email, password: "userPassword")),
      expect: () => [
        const AuthState(status: AuthStatus.loading),
        const AuthState(
          status: AuthStatus.failure,
          error: "Exception: Register failed",
        ),
      ],
    );
  });
}
