import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'add_to_cart.dart';
import 'catalog.dart';
import 'catalog_image.dart';
import 'home_detail_page.dart';

class CatalogList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: CatalogModel.items.length,
      itemBuilder: (context, index) {
        final catalog = CatalogModel.items[index];
        return InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeDetailPage(catalog: catalog, key: ValueKey(catalog.id)),
            ),
          ),
          child: CatalogItem(catalog: catalog, key: ValueKey(catalog.id)),
        );
      },
    );
  }
}
class CatalogItem extends StatelessWidget {
  final Item catalog;

  const CatalogItem({required Key key, required this.catalog})
      : assert(catalog != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return VxBox(
      child: Row(
        children: [
          Hero(
            tag: Key(catalog.id.toString()),
            child: CatalogImage(
              image: catalog.image,
              key: ValueKey(catalog.id),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: catalog.name.text
                            .lg
                            .color(context.accentColor)
                            .bold
                            .make(),
                      ),

                    ],
                  ),

                ),

                   Expanded(
                    child: catalog.description.text
                        .textStyle(
                      context.captionStyle?.copyWith(),
                    ).make(),
                  ),

                5.heightBox,
                ButtonBar(
                  alignment: MainAxisAlignment.spaceBetween,
                  buttonPadding: EdgeInsets.zero,
                  children: [
                    "\$${catalog.totalPrice}".text.bold.xl.make(),
                    AddToCart(catalog: catalog, key: ValueKey(catalog.id)),
                  ],
                ).pOnly(right: 8.0),
              ],
            ),
          ),
        ],
      ),
    )
        .color(context.cardColor)
        .rounded
        .square(150)
        .make()
        .py16();
  }
}
