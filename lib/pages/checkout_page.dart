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
        ListView.builder(
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
                onPressed: () {},
                icon: const Icon(
                  Icons.remove_circle,
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
