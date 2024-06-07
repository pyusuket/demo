# config/initializers/fhir_client.rb
require 'fhir_client'

FHIR_CLIENT = FHIR::Client.new('http://hapi.fhir.org/baseR4')
FHIR_CLIENT.default_json
