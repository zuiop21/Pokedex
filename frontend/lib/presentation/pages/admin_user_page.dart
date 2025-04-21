import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/admin_bloc.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/data/models/processed/user.dart';
import 'package:frontend/presentation/widgets/other/user_tile.dart';

class AdminUserPage extends StatelessWidget {
  const AdminUserPage({
    super.key,
  });

  Map<String, List<User>> groupUsersByRole(List<User> users) {
    final grouped = groupBy(users, (user) => user.role);

    final sortedEntries = grouped.entries.toList()
      ..sort((a, b) => a.value.length.compareTo(b.value.length));

    return Map<String, List<User>>.fromEntries(sortedEntries);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
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
              "Users",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
        ),
      ),
      body: BlocBuilder<AdminBloc, AdminState>(
        builder: (context, state) {
          final users = state.users;
          final groupedUsers = groupUsersByRole(users);

          if (users.isEmpty) {
            return const Center(child: Text('No users found.'));
          }

          return ListView(
            children: groupedUsers.entries.map(
              (entry) {
                final role = entry.key;
                final userList = entry.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      child: Text(
                        role.toUpperCase(),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) =>
                          const Divider(color: Colors.white),
                      itemCount: userList.length,
                      itemBuilder: (context, index) {
                        return UserTile(
                          userId: userList[index].id,
                        );
                      },
                    ),
                  ],
                );
              },
            ).toList(),
          );
        },
      ),
    );
  }
}
