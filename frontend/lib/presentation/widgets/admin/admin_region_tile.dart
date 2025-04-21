import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/data/models/processed/region.dart';

//A widget that displays a region

class AdminRegionTile extends StatelessWidget {
  final Region region;
  const AdminRegionTile(
      {super.key, required this.region, required this.actions});

  final List<CustomSlidableAction> actions;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
          extentRatio: 0.60, motion: const StretchMotion(), children: actions),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Card(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: SizedBox(
              height: 110,
              width: MediaQuery.of(context).size.width,
              child: Stack(children: [
                region.imgUrl.isNotEmpty
                    ? Positioned.fill(
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: region.imgUrl,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      )
                    : const Icon(Icons.error),
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
                  child: Text(
                    region.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 30),
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
