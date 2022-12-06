class RunDetailsController < ApplicationController

  def new
    @run_detail = RunDetail.new
  end

  def create
    @run_detail = RunDetail.new(run_detail_param)
    if @run_detail.save!
      redirect_to new_event_path, success: "Details ajouté 👍"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def run_detail_param
    params.require(:run_detail).permit(:run_type,
                                       :distance,
                                       :pace,
                                       :duration,
                                       :elevation,
                                       :location)
  end
end
