import Foundation
import AppointoModel

protocol AddEditAppointmentFormValidator {
    func validate(
        description: String,
        selectedDate: Date,
        selectedLocation: Location?,
        in mode: AddEditAppointmentFeature.State.Mode
    ) -> Bool
}

struct DefaultAddEditAppointmentFormValidator: AddEditAppointmentFormValidator {
    func validate(
        description: String,
        selectedDate: Date,
        selectedLocation: Location?,
        in mode: AddEditAppointmentFeature.State.Mode
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

private extension DefaultAddEditAppointmentFormValidator {
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
