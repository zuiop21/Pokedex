import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/admin_bloc.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/presentation/widgets/admin/admin_type_slider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TypeNewDialog extends StatefulWidget {
  const TypeNewDialog({super.key});

  @override
  State<TypeNewDialog> createState() => _TypeEditDialogState();
}

class _TypeEditDialogState extends State<TypeNewDialog> {
  Color getTextColorBasedOnBackground(Color backgroundColor) {
    double red = backgroundColor.r * 255;
    double green = backgroundColor.g * 255;
    double blue = backgroundColor.b * 255;

    double brightness = (red * 0.299 + green * 0.587 + blue * 0.114);

    return brightness > 128 ? Colors.black : Colors.white;
  }

  void _changeRValue(BuildContext context, double newValue) {
    context.read<AdminBloc>().add(UpdateTypeVisuallyEvent(newR: newValue));
  }

  void _changeGValue(BuildContext context, double newValue) {
    context.read<AdminBloc>().add(UpdateTypeVisuallyEvent(newG: newValue));
  }

  void _changeBValue(BuildContext context, double newValue) {
    context.read<AdminBloc>().add(UpdateTypeVisuallyEvent(newB: newValue));
  }

  void _stopCreatingType(BuildContext context) {
    context.read<AdminBloc>().add(CancelTypeEvent());
  }

  Future<void> _createType(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token") ?? "";

    if (!context.mounted) return;
    context
        .read<AdminBloc>()
        .add(CreateTypeEvent(token: token, name: _controller.text.toString()));
  }

  Future<void> _pickImageFromGallery(BuildContext context) async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (!context.mounted) return;

    if (returnedImage == null) return;
    context
        .read<AdminBloc>()
        .add(AddTypeImageEvent(image: File(returnedImage.path)));
  }

  Future<void> _pickImageOutlineFromGallery(BuildContext context) async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (!context.mounted) return;

    if (returnedImage == null) return;
    context
        .read<AdminBloc>()
        .add(AddTypeImageOutlineEvent(image: File(returnedImage.path)));
  }

  @override
  initState() {
    super.initState();
    _controller.text = context.read<AdminBloc>().state.placeholderType!.name;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminBloc, AdminState>(
      builder: (context, state) {
        final color = Color(int.parse(state.placeholderType!.color));
        return AlertDialog(
          backgroundColor: Colors.white,
          content: SizedBox(
            width: double.infinity,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 50,
                      color: color,
                    ),
                    if (state.placeholderFileOutline != null)
                      Image.file(
                        state.placeholderFileOutline!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    TextFormField(
                      cursorColor: AppColors.blue,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: getTextColorBasedOnBackground(color),
                        fontWeight: FontWeight.bold,
                      ),
                      controller: _controller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: GestureDetector(
                          onTap: () => _pickImageOutlineFromGallery(context),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border:
                                  Border.all(color: AppColors.grey, width: 1),
                              color: Colors.white,
                            ),
                            width: 40,
                            height: 40,
                            child: Icon(
                              Icons.add,
                              size: 30,
                              color: AppColors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 80,
                        child: SizedBox(
                          height: 140,
                          child: Stack(
                            children: [
                              if (state.placeholderFile != null)
                                Center(
                                  child: Image.file(
                                    state.placeholderFile!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: AdminTypeSlider(
                                    colorType: "R",
                                    colorValue: color.r,
                                    onChanged: (newValue) =>
                                        _changeRValue(context, newValue),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 40,
                                left: 0,
                                right: 0,
                                child: Center(
                                  child: AdminTypeSlider(
                                    colorType: "G",
                                    colorValue: color.g,
                                    onChanged: (newValue) =>
                                        _changeGValue(context, newValue),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 80,
                                left: 0,
                                right: 0,
                                child: AdminTypeSlider(
                                  colorType: "B",
                                  colorValue: color.b,
                                  onChanged: (newValue) =>
                                      _changeBValue(context, newValue),
                                ),
                              ),
                            ],
                          ),
                        )),
                    Expanded(
                      flex: 15,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: GestureDetector(
                          onTap: () => _pickImageFromGallery(context),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border:
                                  Border.all(color: AppColors.grey, width: 1),
                              color: Colors.white,
                            ),
                            width: 40,
                            height: 40,
                            child: Icon(
                              Icons.add,
                              size: 30,
                              color: AppColors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
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
                        _stopCreatingType(context);
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
                        await _createType(
                          context,
                        );
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
