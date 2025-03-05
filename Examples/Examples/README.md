# Examples

## Read This First

- The app is modularized using SPM to demonstrate its compatibility with a modular architecture. However, when integrating it into your app, you can keep everything in a single module if you prefer.  
- Some modules follow the MV architecture, while others with a ViewModel use MVVM. The choice of architecture is entirely up to you—SwiftUINavigation solely provides a solution for the navigation layer.  
- Dependencies for `NavigationModel`s are handled via initializers. To avoid passing them in every init, you can use a dependency manager like [swift-dependencies](https://github.com/pointfreeco/swift-dependencies). 
- There is a `Shared` module that contains e.g. objects for deep linking, which can be used across any module. Implementations of certain services are located in the main app within the `Dependencies` folder.  
- The `ActionableList` module serves as a generic module for list screens with items. To see what items each list contains, check the implementation of factories in the module’s `Data/Factories/...` folder.  

## Getting Started

1. Have you downloaded the repo? Make sure to **rename** the downloaded folder to `SwiftUINavigation`

2. Open the app at path `SwiftUINavigation/Examples/Examples.xcodeproj`

3. Run the app

    - On simulator
    - On a real device (set your development team)

4. Explore the app

## Documentation

For the full documentation, refer to `SwiftUINavigation/README.md` or visit the [GitHub repo](https://github.com/RobertDresler/SwiftUINavigation).

## Issues

If you encounter any bugs or have a feature request, feel free to open an issue or a pull request in the repo.
