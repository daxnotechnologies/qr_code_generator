import 'package:flutter/material.dart';
import 'package:qr_code_generator/models/menu_response.dart';
import 'package:qr_code_generator/theme.dart';
import 'package:qr_code_generator/ui/invite_friends.dart';
import 'package:qr_code_generator/widgets/simple_text.dart';

class Bucket extends StatefulWidget {
  const Bucket({Key? key, this.menu}) : super(key: key);
  final MenuResponse? menu;
  @override
  _BucketState createState() => _BucketState();
}

class _BucketState extends State<Bucket> {
  double? total = 0.0;
  @override
  initState() {
    super.initState();
    calculateTotal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Bucket',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w900,
            fontSize: 24,
            fontFamily: 'Mulish',
          ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                color: QRTheme.mainColor,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ffMenuHeaderText('Item'),
                            ffMenuHeaderText('Price'),
                            ffMenuHeaderText('Quantity'),
                          ],
                        ),
                      ),
                    ),
                    Wrap(
                      children: widget.menu!.menu!.items!.map((item) {
                        return Column(
                          children: [
                            const Divider(color: Colors.white70),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                rdValueText('${item.name}'),
                                rdValueText('\$${item.price}'),
                                rdValueText('1'),
                                // operationButton(),
                              ],
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ffMenuHeaderText('Total'),
                            ffMenuHeaderText('\$$total'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                height: 60,
                elevation: 8.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Text(
                  'Share Bucket Using Social Media',
                  style: TextStyle(
                    color: QRTheme.mainColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    fontFamily: 'Mulish',
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InviteFriends(menu: widget.menu),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  calculateTotal() {
    for (var element in widget.menu!.menu!.items!) {
      total = total! + int.parse(element.price!);
    }
    _redraw();
  }

  _redraw() {
    if (mounted) setState(() {});
  }
}

Widget operationButton() {
  return Material(
    // color: QRTheme.mainColor,
    borderRadius: BorderRadius.circular(44),
    child: Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.all(4.0),
            child: Icon(Icons.remove),
          ),
          Material(
            color: QRTheme.mainColor,
            borderRadius: BorderRadius.circular(24),
            child: rdValueText(' 4 '),
          ),
          const Padding(
            padding: EdgeInsets.all(4.0),
            child: const Icon(Icons.add),
          ),
        ],
      ),
    ),
  );
}
