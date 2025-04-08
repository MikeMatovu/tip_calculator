class TipsController < ApplicationController
  before_action :authenticate_user!
  def index
    @tip = Tip.new
    @tip_percentages = [ 5, 10, 15, 25, 50 ]
  end

  def create
    @tip = Tip.new(tip_params)
    if @tip.save
      calculate_tip(@tip)
      render json: {
        tip_amount: @tip.tip_amount,
        total_amount: @tip.total,
        per_person: @tip.per_person_amount,
        per_person_tip: @tip.per_person_tip
      }, status: :ok
    else
      render json: { error: @tip.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  def show
    @tip = Tip.find(params[:id])
    render json: {
      tip_amount: @tip.tip_amount,
      total_amount: @tip.total,
      per_person: @tip.per_person_amount,
      per_person_tip: @tip.per_person_tip
    }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Tip not found" }, status: :not_found
  end

  private

  def tip_params
    params.require(:tip).permit(:bill, :tip_percentage, :number_of_people)
  end

  def calculate_tip(tip)
    tip.tip_amount = (tip.bill * tip.tip_percentage / 100.0).round(2)
    tip.total = (tip.bill + tip.tip_amount).round(2)
    tip.per_person_amount = (tip.total / tip.number_of_people).round(2)
    tip.per_person_tip = (tip.tip_amount / tip.number_of_people).round(2)
    tip.save
  end
end
