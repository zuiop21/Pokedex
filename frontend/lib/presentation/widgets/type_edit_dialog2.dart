import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/admin_bloc.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/presentation/widgets/admin_type_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';

//TODO Merge with type edit dialog
class TypeEditDialog2 extends StatefulWidget {
  const TypeEditDialog2({super.key});

  @override
  State<TypeEditDialog2> createState() => _TypeEditDialogState();
}

class _TypeEditDialogState extends State<TypeEditDialog2> {
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
    context.read<AdminBloc>().add(CancelEvent());
  }

  void _createType(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token") ?? "";

    if (!context.mounted) return;
    context
        .read<AdminBloc>()
        .add(CreateTypeEvent(token: token, name: _controller.text.toString()));
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
                Container(
                  width: double.infinity,
                  height: 50,
                  color: color,
                  child: TextFormField(
                    cursorColor: AppColors.blue,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: getTextColorBasedOnBackground(color),
                      fontWeight: FontWeight.bold,
                    ),
                    controller: _controller,
                    decoration: InputDecoration(
                      border: InputBorder.none, // Removes the underline
                    ),
                  ),
                ),
                AdminTypeSlider(
                  colorType: "R",
                  colorValue: color.r,
                  onChanged: (newValue) => _changeRValue(context, newValue),
                ),
                AdminTypeSlider(
                  colorType: "G",
                  colorValue: color.g,
                  onChanged: (newValue) => _changeGValue(context, newValue),
                ),
                AdminTypeSlider(
                  colorType: "B",
                  colorValue: color.b,
                  onChanged: (newValue) => _changeBValue(context, newValue),
                ),
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
                      onPressed: () {
                        _createType(
                          context,
                        );
                        Navigator.of(context).pop();
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
