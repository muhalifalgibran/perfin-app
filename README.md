
# Perfin APP
your simple personal finance management app

### Prerequisite

 - Flutter Version: 3.16.0
 - Dart Version: 3.2.0

### Codebase
- Clean Architecture:
Clean Architecture really makes the app more maintanable by seperating the layers, as we see in the codebase the goals is to make the relationship between layers loose coupled/decoupled. So, for example if we want to change the `datasource` method we can just change the module, as long as the return object is still the same. Because of that, we don't need to modify the entire codebase for the change. Here is the visualization:
	![Clean Coder Blog](https://blog.cleancoder.com/uncle-bob/images/2012-08-13-the-clean-architecture/CleanArchitecture.jpg)

In our code base the folder is seperated like this:

![enter image description here](https://gcdnb.pbrd.co/images/81omjJya0tZe.png?o=1)

The project goals is to seperate the folder by layer as the Clean Architecture principle **(Separation of Concern)**. the project utility is in core folder such like dependency injections, network, module, and etc (the more complex the app the more core utility we need).

The features files contains the feature/requirements of the project, seperating feature by folders, so every feature folder has data, domain, and presentation layer.

As the principle of **Clean Architecture** we often use one of the principle of SOLID which is **Dependency Inversion**, we can see communication between `Repository` and `DataSource` there is an abstract class as the bridge or media for the communcation/DTO so whenever we, for example, want to change the `DataSource` to get from local or anywhere else, we just need to change the logic in `DataSource` as long as the expected output still remains as before.

![enter image description here](https://gcdnb.pbrd.co/images/kpXQRUr8eYHf.png?o=1)

Using this this approach really helps the developers to have a clear understanding about the objects, how the object interact to another and how the object have a single responsibility of its own function.

### State Management
I am using bloc/cubit for the state management. Because, it is simple, makes our development time faster. But, as our scope is particulary small so the boilerplate might painful.

### Data Source API
I am using firebase auth as the authentication provider and firebase firestore as the storage provider.

### Packages
|Packages|  Descriptions|
|--|--|
| google_fonts| Easy implement of material fonts, because we use monsterrat font|
| firebase_firestore| this is to store our data|
| firebase_auth| this is to our user email and credential|
| flutter_bloc| We use bloc/cubit for the state management|
| injectable| Helps to pattern mathcing for classes/objects, it provide dynamic return of object, make our function simpler|
| dartz| Cutting boilerplate codes in DTO from data to presentation layer|
| flutter_easyloading| This really helps our development speed since the dialogs/loading widget state is little bit frustrating. But, the **flutter_easyloading** is singleton so it makes the job easier we can modify whenever we want|
| get_it| Just give the dependency injection works to get_it, no more passing context through classes. Additionally, we focused on Seperation of Concern as we know needs to make the class loose coupled/decoupled. And the other benefits is we can easily mock classes that using **get_it**|
