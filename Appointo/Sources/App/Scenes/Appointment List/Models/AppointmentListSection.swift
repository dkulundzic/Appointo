import Foundation
import AppointoModel
import ComposableArchitecture

struct AppointmentListSection: Hashable, Identifiable {
    var id: String {
        title
    }
    
    let title: String
    let appointments: IdentifiedArrayOf<Appointment>

    func hash(
        into hasher: inout Hasher
    ) {
        hasher.combine(id)
    }
}
