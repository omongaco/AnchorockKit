/// Enums  that will be used by our App globally
/// contains severals enums:
///
/// - List:
///     - FBFieldType
///     - FBValueType

/// APIEndPoint
/// The list of endpoints the API server provides
/// within the app
public enum APIEndpoint: String {
    case apiRequestAccount                   = "/account"
    case apiRequestArea                      = "/area"
    case apiRequestBuilding                  = "/building"
    case apiRequestCategory                  = "/category"
    case apiRequestChirp                     = "/chirp"
    case apiRequestChirpMedia                = "/chirpMedia"
    case apiRequestCertificate               = "/certificate"
    case apiRequestCertificateInstance       = "/certificateInstance"
    case apiRequestCertificateInstanceMedia  = "/certificateInstanceMedia"
    case apiRequestCertificateInstanceReport = "/certificateInstance/expire"
    case apiRequestDocument                  = "/document"
    case apiRequestDocumentRelation          = "/documentRelation"
    case apiRequestDocumentAnnotation        = "/documentAnnotation"
    case apiRequestDocumentMedia             = "/documentMedia"
    case apiRequestDocumentMediaLink         = "/documentMediaLink"
    case apiRequestDocumentMediaOverlay      = "/documentMediaOverlay"
    case apiRequestDocumentTag               = "/documentTag"
    case apiRequestFieldNote                 = "/fieldNote"
    case apiRequestFieldNoteMedia            = "/fieldNoteMedia"
    case apiRequestFieldNoteTag              = "fieldNoteTag"
    case apiRequestFloor                     = "/floor"
    case apiRequestFormInstance              = "/formInstance"
    case apiRequestFormInstanceUser          = "/formInstanceUser"
    case apiRequestFormInstanceDocument      = "/formInstanceDocument"
    case apiRequestFormInstanceMedia         = "/formInstanceMedia"
    case apiRequestFormInstanceCertificate   = "/formInstanceCertificate"
    case apiRequestLocation                  = "/location"
    case apiRequestMedia                     = "/media"
    case apiRequestProject                   = "/project"
    case apiRequestReportJournal             = "/reportJournal"
    case apiRequestReportTimesheet           = "/reportTimesheet"
    case apiRequestTrade                     = "/trade"
    case apiRequestTag                       = "/tag"
    case apiRequestTask                      = "/task"
    case apiRequestTaskMedia                 = "/taskMedia"
    case apiRequestTaskComment               = "/taskComment"
    case apiRequestTaskDocument              = "/taskDocument"
    case apiRequestTaskCommentMedia          = "/taskCommentMedia"
    case apiRequestTaskWorkLog               = "/taskWorkLog"
    case apiRequestTeam                      = "/team"
    case apiRequestUser                      = "/user"
    case apiRequestUserMedia                 = "/user/media"
    case apiRequestUserScan                  = "/user/scan"
    case apiRequestUserPreference            = "/userPreferences"
    case apiRequestUserIntegration          = "/integration/configuration"
    case apiRequestForgotPassword           = "/user/forgotPassword"
    case apiRequestLogin                     = "/user/getloggedInUser"
    case apiRequestSymbolLibrary             = "/symbolLibrary"
    case apiRequestSymbolLibraryMedia        = "/symbolLibraryMedia"
    case apiRequestMeeting                   = "/meeting/raw"
    case apiRequestMeetingMinutes            = "/meetingMinute"
    case apiRequestMeetingMinutesDocument    = "/meetingMinuteDocument"
    case apiRequestMeetingMinutesMedia       = "/meetingMinuteMedia"
    case apiRequestMeetingMinutesUser        = "/meetingMinuteUser"
    case apiRequestMeetingHazard             = "/meetingHazard"
    case apiRequestMeetingHazardMedia        = "/meetingHazardMedia"
    case apiRequestMeetingHazardDocument     = "/meetingHazardDocument"
    case apiRequestMeetingHazardComment      = "/meetingHazardComment"
    case apiRequestMeetingHazardCommentMedia = "/meetingHazardCommentMedia"
    case apiRequestMeetingOwnership = "/meeting/ownership"
    case apiRequestRegisterUserPushNotification = "/userPushNotif/register"
    case apiRequestUnregisterUserPushNotification = "/userPushNotif/unregister"
    case apiRequestGroup = "/meetingGroup"
    case apiRequestProcedureSet = "/procedure"
    case apiRequestFormPermission = "/meetingAccessibility/accessibility"
    case apiRequestFormAccessibility = "/meetingAccessibility"
    case apiRequestModuleProcedure = "/meetingProcedure/mapping"
}


/// FBFieldType
/// The list of custom components used
/// Within Form Builder
public enum FBFieldType: String {
    // Input Component
    case textfield = "text_field"
    case textview = "text_view"
    case textswitch = "text_switch"
    // Picker Component
    case datetimepicker = "datetime_picker"
    case textpicker = "text_picker"
    case userpicker = "user_picker"
    // Table Component
    case collectionworkprogress = "collection_work_progress"
    case tabletextlist = "table_text_list"
    case tablehourslog = "table_hours_log"
    case tableswitchlist = "table_switch_list"
    //  Container Component
    case mediacontainer = "media_container"
    case signatureview = "signature_view"
    
    func toString() -> String {
        self.rawValue
    }
}

/// FBValueType
/// The list of custom components used
/// Within Form Builder
public enum FBValueType: String {
    case switcher = "switcher"
    case segmentor = "segmentor"
    case textfield = "textfield"
    case textview = "textview"
    case crewLog = "crew_log"
    case userUuid = "user_uuid"
    case contractorLog = "contractor_log"
    case signatureMedia = "signature_media"
    case photoMedia = "photo_media"
    
    func toString() -> String {
        self.rawValue
    }
}
