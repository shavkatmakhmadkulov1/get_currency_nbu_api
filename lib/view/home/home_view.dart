import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_nbu_api_data/models/currency_model.dart';
import 'package:get_nbu_api_data/provider/currencies_provider.dart';
import 'package:get_nbu_api_data/view/cart/cart.dart';
import 'package:provider/provider.dart';
import 'home_view_model.dart';

class ChangeIsSelected with ChangeNotifier {


  void changeSelected(var a) {
    a = true;
    notifyListeners();
  }
}


class HomeView extends HomeViewmodel {
  final bool _pinned = true;
  final bool _snap = true;
  late final bool _floating = true;


  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => CurrenciesProvider(),
      child: myScaffold(context),
    );
  }

  Scaffold myScaffold(BuildContext context) {
    var data = context.watch<CurrenciesProvider>();
    String appBarStatus = data.totalSum.toString();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
            pinned: _pinned,
            snap: _snap,
            scrolledUnderElevation: 10,
            floating: _floating,
            expandedHeight: 200,
            flexibleSpace: const FlexibleSpaceBar(
              titlePadding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              expandedTitleScale: 1,
              collapseMode: CollapseMode.parallax,
              title: Text('Currency NBU',
                  style: TextStyle(color: Colors.white)),
              background: FlutterLogo(),
            ),
          ),
          SliverToBoxAdapter(
              child: Row(
            children: [
              const Text(
                'Last Update: ',
                style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.w500,
                    fontSize: 24),
              ),
              Text(
                '${DateTime.now().month}.${DateTime.now().day}.${DateTime.now().year}',
                style: const TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              )
            ],
          )),
          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: data.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        physics: const ScrollPhysics(
                            parent: BouncingScrollPhysics()),
                        itemBuilder: (_, index) {
                          return ListTile(
                            onLongPress: () async {
                              setState(() {});

                              setState(() {
                                _dialogBuilder(
                                    context,
                                    const Text(
                                        'Valyuta tanlaganingizga ishonchingiz komilmi?'),
                                    Text(
                                      data.currencies[index].title,
                                      style: const TextStyle(
                                          color: Colors.purpleAccent),
                                    ),
                                    data.currencies[index]);
                              });
                              setState(() {
                                context.watch<CurrencyModel>();
                              });
                            },
                            enabled: true,
                            onTap: () {},
                            title: Expanded(
                              child: Container(

                                  decoration: BoxDecoration(
                                      color: data.currencies[index].isSelected ? Colors.green.shade100 : Colors.white,
                                      border: Border.all(
                                          width: 4,
                                          color:
                                              data.currencies[index].isSelected
                                                  ? Colors.green
                                                  : Colors.grey),
                                      borderRadius: BorderRadius.circular(9)),
                                  height: 80.0,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    child: Row(
                                      children: [
                                        const CircleAvatar(
                                          backgroundColor: Colors.indigo,
                                          radius: 26,
                                          backgroundImage: NetworkImage(
                                              'https://www.shutterstock.com/image-vector/euro-member-countries-coin-icon-600w-2050753427.jpg'),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4),
                                            child: Text(
                                                data.currencies[index].code)),
                                        const SizedBox(
                                          width: 17,
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                                data.currencies[index].title)),
                                        Text(data.currencies[index].cbPrice),
                                      ],
                                    ),
                                  )),
                            ),
                          );
                        },
                        itemCount: data.currencies.length,
                      ),
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: !data.isLoading ? Colors.indigo : Colors.grey,
        onPressed: !data.isLoading
            ? () {
                data.checkTotalSum();
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return const Cart();
                }));
              }
            : null,
        child: const Icon(Icons.navigate_next),
      ),
    );
  }

  String status() => 'NBU Currency ';
}

Future<void> _dialogBuilder(
    BuildContext context, Text title, Text content, CurrencyModel cur) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: title,
        content: content,
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Yes'),
            onPressed: () {
              Navigator.of(context).pop();
              cur.isSelected = true;
              context.watch<CurrencyModel>().isSelected;
              Navigator.of(context).pop();



            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
