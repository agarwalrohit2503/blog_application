import 'package:blog_application/models/cart_notifier.dart';
import 'package:blog_application/models/store_item.dart';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class StoreItemTile extends StatelessWidget {
  final StoreItem item;

  const StoreItemTile({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('item card rebuild');
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 0.8,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(item.name),
          const SizedBox(
            height: 10,
          ),
          Image.network(
            item.imageURL,
            height: 200,
            width: 200,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${item.price}",
                textScaleFactor: 0.8,
              ),
              Consumer<CartNotifier>(
                builder: (context, value, child) {
                  final _cart = Provider.of<CartNotifier>(context);
                  return _cart.isInCart(item)
                      ? const ElevatedButton(
                          onPressed: null,
                          child: Text("Added"),
                        )
                      : ElevatedButton(
                          onPressed: () => _cart.add(item),
                          child: const Text("Add to Cart"),
                        );
                },
              )
            ],
          )
        ],
      )),
    );
  }
}
