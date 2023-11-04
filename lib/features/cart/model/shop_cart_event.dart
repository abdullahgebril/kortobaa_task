import 'package:rxdart/rxdart.dart';

class ShopCartCountEvent {
  static int shopCartCount = 0;
  static BehaviorSubject<int> shopCartEvent = BehaviorSubject(sync: true);

  static void sentEvent(int cartCount) {
    shopCartCount += cartCount;
    shopCartEvent.add(shopCartCount);
  }

  static void decCountEvent(int cartCount) {
    shopCartCount -= cartCount;
    shopCartEvent.add(shopCartCount);
  }

  static void sentCountEvent(int cartCount) {
    shopCartCount = cartCount;
    shopCartEvent.add(shopCartCount);
  }

  static void zeroCounter() {
    shopCartCount = 0;
    shopCartEvent.add(shopCartCount);
  }
}
