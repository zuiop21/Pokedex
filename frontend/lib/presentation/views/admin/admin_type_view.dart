import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:frontend/business_logic/bloc/admin_bloc.dart';
import 'package:frontend/business_logic/bloc/pokemon_bloc.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/data/models/processed/type.dart';
import 'package:frontend/presentation/widgets/other/type_edit_dialog.dart';
import 'package:frontend/presentation/widgets/other/type_new_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminTypeView extends StatelessWidget {
  const AdminTypeView({super.key});

  //Method that returns the text color based on the type's background color
  Color getTextColorBasedOnBackground(Color backgroundColor) {
    double red = backgroundColor.r * 255;
    double green = backgroundColor.g * 255;
    double blue = backgroundColor.b * 255;

    double brightness = (red * 0.299 + green * 0.587 + blue * 0.114);

    return brightness > 128 ? Colors.black : Colors.white;
  }

  void _startUpdatingType(BuildContext context, Type type) {
    context.read<AdminBloc>().add(StartUpdatingTypeEvent(type: type));
  }

  void _stopUpdatingType(BuildContext context) {
    context.read<AdminBloc>().add(CancelTypeEvent());
  }

  void _updatePokemonTypes(BuildContext context, Type type) {
    context.read<PokemonBloc>().add(UpdateTypeEvent(type: type));
  }

  void _deletePokemonTypes(BuildContext context, Type type) {
    context.read<PokemonBloc>().add(DeleteTypeEvent(type: type));
  }

  void _startCreatingType(BuildContext context) {
    context.read<AdminBloc>().add(StartCreatingTypeEvent());
  }

  void _createPokemonTypes(BuildContext context, Type type) {
    context.read<PokemonBloc>().add(CreateNewTypeEvent(newType: type));
  }

  void _deleteType(BuildContext context, Type type) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token") ?? "";

    if (!context.mounted) return;
    context
        .read<AdminBloc>()
        .add(DeleteTypeByIdEvent(type: type, token: token));
  }

  void _showEditor(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => PopScope(
        onPopInvokedWithResult: (didPop, result) => {
          if (didPop) {_stopUpdatingType(context)}
        },
        child: TypeEditDialog(),
      ),
    );
  }

  void _showCreator(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => PopScope(
        onPopInvokedWithResult: (didPop, result) => {
          if (didPop) {_stopUpdatingType(context)}
        },
        child: TypeNewDialog(),
      ),
    );
  }

  void _showResponseDialog(BuildContext context, String type, String text) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(child: Text(type)),
        content: Text(text),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminBloc, AdminState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          _showResponseDialog(context, "Error", state.error!);
        }
        if (state.status.isUpdating) {
          _showEditor(context);
        }
        if (state.status.isUpdated) {
          _updatePokemonTypes(context, state.placeholderType!);
          _showResponseDialog(context, "Success", "Type has been updated.");
        }
        if (state.status.isPopped) {
          _deletePokemonTypes(context, state.deletedType!);
          _showResponseDialog(context, "Success", "Type has been deleted.");
        }
        if (state.status.isCreating) {
          _showCreator(context);
        }
        if (state.status.isCreated) {
          _createPokemonTypes(context, state.placeholderType!);
          _showResponseDialog(context, "Success", "Type has been created.");
        }
      },
      listenWhen: (previous, current) {
        return !(previous.status.isUpdating && current.status.isUpdating) &&
            !(previous.status.isCreating && current.status.isCreating);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.white,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Divider(
              color: AppColors.lightGrey,
              thickness: 1,
            ),
          ),
          toolbarHeight: 80,
          title: const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                "Types",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: GestureDetector(
                onTap: () => _startCreatingType(context),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    border: Border.all(color: AppColors.grey, width: 1),
                    color: Colors.white,
                  ),
                  child: Icon(
                    Icons.add,
                    size: 30,
                    color: AppColors.grey,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: BlocBuilder<PokemonBloc, PokemonState>(
                  builder: (context, state) {
                    final types = state.types;

                    return ListView.separated(
                      separatorBuilder: (context, index) =>
                          const Divider(color: Colors.white),
                      itemCount: types.length - 1,
                      itemBuilder: (context, index) {
                        final type = types[index + 1];

                        return Slidable(
                          endActionPane: ActionPane(
                            extentRatio: 0.60,
                            motion: const StretchMotion(),
                            children: [
                              CustomSlidableAction(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                ),
                                autoClose: true,
                                onPressed: (context) =>
                                    _startUpdatingType(context, type),
                                backgroundColor: AppColors.lightBlue,
                                child: const Icon(
                                  Icons.update,
                                  size: 45,
                                  color: Colors.white,
                                ),
                              ),
                              CustomSlidableAction(
                                autoClose: true,
                                onPressed: (context) =>
                                    _deleteType(context, type),
                                backgroundColor: Colors.red,
                                child: const Icon(
                                  Icons.delete,
                                  size: 45,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              height: 50,
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Color(int.parse(type.color)),
                              ),
                              child: Center(
                                child: Text(
                                  type.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: getTextColorBasedOnBackground(
                                      Color(int.parse(type.color)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
