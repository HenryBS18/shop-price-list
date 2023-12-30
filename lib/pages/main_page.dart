import 'package:flutter/material.dart';
import 'package:shop_price_list/db/database.dart';
import 'package:shop_price_list/components/add_item_dialog.dart';
import 'package:shop_price_list/pages/cart_page.dart';
import 'package:shop_price_list/pages/price_list_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with WidgetsBindingObserver {
  int currentIndex = 0;
  bool isKeyboardVisible = false;

  final AppDb db = AppDb();
  Future<List<Item>> getAllItems() => db.getAllItemsRepo();
  late Future<List<Item>> items = getAllItems();

  late List<Widget> pages = [
    PriceListPage(items: items, refresh: refresh),
    const CartPage(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    setState(() {
      isKeyboardVisible = WidgetsBinding.instance.window.viewInsets.bottom != 0;
    });
  }

  void refresh() {
    setState(() {
      items = getAllItems();
      pages = [
        PriceListPage(items: items, refresh: refresh),
        const CartPage(),
      ];
    });
  }

  List<BottomNavigationBarItem> bottomNavItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.currency_exchange), label: 'Price List'),
    BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sinar Agung"),
        backgroundColor: Colors.purple[100],
      ),
      floatingActionButton: Visibility(
        visible: !isKeyboardVisible,
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: ((context) {
                return AddItemDialog(onItemAdded: refresh);
              }),
            );
          },
          backgroundColor: Colors.green,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(999))),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavItems,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
