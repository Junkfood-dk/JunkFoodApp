import 'package:userapp/model/dish_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class DishDisplayComponent extends StatelessWidget {
  final List<DishModel> dish;
  const DishDisplayComponent({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        child: FlutterCarousel(
          options: CarouselOptions(
            height: 400.0, 
            showIndicator: true,
            slideIndicator: CircularSlideIndicator(),
          ),
          items: dish.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Column(
                      children: [
                        (Column(
                          children: [
                            Text(dishTypeTranslator(i.dishType)),
                            const SizedBox(
                              width: 20,
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.4,
                              child: ClipRRect(
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(15)),
                                  child: Image.network(i.imageUrl)),
                            ),
                            Text(
                              i.title,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(i.description),
                            Text("Calories: ${i.calories}"),
                          ],
                        )),
                      ],
                    )
                );
              },
            );
          }).toList(),
        )
        
        
        ,
      );
  }
}

Map<int, String> dishTypeMap() {
  return {0: "Main course", 1: "Alternative course", 2: "Dessert"};
}

String dishTypeTranslator(int id) {
  return dishTypeMap()[id] ??
      "Unknown"; // Using ?? operator to handle cases where id is not found
}
