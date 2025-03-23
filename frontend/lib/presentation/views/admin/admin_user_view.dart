import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/admin_bloc.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/presentation/widgets/user_tile.dart';

class AdminUserView extends StatelessWidget {
  const AdminUserView({super.key});

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
              "Users",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
        ),
      ),
      body: BlocBuilder<AdminBloc, AdminState>(
        builder: (context, state) {
          return ListView.separated(
            separatorBuilder: (context, index) =>
                const Divider(color: Colors.white),
            itemCount: 10,
            itemBuilder: (context, index) {
              return UserTile();
            },
          );
        },
      ),
    );
  }
}
