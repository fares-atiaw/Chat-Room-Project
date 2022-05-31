import 'package:flutter/material.dart';

class AdditionRoomScreen extends StatefulWidget {
  static String routeName = 'add-room';

  @override
  State<AdditionRoomScreen> createState() => _AdditionRoomScreenState();
}

class _AdditionRoomScreenState extends State<AdditionRoomScreen> {
  String? dropdownValue;

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
                  // mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Create New Room',
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    Container(
                        margin: const EdgeInsets.all(20),
                        child: Image.asset('assests/members.png',
                            width: 200, height: 100, fit: BoxFit.cover)),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                          child: Column(
                        children: [
                          TextFormField(
                            style: TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                              hintText: 'Room Name',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 26.0),
                            child: DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      //borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                          width: 1.5, color: Colors.black))),
                              items: [
                                'One',
                                'Two',
                                'Free',
                                'Four'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              value: dropdownValue,
                              hint: const Text('Select Room Category',
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.grey)),
                              elevation: 1,
                              iconSize: 30,
                              iconEnabledColor: Colors.blueAccent,
                              isExpanded: true,
                              dropdownColor: Colors.white.withOpacity(0.9),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              },
                            ),
                          ),
                          TextFormField(
                            style: const TextStyle(fontSize: 20),
                            decoration: const InputDecoration(
                              hintText: 'Room Description',
                            ),
                            maxLines: 4,
                            minLines: 4,
                          ),
                        ],
                      )),
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          'Create',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ))
                  ],
                ),
              )),
        ),
      ),
    ]);
  }
}
