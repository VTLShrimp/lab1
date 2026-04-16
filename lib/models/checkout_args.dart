import 'cart_item.dart';
import 'product.dart';

class CheckoutArgs {
  final Product? product;
  final int? quantity;
  final List<CartItem>? cartItems;

  const CheckoutArgs({this.product, this.quantity, this.cartItems});
}
