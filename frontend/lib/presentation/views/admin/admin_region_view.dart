import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:frontend/business_logic/bloc/admin_bloc.dart';
import 'package:frontend/business_logic/bloc/pokemon_bloc.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/data/models/processed/region.dart';
import 'package:frontend/presentation/widgets/admin/admin_region_tile.dart';
import 'package:frontend/presentation/widgets/other/region_edit_dialog.dart';
import 'package:frontend/presentation/widgets/other/region_new_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminRegionView extends StatelessWidget {
  const AdminRegionView({super.key});

  void _cancelRegionAction(BuildContext context) {
    context.read<AdminBloc>().add(CancelRegionEvent());
  }

  void _startCreatingRegion(BuildContext context) {
    context.read<AdminBloc>().add(StartCreatingRegionEvent());
  }

  void _startUpdatingRegion(BuildContext context, Region region) {
    context.read<AdminBloc>().add(StartUpdatingRegionEvent(region: region));
  }

  void _showCreator(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => PopScope(
          onPopInvokedWithResult: (didPop, result) => {
                if (didPop) {_cancelRegionAction(context)}
              },
          child: RegionNewDialog()),
    );
  }

  void _showEditor(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => PopScope(
          onPopInvokedWithResult: (didPop, result) => {
                if (didPop) {_cancelRegionAction(context)}
              },
          child: RegionEditDialog()),
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

  void _deleteRegionById(BuildContext context, Region region) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token") ?? "";

    if (!context.mounted) return;
    context
        .read<AdminBloc>()
        .add(DeleteRegionByIdEvent(region: region, token: token));
  }

  void _deleteRegion(BuildContext context, Region region) async {
    context.read<PokemonBloc>().add(DeleteRegionEvent(region: region));
  }

  void _createRegion(BuildContext context, Region region) {
    context.read<PokemonBloc>().add(CreateNewRegionEvent(newRegion: region));
  }

  void _updateRegion(BuildContext context, Region region) {
    context.read<PokemonBloc>().add(UpdateRegionEvent(region: region));
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
          _updateRegion(context, state.placeholderRegion!);
          _showResponseDialog(context, "Success", "Region has been updated.");
        }
        if (state.status.isPopped) {
          _deleteRegion(context, state.placeholderRegion!);
          _showResponseDialog(context, "Success", "Region has been deleted.");
        }
        if (state.status.isCreating) {
          _showCreator(context);
        }
        if (state.status.isCreated) {
          _createRegion(context, state.placeholderRegion!);
          _showResponseDialog(context, "Success", "Region has been created.");
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
                "Regions",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              child: GestureDetector(
                onTap: () => _startCreatingRegion(context),
                child: Container(
                  width: double.infinity,
                  height: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
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
              child: BlocBuilder<PokemonBloc, PokemonState>(
                builder: (context, state) {
                  final regions = state.regions;
                  return ListView.separated(
                    separatorBuilder: (context, index) =>
                        const Divider(color: Colors.white),
                    itemCount: regions.length,
                    itemBuilder: (context, index) {
                      return AdminRegionTile(
                        region: regions[index],
                        actions: [
                          CustomSlidableAction(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                            ),
                            autoClose: true,
                            onPressed: (context) =>
                                _startUpdatingRegion(context, regions[index]),
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
                                _deleteRegionById(context, regions[index]),
                            backgroundColor: Colors.red,
                            child: Icon(
                              Icons.delete,
                              size: 45,
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
