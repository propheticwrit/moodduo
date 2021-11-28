import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood/constants/strings.dart';
import 'package:mood/data/model/category.dart';
import 'package:mood/data/service/auth/authentication_repository.dart';
import 'package:mood/ui/nav/menu.dart';
import 'package:mood/ui/page/home/cubit/home_cubit.dart';
import 'package:mood/ui/shared/list/add_item.dart';
import 'package:mood/ui/shared/list/category_item.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  String _name = '';

  @override
  Widget build(BuildContext context) {
    Menu menu = Menu(auth: context.read<AuthenticationRepository>());
    BlocProvider.of<HomeCubit>(context).fetchCategories();

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is! HomeLoaded) {
          return const Center(child: CircularProgressIndicator());
        }

        final Map<Category, List<Category>> baseCategories =
            (state).baseCategories;

        return Container(child: _buildContent(context, baseCategories));
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
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                onPrimary: Colors.orange,
                onSurface: Colors.cyan,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            onPressed: null,
          ),
        ],
      ),
    ));

    if (childCategories != null) {
      columnList.add(
        AddItem(
          label: 'Add Category',
          onPressed: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Add Category'),
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Category Name'),
                        initialValue: _name,
                        validator: (value) => value != null && value.isNotEmpty
                            ? null
                            : 'Name can\'t be empty',
                        onSaved: (value) => _name = value != null ? value : '',
                      ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Cancel'),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                FlatButton(
                  child: Text('Submit'),
                  onPressed: () => _submit(context, baseCategory.id),
                ),
              ],
            ),
          ),
        ),
      );
      for (Category childCategory in childCategories) {
        // TODO: on long press opens edit popup
        // TODO: push to category edit page
        columnList.add(
          CategoryItem(
            category: childCategory,
            onTap: () => Navigator.pushNamed(context, settingsRoute),
            onPressed: () => Navigator.pushNamed(context, settingsRoute),
            onLongPress: () => {},
          ),
        );
      }
    }
    return columnList;
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

  Future<void> _delete(BuildContext context, Category category) async {
    // CategoryListBloc categoryListBloc = CategoryListBloc();
    // await categoryListBloc.deleteCategory(category);
    Navigator.pushNamed(context, homeRoute);
  }

  Future<void> _submit(BuildContext context, String parentID) async {
    if (_validateAndSaveForm()) {
      var uuid = Uuid();
      // CategoryListBloc categoryListBloc = CategoryListBloc();
      // categoryListBloc.addCategory(Category(id: uuid.v4(), name: _name, parent: parentID));
      // BlocProvider.of<HomeCubit>(context).saveCategory();
      Navigator.pushNamed(context, homeRoute);
    }
  }
}
