# app/controllers/healthcare_controller.rb
require 'net/http'
require 'uri'
require 'json'
require 'googleauth'

class HealthcareController < ApplicationController
  def index
    project_id = "cloud-healthcare-api-425106"
    location = "asia-northeast1"
    dataset_id = "Healthcare_App_Service"
    fhir_store_id = "test-data-store"
    resource_type = "Patient"
    access_token = get_access_token

    uri = URI.parse("https://healthcare.googleapis.com/v1/projects/#{project_id}/locations/#{location}/datasets/#{dataset_id}/fhirStores/#{fhir_store_id}/fhir/#{resource_type}")
    request = Net::HTTP::Get.new(uri)
    request["Authorization"] = "Bearer #{access_token}"
    request["Content-Type"] = "application/json"

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    response = http.request(request)

    if response.code == "200"
      @results = JSON.parse(response.body)
      Rails.logger.info("API Response: #{@results.inspect}")
    else
      @results = nil
      Rails.logger.error("API Request Failed: #{response.message}")
      Rails.logger.error("API Response Body: #{response.body}")
    end
  end

  private

  def get_access_token
    keyfile = File.open(Rails.root.join("config", "service-account-key.json"))
    auth = Google::Auth::ServiceAccountCredentials.make_creds(
      json_key_io: keyfile,
      scope: 'https://www.googleapis.com/auth/cloud-platform'
    )
    auth.fetch_access_token!
    auth.access_token
  end
end
