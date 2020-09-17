class Api::V1::EventsController < ApplicationController
  def index
    events = Event.paginate(page: params[:page])
    render json: events, meta: pagination(events)
  end

  def show
    event = Event.find(params[:id])
    render json: event, include: :tickets
  end
end
