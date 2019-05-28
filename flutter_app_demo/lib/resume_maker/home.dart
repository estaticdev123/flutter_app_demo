import 'package:flutter/material.dart';
import 'package:flutter_app_demo/resume_maker/detail.dart';
import 'package:flutter_app_demo/resume_maker/textStyle.dart';
import 'package:residemenu/residemenu.dart';

import 'package:share/share.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;
import 'package:flutter/gestures.dart';

import 'package:carousel_pro/carousel_pro.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() {
    return new HomeState();
  }
}

//This class helps to create links, that we are using in about dialog.
class _LinkTextSpan extends TextSpan {
  _LinkTextSpan({TextStyle style, String url, String text})
      : super(
            style: style,
            text: text ?? url,
            recognizer: new TapGestureRecognizer()
              ..onTap = () {
                urlLauncher.launch(url);
              });
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  MenuController _menuController;

  // BannerAd bannerAd;
  var data;

  /// to build a reside menu drawer build by library
  Widget buildItem(String msg, VoidCallback method) {
    return new Material(
      color: Colors.transparent,
      child: new InkWell(
        child: ResideMenuItem(
          title: msg,
          icon: const Icon(Icons.home, color: Colors.grey),
          right: const Icon(Icons.arrow_forward, color: Colors.grey),
        ),
        onTap: () => method,
      ),
    );
  }

  Widget PersonalInfo() {
    return Container(
      child: Column(
        children: <Widget>[new Text("Hello")],
      ),
    );
  }

  _launchgmail() async {
    const url =
        'mailto:indiancoder001@gmail.com?subject=Feedback&body=Feedback for Toughest';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();

    _menuController = new MenuController(vsync: this);
  }

  @override
  void dispose() {
    // bannerAd?.dispose();
    super.dispose();
  }

