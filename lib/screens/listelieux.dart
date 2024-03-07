import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/lieu.dart';
import 'detailyakro.dart';
import 'package:toastification/toastification.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListeLieuxPage extends StatefulWidget {
  const ListeLieuxPage({super.key});

  @override
  State<ListeLieuxPage> createState() => _ListeLieuxPageState();
}

class _ListeLieuxPageState extends State<ListeLieuxPage> {
  List<ModelLieux>? ListLieux = [];
  bool loadMore = false;
  bool isLoaded = true;

  ScrollController myScrollController = ScrollController();

  late SharedPreferences prefs;
  late double userLatitude;
  late double userLongitude;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position coordonnees = await Geolocator.getCurrentPosition();
    userLatitude = coordonnees.latitude;
    userLongitude = coordonnees.longitude;

    return await Geolocator.getCurrentPosition();
  }

  Future<void> getPlaces(int count) async {
    try {
      var response = await http.get(Uri.parse(
          'https://hellostartup.000webhostapp.com/villes/getVilles.php?qty=$count'));
      var decodedResponse = jsonDecode(response.body);

      if (decodedResponse['status'] == "success") {
        for (var element in decodedResponse['data']) {
          ListLieux!.add(ModelLieux.fromJson(element));
        }
        setState(() {
          isLoaded = false;
        });
      } else {
        toastification.show(
          context: context,
          title: Text('Aucune ville disponibles'),
          autoCloseDuration: const Duration(seconds: 5),
        );
      }
    } catch (e) {
      print("Erreur: $e");
    }
  }

  Future<void> getMorePlaces(int count) async {
    try {
      var response = await http.get(Uri.parse(
          'https://hellostartup.000webhostapp.com/villes/getVilles.php?qty=$count'));
      var decodedResponse = jsonDecode(response.body);

      if (decodedResponse['status'] == "success") {
        for (var element in decodedResponse['data']) {
          setState(() {
            ListLieux!.add(ModelLieux.fromJson(element));
          });
        }
        setState(() {
          loadMore = false;
        });
      } else {
        toastification.show(
          context: context,
          title: Text('Aucune ville disponibles'),
          autoCloseDuration: const Duration(seconds: 5),
        );
      }
    } catch (e) {
      print("Erreur: $e");
    }
  }

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    await _determinePosition();
    await getPlaces(0);
    await prefs.setDouble('latitude', userLatitude);
    await prefs.setDouble('longitude', userLongitude);
  }

  @override
  void initState() {
    init();
    myScrollController.addListener(() {
      if (myScrollController.offset + 10 >
          myScrollController.position.maxScrollExtent) {
        setState(() {
          loadMore = true;
        });
        if (loadMore) {
          getMorePlaces(ListLieux!.length);
          print("....Loading...${ListLieux!.length}");
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    myScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Column(children: [
                    Text("Lieux"),
                    Text("${ListLieux!.length} ITEMS")
                  ]),
                ),
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(255, 255, 125, 126),
                            Color.fromARGB(255, 236, 38, 125)
                          ])),
                  child: const Text(
                    "+ Filters",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
            Expanded(
              child: isLoaded == false
                  ? ListView.builder(
                      controller: myScrollController,
                      itemCount: ListLieux!.length,
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailYakroPage(
                                  lieuId: ListLieux![index].id,
                                ),
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 250,
                                margin: EdgeInsets.symmetric(vertical: 20),
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          "${ListLieux![index].photo_url}"),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Positioned(
                                bottom: 50,
                                left: 20,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${ListLieux![index].nom}",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 250,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${ListLieux![index].description}",
                                                  maxLines: 3,
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255),
                                                      overflow:
                                                          TextOverflow.clip),
                                                )
                                              ],
                                            ),
                                          ),
                                          Icon(
                                            Icons.more_vert,
                                            size: 30,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.sunny,
                                            color: Colors.white,
                                            size: 35,
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                  "${ListLieux![index].temperature}",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              Text(
                                                double.parse(
                                                            "${ListLieux![index].temperature}") >
                                                        0
                                                    ? "Sunny"
                                                    : "cloudy",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 50,
                                            width: 200,
                                            child: Column(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 10, right: 10),
                                                  height: 5,
                                                  color: Colors.white,
                                                ),
                                                const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .favorite_border_outlined,
                                                      color: Colors.white,
                                                      size: 25,
                                                    ),
                                                    Text("4k",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white)),
                                                    Icon(
                                                        Icons
                                                            .chat_bubble_outline_outlined,
                                                        color: Colors.white)
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ]),
                              ),
                            ],
                          ),
                        );
                      }))
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        return Container(
                          height: 200,
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Color.fromARGB(222, 196, 192, 192)),
                          alignment: Alignment.center,
                          child: Text("chargement..."),
                        );
                      },
                    ),
            ),
            SizedBox(
              height: 150,
            )
          ],
        ),
      ),
    );
  }
}
