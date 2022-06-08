import 'package:chat_app/Model/category.dart';
import 'package:chat_app/Model/room.dart';
import 'package:chat_app/UI_VM/AdditionRoom/addition_vm.dart';
import 'package:chat_app/UI_VM/Home/home_screen.dart';
import 'package:flutter/material.dart';

import '../../Tools/base_transactions.dart';
import 'addition_navigator.dart';

class AdditionRoomScreen extends StatefulWidget {
  static String routeName = 'add-room';

  @override
  State<AdditionRoomScreen> createState() => _AdditionRoomScreenState();
}

class _AdditionRoomScreenState
    extends BaseState<AdditionRoomScreen, VM_Addition>
    implements AdditionNavigator {
  @override
  VM_Addition initialViewModel() => VM_Addition();
  Category? dropdownValue;
  List<Category> categories = Category.getCategories();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool first_validation = false;

  String roomTitle = '';
  String roomDescription = '';

  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        color: Colors.white,
        child: Image.asset(
          'assests/background.png',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fill,
        ),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Add Room', style: TextStyle(fontSize: 24)),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10.0,
                    ),
                  ]),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      'Create New Room',
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    Container(
                        margin: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: 20,
                          top: 5,
                        ),
                        child: Image.asset('assests/members.png',
                            width: 200, height: 100, fit: BoxFit.cover)),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                          key: formKey,
                          autovalidateMode: first_validation
                              ? AutovalidateMode.onUserInteraction
                              : AutovalidateMode.disabled,
                          child: Column(
                            children: [
                              TextFormField(
                                  style: const TextStyle(fontSize: 20),
                                  decoration: const InputDecoration(
                                    hintText: 'Room Name',
                                  ),
                                  keyboardType: TextInputType.text,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  onChanged: (t) {
                                    roomTitle = t;
                                  },
                                  validator: (value) =>
                                      (value == null || value.trim().isEmpty)
                                          ? 'Need at least 1 character'
                                          : null),
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 20, bottom: 10),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                        width: 1, color: Colors.black87)),
                                child: DropdownButtonFormField<Category>(
                                  validator: (value) => value == null
                                      ? 'Category Required'
                                      : null,
                                  items: categories.map(buildItem).toList(),
                                  // map<DropdownMenuItem<Category>>
                                  value: dropdownValue,
                                  // = categories[6]
                                  hint: const Text('Select Room Category',
                                      style: TextStyle(
                                          fontSize: 22, color: Colors.grey)),
                                  elevation: 1,
                                  decoration: const InputDecoration(
                                    // enabledBorder: InputBorder.none, disabledBorder: InputBorder.none, focusedBorder: InputBorder.none, errorBorder: InputBorder.none,
                                    border: InputBorder.none,
                                  ),
                                  //underline: const SizedBox(),
                                  iconSize: 30,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  iconEnabledColor: Colors.blueAccent,
                                  isExpanded: true,
                                  dropdownColor: Colors.white,
                                  onChanged: (Category? newValue) {
                                    setState(() {
                                      dropdownValue = newValue;
                                    });
                                  },
                                ),
                              ),
                              TextFormField(
                                style: const TextStyle(fontSize: 20),
                                decoration: const InputDecoration(
                                  hintText: 'Room Description',
                                ),
                                onChanged: (t) {
                                  if (t != null && t.trim().isNotEmpty)
                                    roomDescription = t;
                                },
                                maxLines: 4,
                                minLines: 2,
                              ),
                            ],
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: MediaQuery.of(context).size.width * 0.08),
                      child: ElevatedButton(
                          onPressed: checkEnteredData,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const [
                                Text(
                                  'Create',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 24),
                                ),
                                Icon(Icons.create_new_folder_outlined)
                              ],
                            ),
                          )),
                    )
                  ],
                ),
              )),
        ),
      ),
    ]);
  }

  DropdownMenuItem<Category> buildItem(Category item) {
    return DropdownMenuItem<Category>(
        value: item,
        child: Row(children: [
          Icon(
            item.icon,
            color: Colors.blueAccent,
          ),
          const SizedBox(width: 12),
          Text(item.title,
              style: const TextStyle(fontSize: 18, color: Color(0xff011c61)))
        ]));
  }

  void checkEnteredData() {
    first_validation = true;

    if (formKey.currentState?.validate() == true) {
      viewModel.createRoom(Room(
          roomTitle: roomTitle,
          categoryId: dropdownValue!.id,
          roomDescription: roomDescription));
    } else
      setState(() {});
  }

  @override
  void replacedWithHomeScreen() {
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }
}

/*
Padding(
                            padding: const EdgeInsets.symmetric(vertical: 26.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField<Category>(
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(width: 1.5, color: Colors.black)
                                    )
                                ),
                                items: categories.map(buildItem).toList(),  // map<DropdownMenuItem<Category>>
                                value: dropdownValue,  // = categories[6]
                                hint: const Text('Select Room Category',
                                    style: TextStyle(fontSize: 22, color: Colors.grey)),
                                elevation: 1,
                                iconSize: 30,
                                iconEnabledColor: Colors.blueAccent,
                                isExpanded: true,
                                dropdownColor: Colors.white,
                                onChanged: (Category? newValue) {
                                  setState(() {
                                    dropdownValue = newValue;
                                  });
                                },
                              ),
                            ),
                          ),
 */

/*
Container(
                            margin: const EdgeInsets.symmetric(vertical: 26.0),
                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                            decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(width: 1.5, color: Colors.black)
                                ),
 */
