import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/admin_bloc.dart';
import 'package:frontend/presentation/pages/admin_init_page.dart';
import 'package:frontend/presentation/pages/admin_user_page.dart';
import 'package:frontend/presentation/views/loading_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminUserView extends StatefulWidget {
  const AdminUserView({super.key});

  @override
  State<AdminUserView> createState() => _AdminUserViewState();
}

class _AdminUserViewState extends State<AdminUserView> {
  @override
  void initState() {
    super.initState();
    _refreshData(context);
  }

  Future<void> _refreshData(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token") ?? "";

    if (!context.mounted) return;
    context.read<AdminBloc>().add(GetAllUsersEvent(token: token));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminBloc, AdminState>(
      builder: (context, state) {
        switch (state.status) {
          case AdminStatus.failure:
            return Scaffold(
                body: AdminInitPage(
                    error: state.error, func: () => _refreshData(context)));

          case AdminStatus.initial:
          case AdminStatus.creating:
          case AdminStatus.created:
          case AdminStatus.updating:
          case AdminStatus.updated:
          case AdminStatus.popped:
          case AdminStatus.adding:
          case AdminStatus.added:
          case AdminStatus.deleted:
            return Scaffold(
                body: AdminInitPage(func: () => _refreshData(context)));

          case AdminStatus.loading:
            return const LoadingView();

          case AdminStatus.success:
            return AdminUserPage();
        }
      },
    );
  }
}
