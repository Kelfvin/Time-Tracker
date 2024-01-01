import 'package:flutter/material.dart';

class UserItem extends StatelessWidget {
  const UserItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: ListTile(
          leading: const CircleAvatar(
            child: Text("A"),
          ),
          title: const Text("用户名"),
          subtitle: const Text("用户介绍"),
          trailing: const Text("用户状态"),
          onTap: () {},
        ),
      ),
    );
  }
}
