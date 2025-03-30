import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/auth_bloc.dart';
import 'package:frontend/business_logic/bloc/pokemon_bloc.dart';
import 'package:frontend/presentation/widgets/other/info_text.dart';

import 'package:frontend/presentation/widgets/other/info_button.dart';
import 'package:frontend/presentation/widgets/other/info_switch.dart';

class PokemonUserPage extends StatelessWidget {
  const PokemonUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthBloc>().state.user;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Account information",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              InfoButton(
                  title: "Name",
                  subTitle: user!.name,
                  function: () {}), //TODO func
              InfoButton(
                  title: "Email",
                  subTitle: user.email,
                  function: () {}), //TODO func
              InfoButton(
                  title: "Password",
                  subTitle: "**********",
                  function: () {}), //TODO func
              InfoText(
                  title: "From",
                  subTitle: context
                      .read<PokemonBloc>()
                      .state
                      .regions
                      .where((r) => r.id == user.regionId)
                      .first
                      .name),
              InfoText(title: "Role", subTitle: user.role),

              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Text(
                  "Pokédex",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              InfoSwitch(
                  title: "Mega evolutions",
                  subTitle: "Enables the display of mega evolutions.",
                  function: () {}),
              InfoSwitch(
                  title: "Other forms",
                  subTitle: "Enables the display of a Pokémon's other forms.",
                  function: () {}),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Text(
                  "Language",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              InfoText(
                  title: "Interface language", subTitle: "English (en-US)"),
              InfoText(
                  title: "In-game information language",
                  subTitle: "English (US)"),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Text(
                  "General",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              InfoText(title: "Version", subTitle: "1.0.0"),

              InfoText(
                  title: "Terms and conditions",
                  subTitle: "Everything you need to know."),

              InfoText(
                  title: "Help center", subTitle: "Need help? Contact us!"),
              InfoText(title: "About", subTitle: "Learn more about the app."),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Text(
                  "Outros",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              InfoText(
                  titleColor: Colors.red,
                  title: "Log out",
                  subTitle: "You are logged in as ${user.name}."),
            ],
          ),
        ),
      ),
    );
  }
}
