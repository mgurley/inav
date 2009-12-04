class JavascriptsController < ApplicationController
  def patient_provider_assignment
    @patient_provider_relationship_types = PatientProviderRelationshipType.find(:all)
    respond_to do |format|
      format.js
    end
  end
end