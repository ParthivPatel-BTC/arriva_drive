class Participant::NetworksController < ApplicationController
  layout 'participant'
  before_filter :participant_user_required!

  def index
    @participants = Participant.all_participants(current_participant.id)
    get_network_for_current_participant
  end

  def seach_by_alpha_character
    respond_to do |format|
      @participants = Participant.participant_by_alpha_search(params[:alpha_character]).all_participants(current_participant.id)
        format.js{
          render file: 'participant/networks/index'
        }
    end
  end

  def get_all_participants
    @participants = Participant.all_participants(current_participant.id)
    respond_to do |format|
      format.js{
        render file: 'participant/networks/index'
      }
    end
  end

  def add_to_network
    @network = Network.new(network_params)
    if @network.save
      respond_to do |format|
        @participants = Participant.all_participants(current_participant.id)
          format.js{
            render file: 'participant/networks/index'
          }
      end
    end
  end

  private

  def get_network_for_current_participant
    @networks = Network.find_all_by_current_participant_id(current_participant.id)
  end

  def network_params
    network_params = {}
    network_params[:current_participant_id] = current_participant.id
    network_params[:participant_id] = params[:participant_id]
    network_params
  end
end