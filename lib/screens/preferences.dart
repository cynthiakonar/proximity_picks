import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PreferencesPage extends StatefulWidget {
  const PreferencesPage({super.key, required this.isEditing});
  final bool isEditing;

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  List selectedOptions = [];
  List options = [
    "Momo",
    "Vada",
    "Lakme Gloss",
    "Nike",
    "Adidas",
    "Puma",
    "Reebok",
    "Bata",
    "Dolo 650",
    "Crocin",
    "Saridon",
    "Cipla",
    "Paracetamol",
    "Dettol",
    "Savlon",
    "Lifebuoy",
    "Pears",
    "Lux",
    "Dove",
    "Santoor",
    "Pantene",
    "Lays",
    "Kurkure",
    "Pepsi",
    "Maggi",
    "Kitkat",
    "Dairy Milk",
    "Bournville",
    "5 Star",
    "Perk",
    "Munch",
    "Milkybar",
    "Amul",
    "Mother Dairy",
    "Britannia",
    "Parle",
    "Sunfeast",
    "Bingo",
    "Kurkure",
    "Kurti",
    "Saree",
    "Lehenga",
    "Jeans",
    "T-Shirt",
    "Shirt",
    "Kurta",
    "Kurta Pyjama",
    "Suit",
    "Blazer",
    "Jacket",
    "Sweater",
    "Sweatshirt",
    "Hoodie",
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFFFF4F4),
            Colors.white,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).padding.top + 10, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.grid_4x4_rounded,
                    size: 22,
                    color: Color(0xFFE05656),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.isEditing
                    ? "Edit Your Favourites"
                    : "Choose Your Favourites",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Wrap(
                      children: options.map((tag) {
                        return GestureDetector(
                          onTap: () {
                            if (selectedOptions.contains(tag)) {
                              setState(() {
                                selectedOptions.remove(tag);
                              });
                            } else {
                              setState(() {
                                selectedOptions.add(tag);
                              });
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 8, top: 14),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: selectedOptions.contains(tag)
                                    ? const Color(0xFFE05656).withOpacity(0.2)
                                    : Colors.white,
                                border: Border.all(
                                  width: selectedOptions.contains(tag) ? 2 : 1,
                                  color: selectedOptions.contains(tag)
                                      ? const Color(0xFFE05656)
                                      : Colors.grey,
                                )),
                            child: Text(
                              tag,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: selectedOptions.contains(tag)
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                color: selectedOptions.contains(tag)
                                    ? const Color(0xFFE05656)
                                    : const Color(0xFF737373),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
