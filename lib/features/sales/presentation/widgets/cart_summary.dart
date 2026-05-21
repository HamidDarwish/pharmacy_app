import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../bloc/cart_bloc.dart';

class CartSummary extends StatefulWidget {
  final List<SaleItem> items;
  final VoidCallback onCheckout;

  const CartSummary({
    Key? key,
    required this.items,
    required this.onCheckout,
  }) : super(key: key);

  @override
  State<CartSummary> createState() => _CartSummaryState();
}

class _CartSummaryState extends State<CartSummary> {
  double discountPercent = 0;
  TextEditingController discountController = TextEditingController();
  TextEditingController customerNameController = TextEditingController();
  TextEditingController customerPhoneController = TextEditingController();

  double get subtotal {
    return widget.items.fold(
      0,
          (sum, item) => sum + item.totalPrice,
    );
  }

  double get discountAmount => (subtotal * discountPercent) / 100;
  double get total => subtotal - discountAmount;

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat('###,###,##0', 'fa_IR');

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border(
          top: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Customer Info
          TextField(
            controller: customerNameController,
            decoration: InputDecoration(
              labelText: 'نام مشتری (اختیاری)',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              prefixIcon: const Icon(Icons.person),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: customerPhoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'تلفن مشتری (اختیاری)',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              prefixIcon: const Icon(Icons.phone),
            ),
          ),
          const SizedBox(height: 12),

          // Summary Items
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'جمع کل:',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              Text(
                '${currencyFormatter.format(subtotal)} ريال',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Discount
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: discountController,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      discountPercent = double.tryParse(value) ?? 0;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'درصد تخفیف',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    suffixText: '%',
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${currencyFormatter.format(discountAmount)} ريال',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.red[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Total with divider
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey[300]!),
                bottom: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'مبلغ نهایی:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${currencyFormatter.format(total)} ريال',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Checkout Button
          ElevatedButton.icon(
            onPressed: widget.items.isEmpty ? null : widget.onCheckout,
            icon: const Icon(Icons.payment),
            label: const Text('پرداخت'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              backgroundColor: Colors.green[700],
              disabledBackgroundColor: Colors.grey[300],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    discountController.dispose();
    customerNameController.dispose();
    customerPhoneController.dispose();
    super.dispose();
  }
}