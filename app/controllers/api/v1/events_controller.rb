class Api::V1::EventsController < ApplicationController
  def index
    events = Event.all
    render json: events, adapter: :json
  end

  def show
    event = Event.find(params[:id])
    render json: event, adapter: :json
  end
end
