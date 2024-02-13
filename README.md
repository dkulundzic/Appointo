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