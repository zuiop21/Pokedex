import 'package:flutter/material.dart';
import 'package:frontend/constants/app_assets.dart';
import 'package:frontend/constants/app_colors.dart';

class RegionTile extends StatelessWidget {
  const RegionTile({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {}, //TODO buttonaction
      child: Card(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: SizedBox(
            height: 110,
            width: MediaQuery.of(context).size.width,
            child: Stack(children: [
              Image.asset(AppAssets.region1, fit: BoxFit.cover),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [0.2, 1.0],
                    colors: [
                      Colors.black.withAlpha(130),
                      AppColors.lightGrey.withAlpha(80),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Kanto",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 22),
                        ),
                        Text(
                          "GENERATION 1",
                          style: TextStyle(
                              fontSize: 15, color: AppColors.lightWhite),
                        )
                      ],
                    ),
                    Spacer(
                      flex: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(
                        Icons.circle,
                        size: 50,
                      ),
                    ),
                    Icon(
                      Icons.circle,
                      size: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(
                        Icons.circle,
                        size: 50,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
