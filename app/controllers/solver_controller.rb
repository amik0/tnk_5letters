class SolverController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    solver = Solver.new
    result = []

    params[:attempts].each do |attempt|
      result = solver.add_attempt(attempt)
      return render json: { error: result }, status: :bad_request unless result.is_a?(Array)
    end

    render json: { result: }
  end
end
