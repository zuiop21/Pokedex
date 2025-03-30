import 'package:flutter/material.dart';
import 'package:frontend/presentation/widgets/other/info_button.dart';

class PokemonAdminPage extends StatelessWidget {
  const PokemonAdminPage({super.key});

  void _handleNavigationToAdminUserView(BuildContext context) {
    Navigator.of(context).pushNamed("/admin/users");
  }

  void _handleNavigationToAdminPokemonView(BuildContext context) {
    Navigator.of(context).pushNamed("/admin/pokemons");
  }

  void _handleNavigationToAdminRegionView(BuildContext context) {
    Navigator.of(context).pushNamed("/admin/regions");
  }

  void _handleNavigationToAdminTypeView(BuildContext context) {
    Navigator.of(context).pushNamed("/admin/types");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Operations",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            InfoButton(
                title: "Edit users",
                subTitle: "Manage user access and roles",
                function: () => _handleNavigationToAdminUserView(context)),
            InfoButton(
                title: "Pokémons",
                subTitle: "Create/Edit/Delete",
                function: () => _handleNavigationToAdminPokemonView(context)),
            InfoButton(
                title: "Regions",
                subTitle: "Create/Edit/Delete",
                function: () => _handleNavigationToAdminRegionView(context)),
            InfoButton(
                title: "Types",
                subTitle: "Create/Edit/Delete",
                function: () => _handleNavigationToAdminTypeView(context)),
          ],
        ),
      ),
    );
  }
}
