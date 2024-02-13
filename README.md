# Appointo!

## Project set-up

The project is based on the Tuist project-generation tool, and is required to set-up the project properly. Please [install Tuist first](https://docs.tuist.io/documentation/tuist/installation).

Following successful Tuist installation, please run the following commands at the root-level (the folder containing `Project.swift`):
1. `tuist fetch`
2. `tuist generate`

Successful execution of these commands should bring up Xcode upon successful completion.

## Project architecture

The project uses [The Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture) (in short - **TCA**) to architect the codebase. TCA is a Redux-based architecture that's wonderful to use, if maybe a steep learner a bit. 

Using TCA, the Appointo app has 2 features:
1. The `AppointmentListFeature` - displays available appointments
2. The `AddEditAppointmentFeature` - enables users to create, edit or delete appointments

## Project modularity

Appointo uses four frameworks to modularize the codebase and allow easy access to reusable code:
1. `AppointoCore`
2. `AppointoModel`
2. `AppointoLocalization`
2. `AppointoUi`

### AppointoCore

Defines the lowest level types.

### AppointoModel

Defines domain types, validators and transformation tools related to the model layer.

### AppointoLocalization

Holds all localization related resources. Can be imported to access all localization assets.

### AppointoUi

All UI related functionality, such as `UIView` subclasses, image and color assets, and similar.

## Strongly-typed asset interface generation

Tuist uses [Swiftgen](https://github.com/SwiftGen/SwiftGen) internally, which is run on each `tuist generate` command; creates an strongly-typed interface to images, colors and localization strings.

## Notes

1. The persistence is in-memory only, as it should be enough for demonstration purposes.
2. The appointment deletion action could use an alert, but I think the current approach is good enough for demo purposes.