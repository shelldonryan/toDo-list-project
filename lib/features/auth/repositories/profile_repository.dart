import 'package:flutter/material.dart';

class CustomListTile {
  final IconData icon;
  final String title;
  final int quantity;
  CustomListTile({
    required this.icon,
    required this.title,
    required this.quantity,
  });
}

List<CustomListTile> customListTiles = [
  CustomListTile(
    icon: Icons.pending_outlined,
    title: "Pending Tasks",
    quantity: 1,
  ),
  CustomListTile(
    icon: Icons.task_alt,
    title: "Finished Tasks",
    quantity: 1,
  ),
  CustomListTile(
    icon: Icons.all_inbox_sharp,
    title: "Total Tasks",
    quantity: 2,
  ),
];