import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/admin_bloc.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminPokemonAppbar extends StatelessWidget {
  final int index;
  const AdminPokemonAppbar({super.key, required this.index});

  void _navigateBack(BuildContext context) {
    context.read<AdminBloc>().add(CancelActionEvent());
    if (index != 0) {
      context.read<AdminBloc>().add(PopPokemonEvent());
    }

    Navigator.pop(context);
  }

  Future<void> _pickImageFromGallery(BuildContext context) async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (!context.mounted) return;

    if (returnedImage == null) return;
    context
        .read<AdminBloc>()
        .add(AddPokemonImageEvent(image: File(returnedImage.path)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminBloc, AdminState>(
      buildWhen: (previous, current) => !current.status.isDeleted,
      builder: (context, state) {
        final strengthTypes = context
            .read<AdminBloc>()
            .state
            .newPokemons[state.currentIndex]
            .getStrengthTypesForPokemon();

        return Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -MediaQuery.of(context).size.width * 0.6,
              left: -MediaQuery.of(context).size.width * 0.055,
              child: ShaderMask(
                //TODO blurred img
                //TODO kör alapján levágás
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.black, Colors.transparent],
                    stops: [0.75, 1.0],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.dstIn,
                child: Container(
                  width: MediaQuery.of(context).size.width * 1.1,
                  height: MediaQuery.of(context).size.width * 1.1,
                  decoration: BoxDecoration(
                    color: Color(int.parse(strengthTypes[0].color)),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 50,
              left: 20,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white, size: 28),
                onPressed: () => _navigateBack(context),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: SizedBox(
                  width: 135,
                  height: 135,
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black, Colors.transparent],
                        stops: [0.5, 1.0],
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.dstIn,
                    child: strengthTypes[0].imgUrlOutline.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: strengthTypes[0].imgUrlOutline,
                            fit: BoxFit.contain,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          )
                        : Icon(Icons.error),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppColors.grey, width: 1),
                    color: Colors.white,
                  ),
                  child: state.images[index].path.isNotEmpty
                      ? Image.file(state.images[index])
                      : IconButton(
                          onPressed: () => _pickImageFromGallery(context),
                          icon:
                              Icon(Icons.add, size: 50, color: AppColors.grey)),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
