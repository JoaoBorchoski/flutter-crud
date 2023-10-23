import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:flutter_crud/routes/app_route.dart';
import 'package:provider/provider.dart';

class UserTile extends StatelessWidget {
  final User? user;

  const UserTile(
    this.user, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final avatar = user!.avatarUrl.isEmpty
        ? const CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(backgroundImage: NetworkImage(user!.avatarUrl));
    return ListTile(
        leading: avatar,
        title: Text(user!.name),
        subtitle: Text(user!.email),
        trailing: SizedBox(
          width: 100,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                color: Colors.orange,
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(AppRoutes.USER_FORM, arguments: user);
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.red,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text('Excluir usuário'),
                            content: const Text('Tem certeza?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Não'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Provider.of<Users>(context, listen: false)
                                      .remove(user!);
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Sim'),
                              ),
                            ],
                          ));
                },
              ),
            ],
          ),
        ));
  }
}
