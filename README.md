# Isar Notepad

This app show how to perform a CRUD operation using Isar database.

## Packages

Add these third party packages to your pubspec.yaml file. For more information follow the official documentation in this URL: https://isar-community.dev/v3/tutorials/quickstart.html

```yaml
    dependencies:
    path_provider: ^2.1.5
    provider: ^6.1.2
    isar:
        hosted: https://pub.isar-community.dev
        version: ^3.1.8
    isar_flutter_libs:
        hosted: https://pub.isar-community.dev
        version: ^3.1.8

    dev_dependencies:
    build_runner: ^2.4.13
    isar_generator:
        hosted: https://pub.isar-community.dev
        version: ^3.1.8
```

## Build Runner Command

In your terminal run:

```shell
    $ dart run build_runner build --delete-conflicting-outputs
```

## App Demo

<p align="center"><img src="demo/demo.gif"></p>
