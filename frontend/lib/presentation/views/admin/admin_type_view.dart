import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:frontend/business_logic/bloc/pokemon_bloc.dart';
import 'package:frontend/constants/app_colors.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                    extentRatio: 0.30,
                    motion: const StretchMotion(),
                    children: [
                      CustomSlidableAction(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                        autoClose: true,
                        onPressed: (context) {
                          //TODO
                        },
                        backgroundColor: AppColors.lightBlue,
                        child: const Icon(
                          Icons.update,
                          size: 45,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
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
    );
  }
}
