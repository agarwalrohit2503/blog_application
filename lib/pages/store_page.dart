import 'package:blog_application/common_widgets/blog_scaffold.dart';
import 'package:blog_application/common_widgets/store_item_tile.dart';
import 'package:blog_application/models/store_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension StoreItems on BuildContext {
  List<StoreItem> getStoreItems() {
    return Provider.of<List<StoreItem>>(this);
  }
}

class StorePage extends StatelessWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _storeItems = context.getStoreItems();
    return BlogScaffold(
      appBar: AppBar(
        title: const Text(
          "Store",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/checkout');
            },
            icon: const Icon(Icons.shopping_bag),
          ),
        ],
      ),
      children: [
        GridView.builder(
          itemCount: _storeItems.length,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            return StoreItemTile(item: _storeItems[index]);
          },
        )
      ],
    );
  }
}
