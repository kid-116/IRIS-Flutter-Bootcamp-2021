import 'package:flutter/material.dart';
import 'package:my_portfolio_app/pages/about_me_page.dart';
import 'package:my_portfolio_app/pages/my_interests_page.dart';
import 'package:my_portfolio_app/widgets/codeforces_widget.dart';
import 'package:my_portfolio_app/widgets/my_projects_widget.dart';

void main() {
  runApp(PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Portfolio',
      theme: ThemeData(
        accentColor: Color(0xFFffb997),
        appBarTheme: AppBarTheme(
          color: Color(0xFF621940),
          centerTitle: true,
          elevation: 0,
        ),
        scaffoldBackgroundColor: Color(0xFF621940),
        tabBarTheme: TabBarTheme(
          indicatorSize: TabBarIndicatorSize.label
        ),
      ),
      home: PortfolioHomePage(),
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  @override
  _PortfolioHomePageState createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Portfolio'),
        bottom: TabBar(
          tabs: <Tab>[
            Tab(
              text: "ABOUT ME",
              icon: Icon(Icons.show_chart),
            ),
            Tab(
              text: "MY INTERESTS",
              icon: new Icon(Icons.history),
            ),
          ],
          controller: _tabController,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height/1.7,
              child: TabBarView(
                children: <Widget>[
                  AboutMePage(), 
                  MyInterestsPage()
                ],
                controller: _tabController,
              ),
            ),
            MyProjectsWidget(),
            CodeforcesWidget()
          ],
        ),
      ),
    );
  }
}
