# frozen_string_literal: true

class FindingsController < ApplicationController
  before_action :set_finding, only: [:show]

  # GET /findings
  def index
    @findings = Finding.all
    render json: @findings, each_serializer: FindingSerializer
  end

  # GET /findings/1
  def show
    render json: @finding, serializer: FindingSerializer, status: :ok, message: 'Success'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_finding
    @finding = Finding.find(params[:id])
  end
end
