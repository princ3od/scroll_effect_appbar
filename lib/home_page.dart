import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            const ScrollEffectAppBar(),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, int index) {
                  return ListTile(
                    leading: Container(
                        padding: const EdgeInsets.all(8),
                        width: 56,
                        child: const Placeholder()),
                    title: Text('Place ${index + 1}', textScaleFactor: 1),
                  );
                },
                childCount: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScrollEffectAppBar extends StatefulWidget {
  const ScrollEffectAppBar({Key? key}) : super(key: key);

  @override
  State<ScrollEffectAppBar> createState() => _ScrollEffectAppBarState();
}

double opacity = 0;
final starBucksMenu = [
  'Hot Coffees',
  'Hot Teas',
  'Hot Drinks',
  'Frappuccino® Blended Beverages',
  'Cold Coffees',
  'Iced Teas',
  'Cold Drinks',
];

class _ScrollEffectAppBarState extends State<ScrollEffectAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      stretch: true,
      expandedHeight: 280.0,
      collapsedHeight: 50.0 + kToolbarHeight,
      pinned: true,
      backgroundColor: Colors.white,
      flexibleSpace: LayoutBuilder(
        builder: (context, setInnerState) {
          final settings = context
              .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
          final deltaExtent = settings!.maxExtent - settings.minExtent;
          final time =
              ((settings.currentExtent - settings.minExtent) / deltaExtent)
                  .clamp(0.0, 1) as double;
          final fadeStart = math.max(0.0, 1.0 - kToolbarHeight / deltaExtent);
          const fadeEnd = 1.0;
          opacity = 1.0 - Interval(fadeStart, fadeEnd).transform(time);
          return Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: SizedBox(
                      child: Image.network(
                        'https://hrinsider-v2.vietnamworks.com//wp-content/uploads/2022/05/shutterstock_1072863746-1.jpg',
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Container(
                    height: kToolbarHeight - 5.0,
                    color: Colors.white,
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 24 * time,
                      right: 24 * time,
                    ),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(
                                  0, 0.5) // changes position of shadow
                              ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10.5 + kToolbarHeight * (1.0 - time),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 16 * time,
                              left: 24 + 28 * (1.0 - time),
                              right: 24 + 8 * (1.0 - time),
                            ),
                            child: Text(
                              'Starbucks Phan Xích Long',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 28.0 - 4 * (1 - time),
                              ),
                            ),
                          ),
                          if (time > 0.15)
                            Padding(
                              padding: EdgeInsets.only(
                                left: 24 + 28 * (1.0 - time),
                                right: 24 + 16 * (1.0 - time),
                                top: 8,
                                bottom: 8,
                              ),
                              child: Opacity(
                                opacity: time,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Coffee and Tea • American • \$\$',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.alarm,
                                          color: Colors.grey,
                                          size: 20,
                                        ),
                                        const Text(
                                          '30-40 MIN',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        const Text(
                                          '4.6',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow[600],
                                          size: 20,
                                        ),
                                        const Text(
                                          '(500+)',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                ),
                              ),
                            ),
                          if (time < 0.15)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Opacity(
                                opacity: 1 - time,
                                child: DefaultTabController(
                                  length: starBucksMenu.length,
                                  child: TabBar(
                                      isScrollable: true,
                                      unselectedLabelColor: Colors.black,
                                      indicator: const BubbleTabIndicator(
                                        //indicatorHeight: 30.0,
                                        indicatorColor: Colors.black,
                                        tabBarIndicatorSize:
                                            TabBarIndicatorSize.label,
                                        insets: EdgeInsets.symmetric(
                                            horizontal: 2.0),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: -2.0),
                                      ),
                                      tabs: [
                                        for (var i = 0;
                                            i < starBucksMenu.length;
                                            i++)
                                          Tab(
                                            text: starBucksMenu[i],
                                          ),
                                      ]),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: kToolbarHeight, left: 8),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: opacity > 0.4 ? Colors.black : Colors.white,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
