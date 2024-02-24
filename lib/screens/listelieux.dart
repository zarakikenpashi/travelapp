import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/lieu.dart';
import 'detailyakro.dart';
import 'package:toastification/toastification.dart';

class ListeLieuxPage extends StatefulWidget {
  const ListeLieuxPage({super.key});

  @override
  State<ListeLieuxPage> createState() => _ListeLieuxPageState();
}

class _ListeLieuxPageState extends State<ListeLieuxPage> {
  List<ModelLieux>? ListLieux = [];
  bool isLoaded = true;

  Future<void> getPlaces() async {
    try {
      var response = await http.get(Uri.parse(
          'http://192.168.1.68/tourisme_journey_api/villes/getVilles.php'));
      print(response.body);
      var decodedResponse = jsonDecode(response.body);

      if (decodedResponse['status'] == "success") {
        for (var element in decodedResponse['data']) {
          ListLieux!.add(ModelLieux.fromJson(element));
        }
        if (ListLieux != null) {
          print("Condition Is Loaded");
          setState(() {
            isLoaded = false;
          });
        }
      } else {
        toastification.show(
          context: context,
          title: Text('Aucune ville disponibles'),
          autoCloseDuration: const Duration(seconds: 5),
        );
      }

      print("Response");
    } catch (e) {
      print("Erreur: $e");
    } finally {
      print("Finally");
      //http.close();
    }
  }

  Future<void> init() async {
    await getPlaces();
  }

  @override
  void initState() {
    init();
    // TODO: implement initState
    super.initState();
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
                  child: const Column(
                      children: [Text("Bookings"), Text("72 ITEMS")]),
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
            isLoaded == false
                ? Expanded(
                    child: ListView.builder(
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
                                        image: AssetImage(
                                            "assets/images/yakro.jpg"),

                                        // CachedNetworkImageProvider(
                                        //     "${ListLieux![index].photoUrl}"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Positioned(
                                  bottom: 50,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${ListLieux![index].nom}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
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
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10),
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
                                                              color: Colors
                                                                  .white)),
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

                            /*Container(
                              width: double.infinity,
                              height: 250,
                              margin: EdgeInsets.symmetric(vertical: 20),
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image:
                                        AssetImage("assets/images/yakro.jpg"),

                                    // CachedNetworkImageProvider(
                                    //     "${ListLieux![index].photoUrl}"),
                                    fit: BoxFit.cover),
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
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
                                                "${ListLieux![index].nom}",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
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
                                        Expanded(
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
                                                        color: Colors.white)),
                                                Icon(
                                                    Icons
                                                        .chat_bubble_outline_outlined,
                                                    color: Colors.white)
                                              ],
                                            ),
                                          ],
                                        ))
                                      ],
                                    )
                                  ]),
                            ),*/
                          );
                        })),
                  )
                : Column(
                    children: [
                      CircularProgressIndicator(),
                      Text("Chargement des villes en cours ...")
                    ],
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