  ///shows the about dialog.
  showAbout(BuildContext context) {
    final TextStyle linkStyle =
        Theme.of(context).textTheme.body2.copyWith(color: Colors.blue);
    final TextStyle bodyStyle =
        new TextStyle(fontSize: 15.0, color: Colors.black);

    return showAboutDialog(
        context: context,
        applicationIcon: Center(
          child: Image(
            height: 150.0,
            width: 200.0,
            fit: BoxFit.fitWidth,
            image: AssetImage("assets/images/author.png"),
          ),
        ),
        // applicationName: 'Toughest',
        // applicationVersion: '1.0',
        children: <Widget>[
          new Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: new RichText(
                  textAlign: TextAlign.start,
                  text: new TextSpan(children: <TextSpan>[
                    new TextSpan(
                        style: bodyStyle,
                        text: 'Hello,  We are Indian coder,' +
                            ' If you want to develop app for your business or anything feel free to contact us.'
                                ' We can build awesome apps in lowest price range.'
                                "\n\n"),
                    new TextSpan(
                      style: bodyStyle,
                      text: 'for Business Queries:' + "\n\n",
                    ),
                    // new _LinkTextSpan(
                    //   style: linkStyle,
                    //   text: 'Send a Whatsapp message' + "\n\n",
                    //   url: 'https://api.whatsapp.com/send?phone=+918210296495',
                    // ),
                    new _LinkTextSpan(
                        style: linkStyle,
                        text: 'Send an E-mail' + "\n\n",
                        url:
                            'mailto:indiancoder001@gmail.com?subject=Toughest&body=For business queries'),
                  ]))),
        ]);
  }

  ///Lis-t of interview questions.
  Widget getListItems(Color color, IconData icon, String title) {
    return GestureDetector(
        child: Container(
          color: color,
          height: 300.0,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                size: 100.0,
                color: Colors.white,
              ),
              Text(
                title,
                style: Style.headerstyle,
              )
            ],
          )),
        ),
        onTap: () async {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Detail(
                    title: title,
                  )));
        });
  }

  ///creating a carousel using carousel pro library.
  final myCraousal = Carousel(
    dotSize: 5.0,
    dotIncreaseSize: 2.0,
    borderRadius: true,
    radius: Radius.circular(10.0),
    animationCurve: Curves.easeInOut,
    animationDuration: Duration(seconds: 2),
    images: [
      AssetImage('assets/images/card1.png'),
      AssetImage('assets/images/card3.png'),
      AssetImage('assets/images/card4.png'),
      AssetImage('assets/images/card2.png'),
    ],
  );

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    //to use reside menu library we have to return a residemenu scafford.
    return new ResideMenu.scafford(
      direction: ScrollDirection.LEFT,
      decoration: new BoxDecoration(
          /*   image: new DecorationImage(
              image: new AssetImage("assets/images/background.jpg"),
              fit: BoxFit.cover),*/

          color: Color(0xFFD0C490)),
      controller: _menuController,
      leftScaffold: new MenuScaffold(
        header: new ConstrainedBox(
          constraints: new BoxConstraints(maxHeight: 60.0, maxWidth: 100.0),
          child: new CircleAvatar(
            backgroundImage: new AssetImage('assets/images/icon.jpg'),
            radius: 30.0,
          ),
        ),
        children: <Widget>[
          new Material(
            color: Colors.transparent,
            child: new InkWell(
              child: ResideMenuItem(
                title: 'HOME',
                titleStyle: TextStyle(
                    color: Colors.black, fontFamily: 'Acme', fontSize: 12),
                icon:
                    const Icon(Icons.fiber_manual_record, color: Colors.black),
              ),
              onTap: () => PersonalInfo(),
            ),
          ),

          ///I have to make these drawer list widgets manually cause it is containing different methods.
          new Material(
            color: Colors.transparent,
            child: new InkWell(
              child: ResideMenuItem(
                title: 'PERSONAL DETAIL',
                titleStyle: TextStyle(
                    color: Colors.black, fontFamily: 'Acme', fontSize: 12),
                icon:
                    const Icon(Icons.fiber_manual_record, color: Colors.black),
              ),
              onTap: () => PersonalInfo(),
            ),
          ),

          new Material(
            color: Colors.transparent,
            child: new InkWell(
              child: ResideMenuItem(
                title: 'EDUCACTION DETAIL',
                titleStyle: TextStyle(
                    color: Colors.black, fontFamily: 'Acme', fontSize: 12),
                icon:
                    const Icon(Icons.fiber_manual_record, color: Colors.black),
              ),
              onTap: () => PersonalInfo(),
            ),
          ),
          new Material(
            color: Colors.transparent,
            child: new InkWell(
              child: ResideMenuItem(
                title: 'SUGGECTIONS',
                titleStyle: TextStyle(
                    color: Colors.black, fontFamily: 'Acme', fontSize: 12),
                icon:
                    const Icon(Icons.fiber_manual_record, color: Colors.black),
              ),
              onTap: () => _launchgmail(),
            ),
          ),
        ],
      ),
      child: new Scaffold(
          appBar: new AppBar(
            elevation: 10.0,
            centerTitle: true,
            backgroundColor: Colors.white,
            leading: new GestureDetector(
              child: const Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onTap: () {
                _menuController.openMenu(true);
              },
            ),
            title: new Text(
              'RESUME MAKER',
              style: TextStyle(color: Colors.black, fontFamily: 'Acme'),
            ),
            actions: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.person_outline,
                    color: Colors.black,
                    size: 20.0,
                  ),
                  onPressed: () => showAbout(context))
            ],
          ),
          body: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 5.0),
                height: height / 2.5,
                child: myCraousal,
              ),
              getListItems(
                  Color(0xFFF1B136), Icons.person, 'Behavioural Based'),
              getListItems(Color(0xFF885F7F), Icons.wc, 'Communications Based'),
              getListItems(
                  Color(0xFF13B0A5), Icons.call_split, 'Opinion Based'),
              getListItems(
                  Color(0xFFD0C490), Icons.assessment, 'Performance Based'),
              getListItems(
                  Color(0xFFEF6363), Icons.help_outline, 'Brainteasers'),
            ],
          )),
    );
  }

  homeTab() {}
}
