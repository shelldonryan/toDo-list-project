import 'package:flutter/material.dart';
import '../../../shared/themes/my_colors.dart';
import '../repositories/profile_repository.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MyColors.greenSofTec,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text("Profile"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    "https://images.unsplash.com/photo-1727638786395-6df4fc4a2048?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHw4fHx8ZW58MHx8fHx8"),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "name",
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              Text("type",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w200,
                    fontSize: 14,
                  )),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: ListView.builder(
                itemCount: customListTiles.length,
                itemBuilder: (BuildContext context, int index) {
                  final tile = customListTiles[index];
                  return Container(
                    padding:
                        const EdgeInsets.only(bottom: 5, left: 5, right: 5),
                    alignment: Alignment.bottomCenter,
                    child: ListTile(
                      leading: Icon(tile.icon),
                      title: Text(
                        tile.title,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      trailing: Text(
                        tile.quantity.toString(),
                        style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  );
                }),
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                    visible: false,
                    child: Column(
                      children: [
                        Card(
                          elevation: 4,
                          shadowColor: Colors.black12,
                          child: ListTile(
                            textColor: Colors.black54,
                            leading: Icon(Icons.transform),
                            title: Text("Make user Developer"),
                            trailing: Icon(Icons.chevron_right),
                          ),
                        ),
                      ],
                    )),
                Card(
                  elevation: 4,
                  shadowColor: Colors.black12,
                  child: ListTile(
                    textColor: Colors.red,
                    leading: Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                    title: Text("Logout"),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
