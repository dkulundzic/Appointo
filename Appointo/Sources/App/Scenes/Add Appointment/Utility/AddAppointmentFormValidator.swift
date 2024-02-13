import Foundation
import AppointoModel

protocol AddAppointmentFormValidator {
    func validate(
        description: String,
        selectedDate: Date,
        selectedLocation: Location?,
        in mode: AddAppointmentFeature.State.Mode
    ) -> Bool
}

struct DefaultAddAppointmentFormValidator: AddAppointmentFormValidator {
    func validate(
        description: String,
        selectedDate: Date,
        selectedLocation: Location?,
        in mode: AddAppointmentFeature.State.Mode
    ) -> Bool {
        switch mode {
        case .creation:
            return validateCreation(
                description: description,
                selectedDate: selectedDate,
                selectedLocation: selectedLocation
            )

        case .edit(let appointment):
            return validateEditing(
                description: description,
                selectedDate: selectedDate,
                selectedLocation: selectedLocation,
                appointment: appointment
            )
        }
    }
}

private extension DefaultAddAppointmentFormValidator {
    func validateCreation(
        description: String,
        selectedDate: Date,
        selectedLocation: Location?
    ) -> Bool {
        let optionals: [Any?] = [selectedDate, selectedLocation]
        return optionals.allSatisfy { $0 != nil } && !description.isEmpty
    }

    func validateEditing(
        description: String,
        selectedDate: Date,
        selectedLocation: Location?,
        appointment: Appointment
    ) -> Bool {
        let defaultValidation = validateCreation(
            description: description,
            selectedDate: selectedDate,
            selectedLocation: selectedLocation
        )

        let updatedAppointment = Appointment(
            id: appointment.id,
            date: selectedDate,
            location: selectedLocation ?? appointment.location,
            description: description
        )

        return [
            defaultValidation,
            updatedAppointment != appointment
        ].allSatisfy { $0 == true }
    }
}
