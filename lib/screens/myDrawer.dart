import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFFF5F5F5),
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            Container(
              padding: const EdgeInsets.all(50),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 239, 239, 239),
              ), //BoxDecoration
              child: Center(
                  child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: const DecorationImage(
                              image: AssetImage("assets/images/profil.jpg"),
                              fit: BoxFit.fill),
                        ),
                      ),
                      const Positioned(
                        right: 0,
                        bottom: 2,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.pink,
                          child: Icon(
                            Icons.done_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Bernard Cerny"),
                  const Text(
                    "DJ/TRAVELER",
                    style: TextStyle(fontSize: 10),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 236, 38, 125),
                        ),
                        child: const Text(
                          "Edit",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text('Decconexion'),
                              content:
                                  const Text("Voulez-vous vous deconnecter ?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Non"),
                                ),
                                TextButton(
                                  onPressed: () async {},
                                  child: const Text("Oui"),
                                ),
                              ],
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 236, 38, 125),
                        ),
                        child: const Icon(
                          Icons.logout_outlined,
                          color: Colors.white,
                        ),
                      )
                    ],
                  )
                ],
              )), //UserAccountDrawerHeader
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  //DrawerHeader
                  ListTile(
                    leading: const Icon(
                      Icons.browse_gallery_outlined,
                      color: Colors.grey,
                    ),
                    title: const Text(
                      'Discover',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.crisis_alert_outlined,
                      color: Colors.grey,
                    ),
                    title: const Text(
                      'Near Me',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.dashboard_outlined,
                      color: Colors.grey,
                    ),
                    title: const Text(
                      'Activities',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.place_outlined,
                      color: Colors.grey,
                    ),
                    title: const Text(
                      'Map',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.event_note_outlined,
                      color: Colors.grey,
                    ),
                    title: const Text(
                      'Booking',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.credit_card_outlined,
                      color: Colors.grey,
                    ),
                    title: const Text(
                      'Subscription',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.settings_outlined,
                      color: Colors.grey,
                    ),
                    title: const Text(
                      'Settings',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
