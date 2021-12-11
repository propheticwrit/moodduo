import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood/data/model/category.dart';
import 'package:mood/data/service/auth/authentication_repository.dart';
import 'package:mood/ui/nav/menu.dart';
import 'package:mood/ui/page/configuration/base/cubit/configuration_cubit.dart';
import 'package:mood/ui/page/configuration/category/category_page.dart';
import 'package:mood/ui/shared/list/add_item.dart';
import 'package:mood/ui/shared/list/category_item.dart';
import 'package:uuid/uuid.dart';

class ConfigurationPage extends StatelessWidget {
  ConfigurationPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  String _name = '';

  @override
  Widget build(BuildContext context) {
    Menu menu = Menu(auth: context.read<AuthenticationRepository>());
    BlocProvider.of<ConfigurationCubit>(context).fetchCategories();

    final ConfigurationCubit configurationCubit = ConfigurationCubit();
    return BlocBuilder<ConfigurationCubit, ConfigurationState>(
      // bloc: configurationCubit,
      builder: (context, state) {
        if (state is ConfigurationError) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Edit Categories'),
                centerTitle: true,
                actions: <Widget>[
                  menu.buildMenu(context),
                ],
              ),
              body: Center(child: Text((state).message)));
        } else if (state is CategoryAdded) {
          configurationCubit.fetchCategories();
        } else if (state is! ConfigurationLoaded) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Edit Categories'),
                centerTitle: true,
                actions: <Widget>[
                  menu.buildMenu(context),
                ],
              ),
              body: const Center(child: CircularProgressIndicator()));
        } else if (state is ConfigurationLoaded) {
          final Map<Category, List<Category>> baseCategories =
              (state).baseCategories;
          return Scaffold(
              appBar: AppBar(
                title: const Text('Edit Categories'),
                centerTitle: true,
                actions: <Widget>[
                  menu.buildMenu(context),
                ],
              ),
              body: _buildContent(context, baseCategories, configurationCubit));
        }

        return Scaffold(
            appBar: AppBar(
              title: const Text('Edit Categories'),
              centerTitle: true,
              actions: <Widget>[
                menu.buildMenu(context),
              ],
            ),
            body: const Center(child: CircularProgressIndicator()));
        // return Scaffold(
        //     appBar: AppBar(
        //       title: const Text('Edit Categories'),
        //       centerTitle: true,
        //       actions: <Widget>[
        //         menu.buildMenu(context),
        //       ],
        //     ),
        //     body: state is ConfigurationError
        //         ? Center(child: Text((state).message))
        //         : state is! ConfigurationLoaded
        //             ? const Center(child: CircularProgressIndicator())
        //             : _buildContent(context, state, configurationCubit));
      },
    );
  }

  Widget _buildContent(
      BuildContext context,
      Map<Category, List<Category>> baseCategories,
      ConfigurationCubit configurationCubit) {
    return ListView.builder(
      itemCount: baseCategories.length,
      itemBuilder: (context, index) {
        Category baseCategory = baseCategories.keys.toList()[index];
        return Column(
          children: _columnList(context, configurationCubit, baseCategory,
              baseCategories[baseCategory]),
        );
      },
    );
  }

  List<Widget> _columnList(
      BuildContext context,
      ConfigurationCubit configurationCubit,
      Category baseCategory,
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
              title: const Text('Add Category'),
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Category Name'),
                        initialValue: _name,
                        validator: (value) => value != null && value.isNotEmpty
                            ? null
                            : 'Name can\'t be empty',
                        onSaved: (value) => _name = value ?? '',
                      ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                TextButton(
                  child: const Text('Submit'),
                  onPressed: () =>
                      _submit(context, configurationCubit, baseCategory.id),
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
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditCategoryPage(category: childCategory),
              ),
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditCategoryPage(category: childCategory),
              ),
            ),
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
    BlocProvider.of<ConfigurationCubit>(context).deleteCategory(category);
  }

  Future<void> _submit(BuildContext context,
      ConfigurationCubit configurationCubit, String parentID) async {
    if (_validateAndSaveForm()) {
      var uuid = const Uuid();
      configurationCubit
          .addCategory(Category(id: uuid.v4(), name: _name, parent: parentID));
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => ConfigurationCubit(),
                  child: ConfigurationPage(),
                )),
      );
    }
  }
}
