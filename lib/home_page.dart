import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobibazar/cart.dart';
import 'dart:convert';
import 'package:mobibazar/routes.dart';
import 'package:mobibazar/store.dart';
import 'package:velocity_x/velocity_x.dart';

import 'cart_header.dart';
import 'catalog.dart';
import 'catalog_list.dart';
import 'home_detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int days = 30;

  final String name = "Codepur";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    await Future.delayed(const Duration(seconds: 1));
    final catalogJson = await rootBundle.loadString("assets/files/catalog.json");
    final decodedData = jsonDecode(catalogJson);
    var productsData = decodedData["data"];
    CatalogModel.items = List.from(productsData)
        .map<Item>((item) => Item.fromMap(item))
        .toList();
    if (mounted) {
      (VxState.store as MyStore).items = CatalogModel.items;
      setState(() {});
    }
  }


  @override
  Widget build(BuildContext context) {
    final _cart = (VxState.store as MyStore).cart;
    return Scaffold(
        backgroundColor: context.canvasColor,
        floatingActionButton: VxConsumer(
          mutations: {AddMutation, RemoveMutation},
          builder: (context, _, __) {
            final _cart = (VxState.store as MyStore).cart;
            return FloatingActionButton(
              onPressed: () => Navigator.pushNamed(context, MyRoutes.cartRoute),
              backgroundColor: context.theme.buttonColor,
              child: Icon(
                CupertinoIcons.cart,
                color: Colors.white,
              ),
            ).badge(
              color: Vx.red50,
              size: 18,
              count: _cart.items.length,textStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
            );
          },
        ),

        body: SafeArea(
          child: Container(
            padding: Vx.m32,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CatalogHeader(),
                CupertinoSearchTextField(
                  onChanged: (value) {
                    SearchMutation(value);
                  },
                ).py12(),
                if (CatalogModel.items != null && CatalogModel.items.isNotEmpty)
                  CatalogList().py16().expand()
                else
                  CircularProgressIndicator().centered().expand(),
              ],
            ),
          ),
        ));
  }
}

