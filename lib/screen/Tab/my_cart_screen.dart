import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taxi/Provider/address_provider.dart';
import 'package:food_taxi/models/cartsummary.dart';
import 'package:food_taxi/utils/checkout_container.dart';

import '../../Api/api_services.dart';
import '../../Common/common_label.dart';
import '../../Provider/loading_provider.dart';
import '../../constants/color_constant.dart';
import '../../constants/constants.dart';
import '../profile/add_address.dart';

class MyCartScreen extends ConsumerStatefulWidget {
  const MyCartScreen({super.key});

  @override
  ConsumerState<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends ConsumerState<MyCartScreen>
    with WidgetsBindingObserver {
  List<Item> cartSummary = [];
  int grandTotal = 0;
  int deliveryCharge = 0;
  bool isLoading = false;
  bool isAddressAdded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    fetchCartSummary();
    fetchAddress();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      fetchCartSummary();
      fetchAddress();
    }
  }

  Future<void> fetchCartSummary() async {
    setState(() => isLoading = true);
    try {
      final response = await ApiServices.getCartSummary();
      if (response.status) {
        setState(() {
          cartSummary = response.data.cartSummary.items;
          grandTotal = response.data.cartSummary.grandTotal;
          deliveryCharge = response.data.cartSummary.deliveryCharge;
        });
      }
    } catch (e) {
      debugPrint('Error fetching cart summary: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> placeOrder() async {
    setState(() => isLoading = true);
    try {
      final response = await ApiServices.placeOrder();
      if (response) {
        if (!mounted) return;
        showModelSheet(context);
        await fetchCartSummary();
      } else {
        throw Exception(Constants.somethingWentWrong);
      }
    } catch (e) {
      debugPrint('Error placing order: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(Constants.somethingWentWrong)),
        );
      }
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> fetchAddress() async {
    try {
      final response = await ApiServices.getAddress();
      final streetData = response.data.address;
      if (response.status) {
        ref.read(streetProvider.notifier).state = streetData.street;
        ref.read(areaProvider.notifier).state = streetData.area;
        ref.read(landmarkProvider.notifier).state = streetData.landmark;
        ref.read(cityProvider.notifier).state = streetData.city;
        ref.read(pincodeProvider.notifier).state = streetData.pincode;
      }
      if (streetData.street.isNotEmpty) {
        setState(() {
          isAddressAdded = true;
        });
      }
    } catch (e) {
      debugPrint('Error fetching address: $e');
    }
  }

  Future<void> addToCart(int cartId, String action) async {
    ref.read(isLoadingProvider.notifier).state = true;
    try {
      final response = await ApiServices.addorremovefromcart(cartId, action);
      if (response) await fetchCartSummary();
    } catch (e) {
      debugPrint('Error adding to cart: $e');
    } finally {
      ref.read(isLoadingProvider.notifier).state = false;
    }
  }

  void onTapCheckout(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          Constants.confirmCheckout,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: Constants.appFont,
          ),
        ),
        content: const Text(
          'Are you sure you want to checkout?',
          style: TextStyle(fontFamily: Constants.appFont),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(Constants.no),
          ),
          TextButton(
            onPressed: isLoading
                ? null
                : isAddressAdded
                ? () async {
                    Navigator.pop(ctx);
                    await placeOrder();
                  }
                : () => _showNoAddressDialog(),
            child: Text(
              Constants.yes,
              style: TextStyle(
                color: ColorConstant.primary,
                fontSize: 16,
                fontFamily: Constants.appFont,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showNoAddressDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          'No address',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: Constants.appFont,
          ),
        ),
        content: const Text(
          'Please add address to place order',
          style: TextStyle(fontFamily: Constants.appFont),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void showModelSheet(BuildContext context) {
    final size = MediaQuery.of(context).size;
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorConstant.whiteColor,
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(Constants.pageView3, height: size.height * 0.25),
            const SizedBox(height: 16),
            const Text(
              Constants.thankYou,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                fontFamily: Constants.appFont,
              ),
            ),
            const Text(
              Constants.forYourOrder,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                fontFamily: Constants.appFont,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              Constants.orderPlaced,
              style: TextStyle(fontSize: 12, fontFamily: Constants.appFont),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                Constants.dissmiss,
                style: TextStyle(
                  color: ColorConstant.primary,
                  fontSize: 16,
                  fontFamily: Constants.appFont,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.19),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      body: RefreshIndicator(
        color: ColorConstant.primary,
        onRefresh: () async {
          await fetchAddress();
          await fetchCartSummary();
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              title: const CommonLable(
                text: Constants.mycart,
                isIconAvailable: false,
                color: ColorConstant.whiteColor,
              ),
              backgroundColor: ColorConstant.primary,
            ),

            if (isLoading)
              const SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(
                    color: ColorConstant.primary,
                  ),
                ),
              )
            else if (cartSummary.isEmpty)
              const SliverFillRemaining(
                child: Center(
                  child: Text(
                    'No items in cart!',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              )
            else ...[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => CartItemTile(
                    cart: cartSummary[index],
                    onAdd: () => addToCart(cartSummary[index].id, 'add'),
                    onRemove: () => addToCart(cartSummary[index].id, 'remove'),
                  ),
                  childCount: cartSummary.length,
                ),
              ),
              SliverToBoxAdapter(
                child: AddressCard(
                  isAddressAdded: isAddressAdded,
                  onUpdate: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AddAddress()),
                    );
                    fetchAddress();
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: CheckoutContainer(
                  onTap: () => onTapCheckout(context),
                  items: cartSummary,
                  grandTotal: grandTotal,
                  deliveryCharges: deliveryCharge,
                ),
              ),
            ],

            SliverToBoxAdapter(child: SizedBox(height: size.height * 0.1)),
          ],
        ),
      ),
    );
  }
}
class CartItemTile extends StatelessWidget {
  final Item cart;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const CartItemTile({
    super.key,
    required this.cart,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: size.height * 0.01,
      ),
      padding: EdgeInsets.all(size.height * 0.02),
      decoration: BoxDecoration(
        color: ColorConstant.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 6.0)],
      ),
      child: Row(
        children: [
          Container(
            height: size.height * 0.1,
            width: size.height * 0.11,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(cart.foodImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cart.foodName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: Constants.appFont,
                  ),
                ),
                Text(
                  cart.restaurantName,
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: Constants.appFont,
                  ),
                ),
                Text(
                  cart.price,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: ColorConstant.primary,
                    fontFamily: Constants.appFont,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              _iconButton(Icons.remove, onRemove),
              Text(
                ' ${cart.quantity} ',
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: Constants.appFont,
                ),
              ),
              _iconButton(Icons.add, onAdd),
            ],
          ),
        ],
      ),
    );
  }

  Widget _iconButton(IconData icon, VoidCallback onTap) => InkWell(
    onTap: onTap,
    child: Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        color: ColorConstant.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: Colors.white),
    ),
  );
}

class AddressCard extends ConsumerWidget {
  final bool isAddressAdded;
  final VoidCallback onUpdate;

  const AddressCard({
    super.key,
    required this.isAddressAdded,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final street = ref.read(streetProvider);
    final area = ref.read(areaProvider);
    final landmark = ref.read(landmarkProvider);
    final city = ref.read(cityProvider);
    final pincode = ref.read(pincodeProvider);

    if (!isAddressAdded) {
      return _addressActionCard('Add Address', onUpdate);
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: ColorConstant.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CommonLable(
            text: 'Address:',
            isIconAvailable: false,
            color: ColorConstant.primaryText,
          ),
          Text(
            "$street, $area, $landmark, $city, $pincode",
            style: const TextStyle(fontFamily: Constants.appFont),
          ),
          const SizedBox(height: 8),
          _addressActionCard('Update Address', onUpdate),
        ],
      ),
    );
  }

  Widget _addressActionCard(String title, VoidCallback onTap) => Card(
    color: ColorConstant.whiteColor,
    child: ListTile(
      leading: Icon(Icons.add, color: ColorConstant.primary),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: Constants.appFont,
        ),
      ),
      onTap: onTap,
    ),
  );
}
