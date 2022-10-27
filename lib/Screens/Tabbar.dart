// @dart=2.9
import 'package:Corner/Components/CustomIndicator.dart';
import 'package:Corner/Screens/Dashboard.dart';
import 'package:Corner/Screens/DashboardNegaraku.dart';
import 'package:Corner/Screens/RankingCases.dart';
import 'package:Corner/Screens/RankingDeath.dart';
import 'package:Corner/Screens/RankingRecovery.dart';
import 'package:flutter/material.dart';

class Tabbar extends StatefulWidget {
  @override
  _TabbarState createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> {
   TabController _tabController;
  int indexAwal = 0;
  bool reversed = false;

  GlobalKey<RankingCasesState> _rankingCasesKey = GlobalKey();
  GlobalKey<RankingRecoveryState> _rankingRecoveryKey = GlobalKey();
  GlobalKey<RankingDeathState> _rankingDeathKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    // _tabController = TabController(vsync: this, length: 3);
    // _tabController.addListener(() {
    //   if (_tabController.indexIsChanging) {
    //     setState(() {
    //       indexAwal = _tabController.index;
    //     });
    //   }
    //   print(indexAwal.toString());
    // });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Container(
              width: MediaQuery.of(context).size.width,
              // padding: EdgeInsets.all(5),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text("Pemeringkatan"),
                    flex: 5,
                  ),
                  Expanded(
                    child: GestureDetector(
                        child: Icon(
                          Icons.swap_vert,
                          size: 30,
                          color: Colors.white,
                        ),
                        onTap: () {
                          setState(() {
                            reversed = !reversed;
                          });
                          _rankingCasesKey.currentState
                              .sortingDataa(reversed: reversed);
                          _rankingRecoveryKey.currentState
                              .sortingDataa(reversed: reversed);
                          _rankingDeathKey.currentState
                              .sortingDataa(reversed: reversed);
                          print(reversed);
                          // showModalBottomSheet(
                          //   context: context,
                          //   useRootNavigator: true,
                          //   isScrollControlled: true,
                          //   backgroundColor: Colors.transparent,
                          //   builder: (context) => Container(
                          //     margin: EdgeInsets.only(
                          //         top: MediaQuery.of(context).size.width / 6),
                          //     decoration: BoxDecoration(
                          //       color: Colors.grey[800],
                          //       borderRadius: BorderRadius.only(
                          //         topLeft: Radius.circular(20),
                          //         topRight: Radius.circular(20),
                          //       ),
                          //     ),
                          //     child: Column(
                          //       children: <Widget>[
                          //         Container(
                          //           height:
                          //               MediaQuery.of(context).size.width / 6,
                          //           child: Row(
                          //             children: <Widget>[
                          //               Expanded(
                          //                 child: Padding(
                          //                   padding: EdgeInsets.symmetric(
                          //                       horizontal: 15),
                          //                   child: Text(
                          //                     "Sort",
                          //                     style: TextStyle(
                          //                         fontFamily: "Roboto",
                          //                         fontSize: 26,
                          //                         fontWeight: FontWeight.bold),
                          //                   ),
                          //                 ),
                          //                 flex: 5,
                          //               ),
                          //               Expanded(
                          //                 child: GestureDetector(
                          //                   onTap: () {
                          //                     Navigator.of(context).pop();
                          //                   },
                          //                   child: Icon(
                          //                     Icons.close,
                          //                     size: 26,
                          //                     color: Colors.white,
                          //                   ),
                          //                 ),
                          //                 flex: 1,
                          //               )
                          //             ],
                          //           ),
                          //         )
                          //       ],
                          //     ),
                          //   ),
                          // );
                        }),
                    flex: 1,
                  ),
                ],
              )),
          bottom: TabBar(
            // onTap: (index) {
            //   // CustomIndicator(index: index);
            //   print(index.toString());
            //   setState(() {
            //     indexAwal = index;
            //   });
            // },
            controller: _tabController,
            indicator: CustomIndicator(),
            tabs: <Widget>[
              Tab(
                text: "Kasus",
              ),
              Tab(
                text: "Sembuh",
              ),
              Tab(
                text: "Meninggal",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            RankingCases(
              ascending: reversed,
              key: _rankingCasesKey,
            ),
            RankingRecovery(
              ascending: reversed,
              key: _rankingRecoveryKey,
            ),
            RankingDeath(
              ascending: reversed,
              key: _rankingDeathKey,
            )
          ],
        ),
      ),
    );
  }
}
