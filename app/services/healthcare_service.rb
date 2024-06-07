# app/services/google_cloud.rb

require "google/apis/healthcare_v1"
require "googleauth"

module GoogleCloud
  class << self
    def healthcare_service
      @healthcare_service ||= begin
        service = Google::Apis::HealthcareV1::CloudHealthcareService.new
        service.client_options.application_name = "Healthcare_App_Service"
        service.authorization = Google::Auth::ServiceAccountCredentials.make_creds(
          json_key_io: File.open(Rails.root.join("config", "service-account-key.json")),
          scope: "https://www.googleapis.com/auth/cloud-platform"
        )
        service
      end
    end

    def search_fhir_resources(fhir_store, resource_type, params)
      HealthcareService.new.search_fhir_resources(fhir_store, resource_type, params)
    end
  end
end
