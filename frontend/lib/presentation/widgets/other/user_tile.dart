import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:frontend/business_logic/bloc/admin_bloc.dart';
import 'package:frontend/business_logic/bloc/auth_bloc.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/presentation/widgets/other/user_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserTile extends StatelessWidget {
  final int userId;
  const UserTile({super.key, required this.userId});

  void _updateUserById(BuildContext context,
      {String? newRole, bool? newLock}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token") ?? "";

    if (!context.mounted) return;
    context.read<AdminBloc>().add(UpdateUserByIdEvent(
        token: token, userId: userId, role: newRole, isLocked: newLock));
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = context.read<AuthBloc>().state.user;
    final user = context
        .read<AdminBloc>()
        .state
        .users
        .where((u) => u.id == userId)
        .first;
    //Return a un-interactive card if it belongs to the superadmin
    return user.role == "super" ||
            (user.role == "admin" && currentUser?.role == "admin")
        ? UserCard(
            role: user.role,
            email: user.email,
            name: user.name,
            isLocked: user.isLocked)
        : Slidable(
            endActionPane: ActionPane(
              extentRatio: currentUser?.role == "super" ? 0.6 : 0.3,
              motion: const StretchMotion(),
              children: [
                //Upgrade/Downgrade user, if the current user is the superadmin
                if (currentUser?.role == "super")
                  CustomSlidableAction(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                    autoClose: true,
                    onPressed: (context) => _updateUserById(context,
                        newRole: user.role == "admin" ? "user" : "admin"),
                    backgroundColor: user.role == "admin"
                        ? AppColors.darkBlue
                        : AppColors.darkBlue,
                    child: user.role == "admin"
                        ? Transform.rotate(
                            angle: 3.14159, //Rotate with PI
                            child: const Icon(
                              Icons.upgrade,
                              size: 45,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(
                            Icons.upgrade,
                            size: 45,
                            color: Colors.white,
                          ),
                  ),

                //Lock/Unlock a users account
                CustomSlidableAction(
                  borderRadius: currentUser?.role == "super"
                      ? BorderRadius.zero
                      : const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                  autoClose: true,
                  onPressed: (context) =>
                      _updateUserById(context, newLock: !user.isLocked),
                  backgroundColor: user.isLocked ? AppColors.blue : Colors.red,
                  child: user.isLocked
                      ? const Icon(
                          Icons.lock_open,
                          size: 45,
                          color: Colors.white,
                        )
                      : const Icon(
                          Icons.lock_outline,
                          size: 45,
                          color: Colors.white,
                        ),
                ),
              ],
            ),
            child: UserCard(
              role: user.role,
              email: user.email,
              name: user.name,
              isLocked: user.isLocked,
            ),
          );
  }
}
