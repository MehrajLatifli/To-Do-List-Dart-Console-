import 'dart:collection';
import 'dart:io';
import 'package:uuid/uuid.dart';

import 'Models/Todo.dart';
import 'Models/User.dart';
import 'Services/Serialization and Deserialization.dart';

var uuid = Uuid();
var uuid2 = Uuid();
String? Get_idUser;

void clearConsole() {
  // if(Platform.isWindows) {
  //   print(Process.runSync("cls", [], runInShell: true).stdout);
  // } else {
  //   print(Process.runSync("clear", [], runInShell: true).stdout);
  // }

  try {
    if (Platform.isWindows) {
      // For Windows
      stdout.write(Process.runSync('cls', [], runInShell: true).stdout);
    } else {
      // For other platforms (e.g., macOS, Linux)
      stdout.write(Process.runSync('clear', [], runInShell: true).stdout);
    }
  } catch (e) {
    // Fallback approach
    for (var i = 0; i < stdout.terminalLines; i++) {
      stdout.writeln('');
    }
  }

  // stdout.write('\n' * 100);
}

Future<void> userSingUpFunction() async {
  stdout.write("\n Enter name: ");
  String? name = stdin.readLineSync();
  stdout.write("\n Enter age: ");
  double? age = double.tryParse(stdin.readLineSync() ?? "");
  stdout.write("\n Enter schoolname: ");
  String? schoolname = stdin.readLineSync();
  stdout.write("\n Enter password: ");
  String? password = stdin.readLineSync();
  stdout.write("\n Enter grade: ");
  double? grade = double.tryParse(stdin.readLineSync() ?? "");

  final loadedUsers = await deserializeFromJson<User<String, double>>(
      './Files/User/users.json', 'users');

  bool userExists = false;

  for (var user in loadedUsers) {
    if (user.Get_name == name) {
      print("User already exists");
      userExists = true;
      break;
    }
  }

  if (!userExists) {
    User<String, double> user =
        User(name, age, uuid.v4(), schoolname, password, grade);

    await serializeToJson(user, './Files/User/users.json', 'users');
    Get_idUser = user.Get_idUser; // Update Get_idUser with the user's ID
    print('Serialization completed.');


  }
}

Future<void> userSinInFunction() async {
  stdout.write("\n Enter name:");
  String? name = stdin.readLineSync();
  stdout.write("\n Enter password:");
  String? password = stdin.readLineSync();

  final loadedUsers = await deserializeFromJson<User<String, double>>(
      './Files/User/users.json', 'users');

  bool userExists = false;

  for (var user in loadedUsers) {
    if (user.Get_name == name && user.Get_password == password) {
      Get_idUser = user.Get_idUser;

      bool isRunning = true;

      while (isRunning) {
        clearConsole();
        print('\n Menu:');
        print('1. Create');
        print('2. View');
        print('3. Exit');

        stdout.write('\n Enter your choice: ');
        var choice = stdin.readLineSync();

        switch (choice) {
          case '1':
            await toDoCreateFunction();
            break;

          case '2':
            await toDoViewFunction();
            break;

          case '3':
            print('Exiting...');
            isRunning = false;
            exit(0);
            break;

          default:
            print('Invalid choice. Please try again.');
            break;
        }
      }

      userExists = true;
      break;
    }
  }

  if (!userExists) {
    print("User not exist");
  }
}

Future<void> toDoCreateFunction() async {
  ToDo<String, DateTime> toDo = ToDo(
    uuid2.v4(),
    Get_idUser,
    "Title",
    "Text",
    DateTime.now(),
  );

  stdout.write("\n Enter title: ");
  String? title = stdin.readLineSync();
  stdout.write("\n Enter text: ");
  String? text = stdin.readLineSync();

  final loadedTodos = await deserializeFromJson<ToDo<String, DateTime>>(
      './Files/Todo/todos.json', 'todos');

  bool todoExists = false;

  for (var todo in loadedTodos) {
    if (todo.title == title) {
      print("ToDo already exists");
      todoExists = true;
      break;
    }
  }

  if (!todoExists) {
    ToDo<String, DateTime> todo =
        ToDo(uuid2.v4(), Get_idUser, title, text, DateTime.now());

    await serializeToJson(todo, './Files/Todo/todos.json', 'todos');

    print('Serialization completed.');

    // Load users again after writing the new user
    final updatedTodos = await deserializeFromJson<ToDo<String, DateTime>>(
        './Files/Todo/todos.json', 'todos');

    String style = '{\n "todos": [      ';
    print(style);

    for (var i = 0; i < updatedTodos.length; i++) {
      var todo = updatedTodos[i];
      if (todo.userId == Get_idUser) {
        print("\t{");
        print("\t\tid: ${todo.id}");
        print("\t\tuserId: ${todo.userId}");
        print("\t\ttitle: ${todo.title}");
        print("\t\ttext: ${todo.text}");
        print("\t\treleaseDate: ${todo.releaseDate}");

        print("\t}${i != updatedTodos.length - 1 ? ',' : ''}");
      }
    }

    String style2 = '  ]\n}';
    print(style2);
  }
}

Future<void> toDoViewFunction() async {
  bool todoExists = false;

  if (!todoExists) {
    final viewTodos = await deserializeFromJson<ToDo<String, DateTime>>(
        './Files/Todo/todos.json', 'todos');

    String style = '{\n "todos": [      ';
    print(style);

    for (var i = 0; i < viewTodos.length; i++) {
      var todo = viewTodos[i];
      if (todo.userId == Get_idUser) {
        print("\t{");
        print("\t\tid: ${todo.id}");
        print("\t\tuserId: ${todo.userId}");
        print("\t\ttitle: ${todo.title}");
        print("\t\ttext: ${todo.text}");
        print("\t\treleaseDate: ${todo.releaseDate}");

        print("\t}${i != viewTodos.length - 1 ? ',' : ''}");
      }
    }

    String style2 = '  ]\n}';
    print(style2);
  }
}

Future<void> main() async {
  var FilesfolderName = './Files';
  var UserfolderName = './Files/User';
  var TodofolderName = './Files/Todo';

  var Filesfolder = Directory(FilesfolderName);
  var Userfolder = Directory(UserfolderName);
  var Todofolder = Directory(TodofolderName);

  Filesfolder.create().then((Directory newFolder) {
    // print('Folder created: ${newFolder.path}');
  }).catchError((error) {
    print('Failed to create folder: $error');
  });

  Userfolder.create().then((Directory newFolder) {
    // print('Folder created: ${newFolder.path}');
  }).catchError((error) {
    print('Failed to create folder: $error');
  });

  Todofolder.create().then((Directory newFolder) {
    // print('Folder created: ${newFolder.path}');
  }).catchError((error) {
    print('Failed to create folder: $error');
  });



  bool isRunning = true;

  while (isRunning) {
    clearConsole();
    print('Menu:');
    print('1. Sing Up');
    print('2. Sing In');
    print('3. Exit');

    stdout.write('\n Enter your choice: ');
    var choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        await userSingUpFunction();
        break;

      case '2':
        await userSinInFunction();
        break;
      case '3':
        print('Exiting...');
        isRunning = false;
        exit(0);
        break;

      default:
        print('Invalid choice. Please try again.');
        break;
    }
  }
}
