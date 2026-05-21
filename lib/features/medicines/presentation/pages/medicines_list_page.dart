import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../bloc/medicine_bloc.dart';
import '../widgets/medicine_list_item.dart';

class MedicinesListPage extends StatefulWidget {
  const MedicinesListPage({Key? key}) : super(key: key);

  @override
  State<MedicinesListPage> createState() => _MedicinesListPageState();
}

class _MedicinesListPageState extends State<MedicinesListPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    context.read<MedicineBloc>().add(const GetMedicinesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('داروها'),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
                if (value.isNotEmpty) {
                  context.read<MedicineBloc>().add(
                    SearchMedicineEvent(query: value),
                  );
                } else {
                  context.read<MedicineBloc>().add(
                    const GetMedicinesEvent(),
                  );
                }
              },
              decoration: InputDecoration(
                hintText: 'جستجو دارو...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _searchQuery = '';
                    });
                    context.read<MedicineBloc>().add(
                      const GetMedicinesEvent(),
                    );
                  },
                )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),

          // Medicines List
          Expanded(
            child: BlocBuilder<MedicineBloc, MedicineState>(
              builder: (context, state) {
                if (state is MedicineLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MedicineLoaded) {
                  if (state.medicines.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.medication,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'داروی یافت نشد',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: state.medicines.length,
                    itemBuilder: (context, index) {
                      final medicine = state.medicines[index];
                      return MedicineListItem(
                        medicine: medicine,
                        onTap: () {},
                        onEdit: () {
                          _showEditDialog(context, medicine);
                        },
                        onDelete: () {
                          _showDeleteDialog(context, medicine.id);
                        },
                      );
                    },
                  );
                } else if (state is MedicineError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.red[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'خطا: ${state.message}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.red[600],
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<MedicineBloc>().add(
                              const GetMedicinesEvent(),
                            );
                          },
                          child: const Text('تلاش دوباره'),
                        ),
                      ],
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final nameController = TextEditingController();
    final genericController = TextEditingController();
    final barcodeController = TextEditingController();
    final priceController = TextEditingController();
    final qtyController = TextEditingController();
    final categoryController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('افزودن دارو جدید'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'نام دارو'),
                ),
                TextField(
                  controller: genericController,
                  decoration: const InputDecoration(labelText: 'نام عمومی'),
                ),
                TextField(
                  controller: barcodeController,
                  decoration: const InputDecoration(labelText: 'بارکد'),
                ),
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'قیمت واحد'),
                ),
                TextField(
                  controller: qtyController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'مقدار'),
                ),
                TextField(
                  controller: categoryController,
                  decoration: const InputDecoration(labelText: 'دسته'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('انصراف'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isEmpty ||
                    barcodeController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('فیلد‌های الزامی رو پر کن')),
                  );
                  return;
                }

                // Create medicine entity
                final medicine = MedicineEntity(
                  id: const Uuid().v4(),
                  name: nameController.text,
                  genericName: genericController.text,
                  barcode: barcodeController.text,
                  quantity: int.tryParse(qtyController.text) ?? 0,
                  minQuantity: 10,
                  unitPrice: double.tryParse(priceController.text) ?? 0,
                  expiryDate: DateTime.now().add(const Duration(days: 365)),
                  batch: '',
                  category: categoryController.text,
                  manufacturer: '',
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                );

                context.read<MedicineBloc>().add(
                  AddMedicineEvent(medicine: medicine),
                );
                Navigator.pop(context);
              },
              child: const Text('افزودن'),
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, MedicineEntity medicine) {
    final nameController = TextEditingController(text: medicine.name);
    final genericController =
    TextEditingController(text: medicine.genericName);
    final priceController =
    TextEditingController(text: medicine.unitPrice.toString());
    final qtyController =
    TextEditingController(text: medicine.quantity.toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ویرایش دارو'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'نام دارو'),
                ),
                TextField(
                  controller: genericController,
                  decoration: const InputDecoration(labelText: 'نام عمومی'),
                ),
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'قیمت واحد'),
                ),
                TextField(
                  controller: qtyController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'مقدار'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('انصراف'),
            ),
            ElevatedButton(
              onPressed: () {
                final updatedMedicine = MedicineEntity(
                  id: medicine.id,
                  name: nameController.text,
                  genericName: genericController.text,
                  barcode: medicine.barcode,
                  quantity: int.tryParse(qtyController.text) ?? 0,
                  minQuantity: medicine.minQuantity,
                  unitPrice: double.tryParse(priceController.text) ?? 0,
                  expiryDate: medicine.expiryDate,
                  batch: medicine.batch,
                  category: medicine.category,
                  manufacturer: medicine.manufacturer,
                  createdAt: medicine.createdAt,
                  updatedAt: DateTime.now(),
                );

                context.read<MedicineBloc>().add(
                  UpdateMedicineEvent(medicine: updatedMedicine),
                );
                Navigator.pop(context);
              },
              child: const Text('ذخیره'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteDialog(BuildContext context, String medicineId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('حذف دارو'),
          content:
          const Text('آیا مطمئن هستید که می‌خواهید این دارو را حذف کنید؟'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('انصراف'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<MedicineBloc>().add(
                  DeleteMedicineEvent(medicineId: medicineId),
                );
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('حذف'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}