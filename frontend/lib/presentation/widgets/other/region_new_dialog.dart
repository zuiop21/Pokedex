import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/admin_bloc.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/presentation/widgets/other/edge_to_edge_track_shape.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegionNewDialog extends StatefulWidget {
  const RegionNewDialog({super.key});

  @override
  State<RegionNewDialog> createState() => _RegionNewDialogState();
}

class _RegionNewDialogState extends State<RegionNewDialog> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickImageFromGallery(BuildContext context) async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (!context.mounted) return;

    if (returnedImage == null) return;
    context
        .read<AdminBloc>()
        .add(AddRegionImageEvent(image: File(returnedImage.path)));
  }

  Future<void> _createRegion(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token") ?? "";

    if (!context.mounted) return;
    context.read<AdminBloc>().add(CreateRegionEvent(token: token));
  }

  void _changeSliderValue(BuildContext context, double newValue) {
    context.read<AdminBloc>().add(EditRegionEvent(difficulty: newValue));
  }

  void _changeName(BuildContext context) {
    context
        .read<AdminBloc>()
        .add(EditRegionEvent(name: _nameController.text.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminBloc, AdminState>(
      builder: (context, state) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: SizedBox(
            height: 120,
            width: double.infinity,
            child: Column(
              children: [
                Expanded(
                  flex: 70,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Stack(children: [
                      if (state.placeholderFile != null)
                        Positioned.fill(
                          child: Image.file(
                            state.placeholderFile!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            stops: [0.25, 1.0],
                            colors: [
                              Colors.black.withAlpha(130),
                              AppColors.lightGrey.withAlpha(80),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 65, left: 25),
                          child: TextField(
                            onChanged: (value) => _changeName(context),
                            textAlign: TextAlign.center,
                            controller: _nameController,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                              hintText: "Name",
                              hintStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: GestureDetector(
                            onTap: () => _pickImageFromGallery(context),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border:
                                    Border.all(color: AppColors.grey, width: 1),
                                color: Colors.white,
                              ),
                              width: 50,
                              height: 50,
                              child: Icon(
                                Icons.add,
                                size: 30,
                                color: AppColors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
                Expanded(
                    flex: 30,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 10,
                            trackShape: EdgeToEdgeTrackShape(),
                            thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 10),
                          ),
                          child: Slider(
                            activeColor: AppColors.blue,
                            value:
                                state.placeholderRegion!.difficulty.toDouble(),
                            onChanged: (value) =>
                                _changeSliderValue(context, value),
                            min: 0,
                            max: 10,
                            divisions: 10,
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.blue,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "CANCEL",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.blue,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        await _createRegion(context);
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text(
                        "SAVE",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
