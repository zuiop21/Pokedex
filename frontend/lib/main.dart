import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/admin_bloc.dart';
import 'package:frontend/business_logic/bloc/auth_bloc.dart';
import 'package:frontend/business_logic/bloc/pokemon_bloc.dart';
import 'package:frontend/business_logic/cubit/auth_textfield_cubit.dart';
import 'package:frontend/constants/app_assets.dart';
import 'package:frontend/data/repositories/auth_repository.dart';
import 'package:frontend/data/repositories/pokemon_repository.dart';
import 'package:frontend/presentation/views/admin/admin_pokemon_view.dart';
import 'package:frontend/presentation/views/admin/admin_region_view.dart';
import 'package:frontend/presentation/views/admin/admin_type_view.dart';
import 'package:frontend/presentation/views/admin/admin_user_view.dart';
import 'package:frontend/presentation/views/auth/auth_login_initial_view.dart';
import 'package:frontend/presentation/views/auth/auth_register_email_view.dart';
import 'package:frontend/presentation/views/auth/auth_register_initial_view.dart';
import 'package:frontend/presentation/views/onboarding/onboarding_auth_option_view.dart';
import 'package:frontend/presentation/views/onboarding/onboarding_auth_view.dart';
import 'package:frontend/presentation/views/onboarding/onboarding_view.dart';
import 'package:frontend/presentation/views/pokemon/pokemon_info_view.dart';
import 'package:frontend/presentation/views/pokemon/pokemon_list_region_view.dart';

//Main method to run the app
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  PaintingBinding.instance.imageCache.maximumSizeBytes = 300 << 20;
  runApp(MyApp());
}

//Main widget of the app
class MyApp extends StatelessWidget {
  final AuthRepository _authRepository = AuthRepository();
  final PokemonRepository _pokemonRepository = PokemonRepository();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(_authRepository),
        ),
        BlocProvider(
          create: (context) => PokemonBloc(_pokemonRepository),
        ),
        BlocProvider(
          create: (context) => AdminBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',

        //Routes of the app
        routes: {
          "/": (context) => OnboardingView(),
          "/auth/onboarding/option": (context) => OnboardingAuthOptionView(),
          "/auth/onboarding/new": (context) => OnboardingAuthView(
                emailPath: "/auth/register/email",
                imagePath: AppAssets.trainer4,
                title: "Create an account",
                pageTitle: "There is little time left to explore this world!",
                pageSubTitle: "How would you like to register?",
              ),
          "/auth/onboarding/login": (context) => OnboardingAuthView(
                emailPath: "/auth/login",
                imagePath: AppAssets.trainer5,
                title: "Login",
                pageTitle: "So good to see you here again!",
                pageSubTitle: "How would you like to login?",
              ),
          "/auth/login": (context) => BlocProvider(
                create: (context) => AuthTextfieldCubit(),
                child: AuthLoginInitialView(),
              ),
          "/auth/register/email": (context) => BlocProvider(
                create: (context) => AuthTextfieldCubit(),
                child: AuthRegisterEmailView(),
              ),
          "/auth/register/password": (context) {
            final email = ModalRoute.of(context)!.settings.arguments as String;
            return BlocProvider(
              create: (context) => AuthTextfieldCubit(),
              child: AuthRegisterInitialView(email: email),
            );
          },
          "/pokemon/info": (context) {
            final pokemon = ModalRoute.of(context)!.settings.arguments as int;
            return PokemonInfoView(pokemonId: pokemon);
          },
          "/pokemons": (context) {
            final regionName =
                ModalRoute.of(context)!.settings.arguments as String;
            return PokemonListRegionView(regionName: regionName);
          },
          "/admin/users": (context) => AdminUserView(),
          "/admin/pokemons": (context) => AdminPokemonView(),
          "/admin/regions": (context) => AdminRegionView(),
          "/admin/types": (context) => AdminTypeView(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
