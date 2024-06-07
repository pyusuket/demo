class Fhir::EncountersController < ApplicationController
    def index
    base_url = 'http://example.com/fhir/baseURL'  # FHIRサーバーのベースURLに置き換える
    client = FHIR::Client.new(base_url)
    client.default_json
    response = client.search(FHIR::Encounter)
    @encounters = response.resource.entry.map(&:resource)
  end
end
