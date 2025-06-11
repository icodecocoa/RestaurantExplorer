//
//  Attributes.swift
//  RestuarantExplorer
//
//  Created by Drashti Lakhani on 6/11/25.
//

//MARK: - Restaurant Atttributes
struct Attributes: Codable {
    let name: String?
    let priceLevel: Int?
    let phone: String?
    let menuURL: String?
    let requireBookingPreferenceEnabled, difficult: Bool?
    let cuisine: String?
    let imageURL: String?
    let latitude, longitude: Double?
    let addressLine1, ratingsAverage: String?
    let ratingsCount: Int?
    let labels: [String]?
    let alcohol: Bool?
    let deal: String?
    let description, establishmentType: String?
    let externalRatingsURL: String?
    let imageUrls: [String]?
    let neighborhoodName: String?
    let notice: String?
    let operatingHours: String?
    let outdoorSeating: Bool?
    let postalCode, province, relationshipType: String?
    let reservationNoticeDuration: Int?
    let smoking, valet: Bool?
    let slug, key, addressLine2, city: String?
    let customConfirmationComments: String?
    let termsAndConditions: String?
    let ratingsImg: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case priceLevel = "price_level"
        case phone
        case menuURL = "menu_url"
        case requireBookingPreferenceEnabled = "require_booking_preference_enabled"
        case difficult, cuisine
        case imageURL = "image_url"
        case latitude, longitude
        case addressLine1 = "address_line_1"
        case ratingsAverage = "ratings_average"
        case ratingsCount = "ratings_count"
        case labels, alcohol, deal, description
        case establishmentType = "establishment_type"
        case externalRatingsURL = "external_ratings_url"
        case imageUrls = "image_urls"
        case neighborhoodName = "neighborhood_name"
        case notice
        case operatingHours = "operating_hours"
        case outdoorSeating = "outdoor_seating"
        case postalCode = "postal_code"
        case province
        case relationshipType = "relationship_type"
        case reservationNoticeDuration = "reservation_notice_duration"
        case smoking, valet, slug, key
        case addressLine2 = "address_line_2"
        case city
        case customConfirmationComments = "custom_confirmation_comments"
        case termsAndConditions = "terms_and_conditions"
        case ratingsImg = "ratings_img"
    }
    
    init(
        name: String? = nil,
        priceLevel: Int? = nil,
        phone: String? = nil,
        menuURL: String? = nil,
        requireBookingPreferenceEnabled: Bool? = nil,
        difficult: Bool? = nil,
        cuisine: String? = nil,
        imageURL: String? = nil,
        latitude: Double? = nil,
        longitude: Double? = nil,
        addressLine1: String? = nil,
        ratingsAverage: String? = nil,
        ratingsCount: Int? = nil,
        labels: [String]? = nil,
        alcohol: Bool? = nil,
        deal: String? = nil,
        description: String? = nil,
        establishmentType: String? = nil,
        externalRatingsURL: String? = nil,
        imageUrls: [String]? = nil,
        neighborhoodName: String? = nil,
        notice: String? = nil,
        operatingHours: String? = nil,
        outdoorSeating: Bool? = nil,
        postalCode: String? = nil,
        province: String? = nil,
        relationshipType: String? = nil,
        reservationNoticeDuration: Int? = nil,
        smoking: Bool? = nil,
        valet: Bool? = nil,
        slug: String? = nil,
        key: String? = nil,
        addressLine2: String? = nil,
        city: String? = nil,
        customConfirmationComments: String? = nil,
        termsAndConditions: String? = nil,
        ratingsImg: String? = nil
    ) {
        self.name = name
        self.priceLevel = priceLevel
        self.phone = phone
        self.menuURL = menuURL
        self.requireBookingPreferenceEnabled = requireBookingPreferenceEnabled
        self.difficult = difficult
        self.cuisine = cuisine
        self.imageURL = imageURL
        self.latitude = latitude
        self.longitude = longitude
        self.addressLine1 = addressLine1
        self.ratingsAverage = ratingsAverage
        self.ratingsCount = ratingsCount
        self.labels = labels
        self.alcohol = alcohol
        self.deal = deal
        self.description = description
        self.establishmentType = establishmentType
        self.externalRatingsURL = externalRatingsURL
        self.imageUrls = imageUrls
        self.neighborhoodName = neighborhoodName
        self.notice = notice
        self.operatingHours = operatingHours
        self.outdoorSeating = outdoorSeating
        self.postalCode = postalCode
        self.province = province
        self.relationshipType = relationshipType
        self.reservationNoticeDuration = reservationNoticeDuration
        self.smoking = smoking
        self.valet = valet
        self.slug = slug
        self.key = key
        self.addressLine2 = addressLine2
        self.city = city
        self.customConfirmationComments = customConfirmationComments
        self.termsAndConditions = termsAndConditions
        self.ratingsImg = ratingsImg
    }
}
