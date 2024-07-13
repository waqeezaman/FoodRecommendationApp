import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodrecommendation/models/category_model.dart';
import 'package:foodrecommendation/models/diet_model.dart';
import 'package:foodrecommendation/models/popular_model.dart';

class Home extends StatelessWidget {
  Home({super.key});

  List<CategoryModel> categories = [];
  List<DietModel> diets = [];
  List<PopularDietsModel> popular_diets = [];

  void getCategories() {
    categories = CategoryModel.getCategories();
  }

  void getDiets() {
    diets = DietModel.getDiets();
  }

  void getPopularDiets() {
    popular_diets = PopularDietsModel.getPopularDiets();
  }

  void getData() {
    getCategories();
    getDiets();
    getPopularDiets();
  }

  @override
  Widget build(BuildContext context) {
    getData();

    return Scaffold(
        appBar: appBar(),
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            searchBar(),
            const SizedBox(height: 40),
            Categories(),
            const SizedBox(height: 40),
            Diets(),
            const SizedBox(height: 40),
            PopularDiets(),
            const SizedBox(height: 40)
          ],
        ));
  }

  Column PopularDiets() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            "Popular Diets",
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        Container(
            child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 20, right: 20),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 25),
                itemCount: popular_diets.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(90, 141, 136, 136),
                            offset: Offset(0, 10),
                            blurRadius: 40,
                            spreadRadius: 0,
                          )
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(popular_diets[index].iconPath),
                        Text(
                          popular_diets[index].name,
                          style: foodNameTextStyle(),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              popular_diets[index].level,
                              style: foodInfoTextStyle(),
                            ),
                            Text(
                              popular_diets[index].duration,
                              style: foodInfoTextStyle(),
                            ),
                            Text(
                              popular_diets[index].calorie,
                              style: foodInfoTextStyle(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                })),
      ],
    );
  }

  Column Diets() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
            "Recommendations For Diet",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 15),
        Container(
          height: 200,
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(width: 25),
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20, right: 20),
            itemCount: diets.length,
            itemBuilder: (context, index) {
              return Container(
                width: 150,
                decoration: BoxDecoration(
                  color: diets[index].boxColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(diets[index].iconPath),
                      ),
                    ),
                    Text(diets[index].name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: 14,
                        )),
                    Text(
                        diets[index].level +
                            " | " +
                            diets[index].duration +
                            " | " +
                            diets[index].calorie,
                        style: const TextStyle(
                          fontWeight: FontWeight.w200,
                          color: Color.fromARGB(255, 102, 94, 94),
                          fontSize: 10,
                        )),
                    Container(
                        height: 25,
                        width: 150,
                        margin: EdgeInsets.only(right: 8, left: 8),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              diets[index].viewIsSelected
                                  ? Color.fromARGB(255, 76, 139, 187)
                                  : Colors.transparent,
                              diets[index].viewIsSelected
                                  ? Color.fromARGB(255, 72, 158, 201)
                                  : Colors.transparent,
                            ]),
                            borderRadius: BorderRadius.circular(16)),
                        child: Center(
                          child: Text(
                            "View",
                            style: TextStyle(
                              color: diets[index].viewIsSelected
                                  ? Colors.white
                                  : Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Column Categories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            "Category",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 15),
        Container(
          height: 120,
          child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(
              width: 25,
            ),
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 20, right: 20),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Container(
                width: 100,
                decoration: BoxDecoration(
                  color: categories[index].boxColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(categories[index].iconPath),
                      ),
                    ),
                    Text(categories[index].name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: 14,
                        ))
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Container searchBar() {
    return Container(
      margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: const Color(0xff1D1617).withOpacity(0.11),
          blurRadius: 40,
          spreadRadius: 0.0,
        ),
      ]),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(15),
          hintText: "Search Pancake",
          hintStyle: const TextStyle(
            color: Color(0xffDDDADA),
            fontSize: 14,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
          suffixIcon: Container(
            width: 100,
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const VerticalDivider(
                    color: Colors.black,
                    thickness: 0.1,
                    indent: 10,
                    endIndent: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: SvgPicture.asset("assets/icons/Filter.svg"),
                  ),
                ],
              ),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text(
        "Breakfast",
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0.0,
      leading: GestureDetector(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xffF7F8F8),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SvgPicture.asset(
            "assets/icons/Arrow - Left 2.svg",
            height: 20,
            width: 20,
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            width: 37,
            decoration: BoxDecoration(
              color: const Color(0xffF7F8F8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: SvgPicture.asset(
              "assets/icons/dots.svg",
              height: 20,
              width: 20,
            ),
          ),
        ),
      ],
    );
  }

  TextStyle foodInfoTextStyle() {
    return const TextStyle(
      fontWeight: FontWeight.w200,
      color: Color.fromARGB(255, 102, 94, 94),
      fontSize: 10,
    );
  }

  TextStyle foodNameTextStyle() {
    return const TextStyle(
      fontWeight: FontWeight.w400,
      color: Colors.black,
      fontSize: 14,
    );
  }
}
