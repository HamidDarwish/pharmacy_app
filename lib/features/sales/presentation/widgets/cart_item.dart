import 'package:flutter/material.dart';
import '../bloc/cart_bloc.dart';

class CartItemWidget extends StatelessWidget {
  final SaleItem item;
  final int index;
  final Function(int) onRemove;
  final Function(int, int) onQuantityChanged;

  const CartItemWidget({
    Key? key,
    required this.item,
    required this.index,
    required this.onRemove,
    required this.onQuantityChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          // Medicine Info
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.medicineName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${item.unitPrice} ريال',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          // Quantity Controls
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    if (item.quantity > 1) {
                      onQuantityChanged(index, item.quantity - 1);
                    }
                  },
                  child: Icon(
                    Icons.remove,
                    size: 18,
                    color: item.quantity > 1 ? Colors.grey[700] : Colors.grey[400],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    '${item.quantity}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                InkWell(
                  onTap: () {
                    onQuantityChanged(index, item.quantity + 1);
                  },
                  child: Icon(
                    Icons.add,
                    size: 18,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),

          // Total
          Expanded(
            child: Text(
              '${item.totalPrice.toStringAsFixed(0)} ريال',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),

          // Remove Button
          InkWell(
            onTap: () => onRemove(index),
            child: Icon(
              Icons.close,
              size: 20,
              color: Colors.red[600],
            ),
          ),
        ],
      ),
    );
  }
}