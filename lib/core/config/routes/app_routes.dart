import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/../features/medicines/presentation/pages/medicines_list_page.dart';
import '/../features/medicines/presentation/bloc/medicine_bloc.dart';
import '/../dependency_injection.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String dashboard = '/dashboard';

  // Medicines
  static const String medicinesList = '/medicines';
  static const String medicineDetail = '/medicines/detail';
  static const String addMedicine = '/medicines/add';
  static const String editMedicine = '/medicines/edit';

  // Sales
  static const String pos = '/pos';

  // Inventory
  static const String inventory = '/inventory';

  // Reports
  static const String reports = '/reports';

  // Orders
  static const String orders = '/orders';

  // Users
  static const String users = '/users';

  // Settings
  static const String settings = '/settings';

  static final Map<String, WidgetBuilder> routes = {
    dashboard: (_) => const DashboardPage(),
    medicinesList: (_) => BlocProvider(
      create: (_) => getIt<MedicineBloc>(),
      child: const MedicinesListPage(),
    ),
    addMedicine: (_) => const SizedBox(),
    pos: (_) => const SizedBox(child: Center(child: Text('فروش'))),
    inventory: (_) => const SizedBox(child: Center(child: Text('موجودی'))),
    reports: (_) => const SizedBox(child: Center(child: Text('گزارشات'))),
    orders: (_) => const SizedBox(child: Center(child: Text('فروش‌ها'))),
    users: (_) => const SizedBox(child: Center(child: Text('کاربران'))),
    settings: (_) => const SizedBox(child: Center(child: Text('تنظیمات'))),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('صفحه نیافت')),
            body: const Center(
              child: Text('صفحه درخواست شده وجود ندارد'),
            ),
          ),
        );
    }
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('داشبورد'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: [
          _DashboardCard(
            icon: Icons.shopping_cart,
            title: 'فروش',
            color: Colors.blue,
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.pos);
            },
          ),
          _DashboardCard(
            icon: Icons.medication,
            title: 'دوا‌ها',
            color: Colors.green,
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.medicinesList);
            },
          ),
          _DashboardCard(
            icon: Icons.inventory,
            title: 'موجودی',
            color: Colors.orange,
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.inventory);
            },
          ),
          _DashboardCard(
            icon: Icons.analytics,
            title: 'گزارشات',
            color: Colors.purple,
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.reports);
            },
          ),
          _DashboardCard(
            icon: Icons.receipt,
            title: 'فروش‌ها',
            color: Colors.teal,
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.orders);
            },
          ),
          _DashboardCard(
            icon: Icons.people,
            title: 'کاربران',
            color: Colors.indigo,
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.users);
            },
          ),
          _DashboardCard(
            icon: Icons.settings,
            title: 'تنظیمات',
            color: Colors.grey,
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.settings);
            },
          ),
        ],
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const _DashboardCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,  // ✅ حالا کار می‌کند
        child: Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            border: Border.all(color: color),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: color),
              const SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}