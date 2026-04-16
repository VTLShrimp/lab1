import 'package:flutter/material.dart';

import '../models/cart_item.dart';
import '../models/checkout_args.dart';
import '../models/order.dart';
import '../utils/price_formatter.dart';

class CheckoutScreen extends StatelessWidget {
  static const routeName = '/checkout';

  final CheckoutArgs args;

  const CheckoutScreen({super.key, required this.args});

  int _getTotal() {
    if (args.cartItems != null) {
      return args.cartItems!.fold(0, (sum, item) => sum + item.total);
    } else if (args.product != null && args.quantity != null) {
      return args.product!.price * args.quantity!;
    }
    return 0;
  }

  int _getItemCount() {
    if (args.cartItems != null) {
      return args.cartItems!.length;
    }
    return 1;
  }

  Order _createOrder() {
    if (args.cartItems != null) {
      return Order.fromCartItems(args.cartItems!);
    }

    final product = args.product!;
    final quantity = args.quantity ?? 1;
    return Order.fromCartItems([
      CartItem(product: product, quantity: quantity),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thanh toán')),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              args.cartItems != null
                  ? 'Đơn hàng: ${_getItemCount()} sản phẩm'
                  : args.product?.name ?? 'Sản phẩm',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (args.cartItems != null) ...[
              Expanded(
                child: ListView.builder(
                  itemCount: args.cartItems!.length,
                  itemBuilder: (context, index) {
                    final item = args.cartItems![index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text(item.product.name)),
                          Text(
                            'x${item.quantity}  ${formatPrice(item.total)}',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ] else ...[
              Text('Số lượng: ${args.quantity}'),
              Text('Đơn giá: ${formatPrice(args.product!.price)}'),
            ],
            const Divider(height: 28),
            Text(
              'Tổng tiền: ${formatPrice(_getTotal())}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  Navigator.pop(context, _createOrder());
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text('Xác nhận đơn hàng'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
