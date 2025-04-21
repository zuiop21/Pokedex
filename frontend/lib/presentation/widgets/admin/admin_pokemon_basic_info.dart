import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/admin_bloc.dart';
import 'package:frontend/presentation/widgets/admin/admin_pokemon_tile_types.dart';

//A widget that displays some basic information of a pokemon
//Such as the name, id, types and description
class AdminPokemonBasicInfo extends StatefulWidget {
  final int index;
  const AdminPokemonBasicInfo({
    super.key,
    required this.index,
  });

  @override
  State<AdminPokemonBasicInfo> createState() => _AdminPokemonBasicInfoState();
}

class _AdminPokemonBasicInfoState extends State<AdminPokemonBasicInfo> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _changePokemonName(BuildContext context) {
    final name = _nameController.text;
    context.read<AdminBloc>().add(EditPokemonNameEvent(
          name: name,
        ));
  }

  void _changePokemonDescription(BuildContext context) {
    final description = _descriptionController.text;
    context.read<AdminBloc>().add(EditPokemonDescriptionEvent(
          description: description,
        ));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                onChanged: (value) => _changePokemonName(context),
                style: const TextStyle(fontSize: 36),
                cursorHeight: 36,
                decoration: const InputDecoration(
                    hintText: "Name",
                    hintStyle: TextStyle(fontSize: 36),
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(8.0)),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: AdminPokemonTileTypes(
              index: widget.index,
            ),
          ),
          TextFormField(
            controller: _descriptionController,
            onChanged: (value) => _changePokemonDescription(context),
            style: const TextStyle(fontSize: 18),
            maxLines: null,
            keyboardType: TextInputType.multiline,
            cursorHeight: 18,
            decoration: const InputDecoration(
              hintText:
                  "This is the description of the Pokemon, that describes the Pokemon in a few words.",
              hintStyle: TextStyle(fontSize: 18),
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(8.0),
            ),
          ),
        ],
      ),
    );
  }
}
