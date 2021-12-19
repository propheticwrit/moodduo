import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood/data/model/category.dart';
import 'package:mood/data/model/survey.dart';
import 'package:mood/ui/page/home/cubit/home_cubit.dart';
import 'package:mood/ui/page/survey/survey_page.dart';
import 'package:mood/ui/shared/card/category_card.dart';
import 'package:mood/ui/shared/list/category_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();

  String? _showCategory;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HomeCubit>(context).fetchCategories();

    return BlocBuilder<HomeCubit, HomeState>(
      // bloc: configurationCubit,
      builder: (context, state) {
        if (state is HomeError) {
          return Center(child: Text((state).message));
        } else if (state is! HomeLoaded) {
          return const Center(child: CircularProgressIndicator());
        }
        final Map<Category, List<Category>> baseCategories =
            (state).baseCategories;
        // DateFormat.yMMMMEEEEd().format(DateTime.now()
        return _buildContent(context, baseCategories);
      },
    );
  }

  Widget _buildContent(
      BuildContext context, Map<Category, List<Category>> baseCategories) {
    return ListView.builder(
      itemCount: baseCategories.length,
      itemBuilder: (context, index) {
        Category baseCategory = baseCategories.keys.toList()[index];
        return Column(
          children:
              _columnList(context, baseCategory, baseCategories[baseCategory]),
        );
      },
    );
  }

  List<Widget> _columnList(BuildContext context, Category baseCategory,
      List<Category>? childCategories) {
    List<Widget> columnList = <Widget>[];
    columnList.add(Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 30),
          ElevatedButton(
            child: Text(
              baseCategory.name,
              style: const TextStyle(color: Colors.black, fontSize: 18),
            ),
            style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                onPrimary: Colors.orange,
                onSurface: Colors.cyan,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            onPressed: () => {},
          ),
        ],
      ),
    ));

    if (childCategories != null) {
      for (Category childCategory in childCategories) {
        // TODO: on long press opens edit popup
        // TODO: push to category edit page
        _showCategory == childCategory.id
            ? columnList.add(CategoryCard(
                category: childCategory,
                surveyList: _surveyList(context, childCategory),
                onPressed: () => setState(() => _showCategory = null),
              ))
            : columnList.add(
                CategoryItem(
                  category: childCategory,
                  onTap: () => setState(() => _showCategory = childCategory.id),
                  onPressed: () =>
                      setState(() => _showCategory = childCategory.id),
                  onLongPress: () =>
                      setState(() => _showCategory = childCategory.id),
                ),
              );
      }
    }
    return columnList;
  }

  List<Widget> _surveyList(BuildContext context, Category category) {
    List<Widget> surveysList = [];
    if (category.surveys != null) {
      for (Survey survey in category.surveys!) {
        surveysList.add(
          const Divider(
            color: Colors.grey,
          ),
        );
        surveysList.add(Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: ListTile(
            title: Text(
              survey.name,
              style: const TextStyle(color: Colors.redAccent, fontSize: 16),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SurveyPage(survey: survey),
              ),
            ),
          ),
        ));
      }
    }
    return surveysList;
  }

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form != null) {
      if (form.validate()) {
        form.save();
        return true;
      }
    }
    return false;
  }
}
