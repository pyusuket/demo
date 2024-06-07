class Fhir::PatientsController < ApplicationController
  def index
    response = FHIR_CLIENT.search(FHIR::Patient)
    @patients = response.resource&.entry&.map(&:resource) || []
    respond_to do |format|
      format.html
      format.json { render json: @patients }
    end
  end

  def new
    @patient = FHIR::Patient.new
  end

  def create
    @patient = FHIR::Patient.new(patient_params)
    response = FHIR_CLIENT.create(@patient)
    if response.code == 201
      redirect_to fhir_patients_path, notice: 'Patient was successfully created.'
    else
      render :new
    end
  end

  private

  def patient_params
    params.require(:patient).permit(:family, :given, :gender)
  end
end
