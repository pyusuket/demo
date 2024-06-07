class Fhir::OrganizationsController < ApplicationController
  def index
    client = FHIR::Client.new('http://hapi.fhir.org/baseR4')
    client.default_json
    response = client.search(FHIR::Organization, search: { parameters: { 'address-country': 'Japan' } })
    if response.resource.present?
      @organizations = response.resource.entry.map(&:resource)
    else
      @organizations = []
    end
  end
end
