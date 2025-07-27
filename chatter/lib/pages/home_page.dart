import 'package:chatter/pages/buy_swipes.dart';
import 'package:chatter/pages/sell_post.dart';
import 'package:chatter/services/auth/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final bool hasOrders;

  const HomeScreen({super.key, required this.hasOrders});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late bool hasOrders;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    hasOrders = widget.hasOrders;
  }

  void signOut() {
    //get auth service
    final authService = Provider.of<AuthServices>(context, listen: false);

    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text("Home Page"),
        actions: [
          //signout button
          IconButton(onPressed: signOut, icon: const Icon(Icons.logout)),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi, ${_auth.currentUser!.email}",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text("Active Orders", style: TextStyle(fontSize: 18)),
              SizedBox(height: 12),
              if (hasOrders)
                Row(
                  children: [
                    orderCard("Chase", "11:00 AM", active: true),
                    SizedBox(width: 12),
                    orderCard("Lenoir", "12:00 PM"),
                  ],
                )
              else
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "Orders will show up here—tap the buttons below to buy a swipe from someone or sell a swipe to someone else!",
                  ),
                ),
              SizedBox(height: 24),
              Text("Place Order", style: TextStyle(fontSize: 18)),
              Row(
                children: [
                  actionButton(Icons.restaurant_menu, "Buy", context),
                  SizedBox(width: 16),
                  actionButton(Icons.account_balance_wallet, "Sell", context),
                ],
              ),
              if (hasOrders) ...[
                SizedBox(height: 24),
                Text("Rewards", style: TextStyle(fontSize: 18)),
                Container(
                  margin: EdgeInsets.only(top: 8),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text("50% off\nAfter referring two friends"),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget orderCard(String title, String time, {bool active = false}) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: active ? Colors.red : Colors.black12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(children: [Text(title), Text(time)]),
    );
  }

  Widget actionButton(IconData icon, String label, BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if (label == "Buy") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BuySwipeScreen()),
            );
          } else if (label == "Sell") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SellPostScreen()),
            );
          }
        },
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [Icon(icon, size: 32), SizedBox(height: 8), Text(label)],
          ),
        ),
      ),
    );
  }
}
