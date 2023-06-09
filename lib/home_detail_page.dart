import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

import 'add_to_cart.dart';
import 'catalog.dart';

class AddIntent extends Intent {}

class SubIntent extends Intent {}

class ZeroIntent extends Intent {}

class HomeDetailPage extends StatelessWidget {
  final Item catalog;

  const HomeDetailPage({required Key key, required this.catalog})
      : assert(catalog != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      backgroundColor: context.canvasColor,
      bottomNavigationBar: Container(
        color: context.cardColor,
        child: Shortcuts(
          shortcuts: {
            LogicalKeySet(LogicalKeyboardKey.arrowUp): AddIntent(),
            LogicalKeySet(LogicalKeyboardKey.arrowDown): SubIntent(),
            LogicalKeySet(LogicalKeyboardKey.digit0): ZeroIntent(),
          },
          child: Actions(
            actions: {
              AddIntent: CallbackAction<AddIntent>(
                onInvoke: (intent) =>
                    ChangeQuantity(catalog, catalog.quantity + 1),
              ),
              SubIntent: CallbackAction<SubIntent>(
                onInvoke: (intent) =>
                    ChangeQuantity(catalog, catalog.quantity - 1),
              ),
              ZeroIntent: CallbackAction<ZeroIntent>(
                onInvoke: (intent) => ChangeQuantity(catalog, 0),
              )
            },
            child: VxBuilder(
              mutations: {ChangeQuantity},
              builder: (context, _, __) {
                print(catalog.quantity);
                return Focus(
                  autofocus: true,
                  child: ButtonBar(
                    alignment: MainAxisAlignment.spaceBetween,
                    buttonPadding: EdgeInsets.zero,
                    children: [
                      "\$${catalog.totalPrice}".text.bold.xl4.red800.make(),
                      VxStepper(
                        key: UniqueKey(),
                        defaultValue: catalog.quantity,
                        onChange: (value) => ChangeQuantity(catalog, value),
                      ),
                      10.heightBox,
                      AddToCart(
                        catalog: catalog,
                        key: ValueKey(null),
                      ).wh(120, 50)
                    ],
                  ).p32(),
                );
              },
            ),
          ),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Hero(
              tag: Key(catalog.id.toString()),
              child: Image.network(catalog.image),
            ).h32(context),
            Expanded(
                child: VxArc(
                  height: 30.0,
                  arcType: VxArcType.CONVEY,
                  edge: VxEdge.TOP,
                  child: Container(
                    color: context.cardColor,
                    width: context.screenWidth,
                    child: Column(
                      children: [
                        catalog.name.text.xl4
                            .color(context.accentColor)
                            .bold
                            .make(),
                        catalog.description
                            .text
                            .textStyle(context.captionStyle!)
                            .xl
                            .make(),
                        10.heightBox,
                            //.text
                            //.textStyle(context.captionStyle!)
                            //.make()
                           // .p16()
                      ],
                    ).py64().scrollVertical(),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}