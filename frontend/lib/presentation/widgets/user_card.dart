import 'package:flutter/material.dart';
import 'package:frontend/constants/app_colors.dart';

class UserCard extends StatelessWidget {
  final String email;
  final String name;
  final bool isLocked;
  final String role;
  const UserCard(
      {super.key,
      required this.email,
      required this.name,
      required this.isLocked,
      required this.role});

  @override
  Widget build(BuildContext context) {
    final color = isLocked ? Colors.red : AppColors.blue;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        color: color.withAlpha(110),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: SizedBox(
          height: 80,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 20),
            child: Row(
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: color,
                        width: 2,
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
                      child: role == "user"
                          ? Icon(
                              Icons.person_outlined,
                              color: color,
                              size: 30,
                            )
                          : Icon(
                              Icons.admin_panel_settings,
                              color: color,
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
                      name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18),
                    ),
                    Text(
                      email,
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
    );
  }
}
