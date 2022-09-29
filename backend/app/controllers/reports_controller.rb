class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :update, :destroy]

  # GET /reports
  def index
    @reports = Report.all

    render json: @reports
  end

  def show
    render json: @report, status: :ok, message: 'Success'
  end

  # POST /reports
  def create
    @report = Report.new(report_params)

    if @report.save
      render json: { status: :ok, message: 'Success' }
    else
      render json: @report.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /reports/1
  def update
    if @report.update(report_params)
      render json: { status: :ok, message: 'Success' }
    else
      render json: @report.errors, status: :unprocessable_entity
    end
  end

  # DELETE /reports/1
  def destroy
    if @report.destroy
      render json: { json: 'Report was successfully deleted.'}
    else
      render json: @report.errors, status: :unprocessable_entity
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def report_params
      params.require(:report).permit(:title, :link, :source, :version)
    end
end
