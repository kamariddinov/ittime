import 'dart:async';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/material.dart';
import 'package:ittime/Data/Data.dart';
import 'package:ittime/Constants/Constants.dart';

Widget PageWidget(List<Content> contents) {
  return Container(
    color: Colors.black,
    child: ListView.builder(
        itemCount: contents.length,
        itemBuilder: (context, index) => Card(
                child: ListTile(
              iconColor: Colors.black,
              contentPadding: EdgeInsets.zero,
              tileColor: Colors.white10,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Scaffold(
                              appBar: AppBar(
                                leading: IconButton(
                                  iconSize: 40,
                                  color: Colors.red,
                                  icon: const Icon(Icons.arrow_back),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                                flexibleSpace: Container(
                                  alignment: Alignment.topCenter,
                                ),
                                toolbarHeight: 50,
                                backgroundColor: Colors.white,
                                title: const Text(
                                  'IT TIME',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontFamily: 'Times New Roman',
                                      fontSize: 45),
                                ),
                                centerTitle: true,
                              ),
                              body: ListView(children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 25.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        '${contents[index].title} \n',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontFamily: 'Zilla Slab',
                                            fontSize: 30),
                                      ),
                                      Container(
                                        width: 370,
                                        height: 250,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                "https://ittime.uz/${contents[index].cover_img}",
                                              ),
                                              fit: BoxFit.fill,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                      ),
                                      const Text('\n'),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                contents[index].author,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              const Text(
                                                ' TOMONIDAN YOZILGAN',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.remove_red_eye,
                                                size: 18,
                                              ),
                                              Text(' ${contents[index].views}'),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Html(
                                          data: contents[index].content,
                                          style: {
                                            "p": Style(
                                                fontSize: const FontSize(20),
                                                fontFamily: 'San-Francisco')
                                          },
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(top: 0.0),
                                        child: Text(
                                          'Teglar',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, bottom: 10),
                                        child: Text(
                                          contents[index]
                                              .tags
                                              .replaceAll(
                                                  RegExp('[^A-za-z0-9]'), ' ')
                                              .replaceAll('[', '')
                                              .replaceAll(']', '')
                                              .replaceAll('  ', ' '),
                                          style: const TextStyle(
                                              fontSize: 17,
                                              backgroundColor: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                            )));
              },
              title: Column(
                children: [
                  Row(
                    children: [
                      const VerticalDivider(
                        width: 7,
                      ),
                      Container(
                        color: Colors.white,
                        width: 183,
                        height: 130,
                        child: Text(
                          contents[index].title,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              fontSize: 18, fontFamily: 'Zilla Slab'),
                        ),
                      ),
                      const VerticalDivider(
                        width: 2,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                "https://ittime.uz/${contents[index].cover_img}",
                              ),
                              fit: BoxFit.fill,
                            ),
                            borderRadius: BorderRadius.circular(4)),
                        width: 175,
                        height: 130,
                      ),
                    ],
                  ),
                  const Divider(),
                  Container(
                    padding: const EdgeInsets.only(left: 7.0),
                    width: 10000,
                    child: Text(
                      contents[index].voice_text,
                      style: const TextStyle(
                          fontFamily: 'San Francisco',
                          fontSize: 18,
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          const SafeArea(
                            child: Icon(
                              Icons.person,
                              size: 15,
                            ),
                          ),
                          Text(' ${contents[index].author}'),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.collections_bookmark, size: 15),
                          Text(' ${contents[index].the_topic}'),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.remove_red_eye,
                            size: 15,
                          ),
                          Text(' ${contents[index].views}'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ))),
  );
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String page = lates_url;
  var list_source;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<Null> refresh() async {
    refreshKey.currentState?.show(atTop: false);
    setState(() {
      list_source = getConent(page);
    });
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            alignment: Alignment.topCenter,
          ),
          toolbarHeight: 50,
          leading: Builder(
            builder: (BuildContext context) {
              return Align(
                alignment: Alignment.topCenter,
                child: IconButton(
                  icon: const Icon(
                    Icons.menu,
                    size: 40,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                ),
              );
            },
          ),
          backgroundColor: Colors.white,
          title: InkWell(
            onTap: () {
              setState(() {
                page = lates_url;
              });
            },
            child: const Text(
              'IT TIME',
              style: TextStyle(
                  color: Colors.red,
                  fontFamily: 'Times New Roman',
                  fontSize: 45),
            ),
          ),
          centerTitle: true,
        ),
        drawer: Drawer(
            width: 150,
            backgroundColor: Colors.white,
            child: ListView(
              children: [
                const SafeArea(
                  child: SizedBox(
                    height: 58,
                    child: DrawerHeader(
                      decoration: BoxDecoration(color: Colors.white38),
                      child: Text(
                        'MAVZULAR',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.red,
                          fontFamily: 'Times New Roman',
                          fontSize: 23.5,
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    ListTile(
                      title: const Text('Aqlli mashinlar'),
                      onTap: () {
                        setState(() {
                          page = aqlli_mashinalar;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                    ListTile(
                      title: const Text('Metadunyo'),
                      onTap: () {
                        setState(() {
                          page = metadunyo;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                    ListTile(
                      title: const Text('Kiber olam'),
                      onTap: () {
                        setState(() {
                          page = kiber_olam;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                    ListTile(
                      title: const Text('Smartfonlar'),
                      onTap: () {
                        setState(() {
                          page = smartfonlar;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                    ListTile(
                      title: const Text('Ijtimoiy tarmoq'),
                      onTap: () {
                        setState(() {
                          page = ijtimoiy_tarmoq;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                    ListTile(
                      title: const Text('Avtomobil'),
                      onTap: () {
                        setState(() {
                          page = avtomobil;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                    ListTile(
                      title: const Text('Su\'niy intellekt'),
                      onTap: () {
                        setState(() {
                          page = suniy_intellekt;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                    ListTile(
                      title: const Text('Virtual olam'),
                      onTap: () {
                        setState(() {
                          page = virtual_olam;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                    ListTile(
                      title: const Text('Texnologiyalar'),
                      onTap: () {
                        setState(() {
                          page = texnologiyalar;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                    ListTile(
                      title: const Text('Kriptobozor'),
                      onTap: () {
                        setState(() {
                          page = kriptobozor;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                    ListTile(
                      title: const Text('Insonlar'),
                      onTap: () {
                        setState(() {
                          page = insonlar;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            )),
        body: RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
              refresh();
            },
            child: FutureBuilder(
              future: getConent(page),
              builder: ((context, snapshot) {
                return snapshot.data != null
                    ? PageWidget(snapshot.data!)
                    : Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: const [
                            CircularProgressIndicator(
                              color: Colors.red,
                            ),
                            Text(
                              'Internet bilan bog\'lanish yo\'q',
                              style: TextStyle(color: Colors.red, fontSize: 23),
                            )
                          ],
                        ));
              }),
            )));
  }
}
