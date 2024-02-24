import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:travelapp/models/activite.dart';
import 'package:travelapp/models/hotel.dart';
import 'package:travelapp/models/photo.dart';
import '../models/lieu.dart';
import 'dart:convert';
import 'package:toastification/toastification.dart';

class DetailYakroPage extends StatefulWidget {
  const DetailYakroPage({super.key, required this.lieuId});
  final int? lieuId;

  @override
  State<DetailYakroPage> createState() => _DetailYakroPageState();
}

class _DetailYakroPageState extends State<DetailYakroPage> {
  ModelLieux? lieu;
  List<HotelModel>? ListHotels = [];
  List<PhotoModel>? ListPhotos = [];
  List<ActiviteModel>? ListActivites = [];
  bool isLoaded = true;

  get lieuId => null;

  Future<void> getPlaces(int? id) async {
    try {
      var response = await http.get(Uri.parse(
          'http://192.168.1.68/tourisme_journey_api/villes/getVilleById.php?id=$id'));

      var decodedResponse = jsonDecode(response.body);

      if (decodedResponse['status'] == "success") {
        setState(() {
          lieu = ModelLieux.fromJson(decodedResponse['data']['lieu']);
        });

        for (var element in decodedResponse['data']['hotels']) {
          ListHotels!.add(HotelModel.fromJson(element));
        }
        for (var element in decodedResponse['data']['activities']) {
          ListActivites!.add(ActiviteModel.fromJson(element));
        }
        for (var element in decodedResponse['data']['photos']) {
          ListPhotos!.add(PhotoModel.fromJson(element));
        }
      } else {
        toastification.show(
          context: context,
          title: Text('${decodedResponse['msg']}'),
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

  @override
  Widget build(BuildContext context) {
    getPlaces(widget.lieuId);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text("Explore"),
            centerTitle: true,
            actions: const [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.notifications_none,
                    size: 35,
                    color: Colors.grey,
                  ),
                  Icon(
                    Icons.search_rounded,
                    size: 35,
                    color: Colors.grey,
                  ),
                ],
              )
            ],
            bottom: const TabBar(tabs: [
              Tab(
                text: "Les Hotels",
              ),
              Tab(
                text: "Activités culturelles",
              )
            ]),
          ),
          body: TabBarView(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    lieu == null
                        ? CircularProgressIndicator()
                        : Container(
                            padding: EdgeInsets.only(top: 100, left: 20),
                            height: 250,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                  image: AssetImage("assets/images/yakro.jpg"),
                                  fit: BoxFit.cover),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${lieu!.nom}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                Text(
                                  "${lieu!.description}",
                                  maxLines: 3,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                          ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Featured"),
                          Container(
                            padding: const EdgeInsets.all(5),
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                gradient: const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color.fromARGB(255, 255, 125, 126),
                                      Color.fromARGB(255, 236, 38, 125)
                                    ])),
                            child: const Center(
                              child: Text(
                                "see all",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 500,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // number of items in each row
                          mainAxisSpacing: 2.0, // spacing between rows
                          crossAxisSpacing: 2.0, // spacing between columns
                        ),

                        itemCount: ListHotels!.length, // total number of items
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Column(
                              children: [
                                Container(
                                  child: Image.asset(
                                      "assets/images/parlementaire.jpg"),
                                ),
                                Text("${ListHotels![index].nom_hotel}"),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    lieu == null
                        ? CircularProgressIndicator()
                        : Container(
                            padding: EdgeInsets.only(top: 100, left: 20),
                            height: 250,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                  image: AssetImage("assets/images/yakro.jpg"),
                                  fit: BoxFit.cover),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${lieu!.nom}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                Text(
                                  "${lieu!.description}",
                                  maxLines: 3,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                          ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Featured"),
                          Container(
                            padding: const EdgeInsets.all(5),
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                gradient: const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color.fromARGB(255, 255, 125, 126),
                                      Color.fromARGB(255, 236, 38, 125)
                                    ])),
                            child: const Center(
                              child: Text(
                                "see all",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 500,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // number of items in each row
                          mainAxisSpacing: 2.0, // spacing between rows
                          crossAxisSpacing: 2.0, // spacing between columns
                        ),

                        itemCount:
                            ListActivites!.length, // total number of items
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Column(
                              children: [
                                Container(
                                  child: Image.asset(
                                      "assets/images/parlementaire.jpg"),
                                ),
                                Text("${ListActivites![index].nom_activite}"),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
