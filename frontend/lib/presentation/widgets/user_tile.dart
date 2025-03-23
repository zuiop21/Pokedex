import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:frontend/constants/app_colors.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key});

  @override
  Widget build(BuildContext context) {
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
            onPressed: (context) {
              //TODO
            },
            backgroundColor: AppColors.darkBlue,
            child: const Icon(
              Icons.upgrade,
              size: 45,
              color: Colors.white,
            ),
          ),
          CustomSlidableAction(
            autoClose: true,
            onPressed: (context) {
              //TODO
            },
            backgroundColor: Colors.red,
            child: const Icon(
              Icons.lock,
              size: 45,
              color: Colors.white,
            ),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Card(
          color: AppColors.blue.withAlpha(110),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: SizedBox(
            height: 80,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, right: 10, left: 20),
              child: Row(
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.blue,
                          width: 2,
                        ),
                      ),
                      child: const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20,
                        child: Icon(
                          Icons.person_outline,
                          color: AppColors.blue,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Username",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18),
                      ),
                      Text(
                        "Email@gmail.com",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.lightWhite,
                            fontSize: 18),
                      )
                    ],
                  ),
                  Spacer(
                    flex: 3,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
