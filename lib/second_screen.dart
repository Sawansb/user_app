import 'package:flutter/material.dart';
import 'package:user_app/constant.dart';
import 'package:user_app/user_model.dart';

class CheckUsers extends StatefulWidget {
  final List<User> allUsers;

  const CheckUsers({super.key, required this.allUsers});

  @override
  // ignore: library_private_types_in_public_api
  _CheckUsersState createState() => _CheckUsersState();
}

class _CheckUsersState extends State<CheckUsers> {
  String _selectedFilter = 'All'; // Default filter
  String _searchQuery = '';

  List<User> get filteredUsers {
    return widget.allUsers.where((user) {
      bool matchesFilter =
          _selectedFilter == 'All' || user.source == _selectedFilter;
      bool matchesSearch =
          user.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              user.email.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesFilter && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logged In Users'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                DropdownButton<String>(
                  value: _selectedFilter,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedFilter = newValue!;
                    });
                  },
                  items: [
                    'All',
                    'Facebook',
                    'Instagram',
                    'Organic',
                    'Friend',
                    'Google'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                verticalpadding16,
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Search by Name or Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredUsers[index].name),
                  subtitle: Text(filteredUsers[index].email),
                  trailing: Text(filteredUsers[index].source),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
