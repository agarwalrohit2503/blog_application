import 'package:blog_application/common_widgets/blog_scaffold.dart';
import 'package:blog_application/models/cart_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartNotifier cartNotifier = Provider.of<CartNotifier>(context);
    return BlogScaffold(
      appBar: AppBar(
        title: const Text(
          "Checkout",
          style: TextStyle(color: Colors.black),
        ),
      ),
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: ListView.builder(
            itemCount: cartNotifier.storeItems.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(cartNotifier.storeItems[index].name),
                leading: Image.network(
                  cartNotifier.storeItems[index].imageURL,
                  height: 30,
                  width: 30,
                ),
                trailing: IconButton(
                  onPressed: () => context
                      .read<CartNotifier>()
                      .remove(cartNotifier.storeItems[index]),
                  icon: const Icon(
                    Icons.remove_circle,
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "\$${cartNotifier.totalPrice}",
                style: Theme.of(context).textTheme.headline1,
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Order placed SuccessFully"),
                      ),
                    );
                  },
                  child: const Text("BUY"))
            ],
          ),
        )
      ],
    );
  }
}
