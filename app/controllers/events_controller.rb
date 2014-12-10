class EventsController < ApplicationController
  before_filter :set_behaviours, only: [:new, :create, :show, :edit, :update]
  before_filter :find_set_event, only: [:edit, :update, :show]
  before_filter :remove_files, only:[:update]
  before_filter :admin_user_required!, except:[:download_event_file]
  
  def new
    @event = Event.new
    @event_files = EventFile.new
  end

  def create
    @event = Event.new(event_params)
    if params[:event_files_attributes].present?
      params[:event_files_attributes].each do |file|
        if file[:event_doc] && file[:display_name]
          @event.event_files.build(event_doc: file[:event_doc], display_name: file[:display_name])
        end
      end
    end
    if @event.save
      redirect_to admin_dashboard_path
    else
      enhance_error_msg(@event)
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if params[:event_files_attributes].present?
      params[:event_files_attributes].each do |file|
          if file[:id].present? && file[:event_doc].present?
            @file = EventFile.find_by_id(file[:id])
            @file.destroy
          end
          if file[:event_doc].present?
            @event.event_files.create(event_doc: file[:event_doc], display_name: file[:display_name])  
          elsif file[:id].present? && file[:display_name].present?
            @file = EventFile.find_by_id(file[:id])
            @file.update(display_name: file[:display_name])
          end
      end
    end
    processed_params_behaviours = mark_nested_attr_for_destroy(event_params, 'behaviours_events_attributes', 'behaviour_id')    
    if @event.update_attributes(processed_params_behaviours)      
      redirect_to admin_dashboard_path
    else
      enhance_error_msg(@event)
      render :edit
    end
  end


  def download_event_file
    @file = EventFile.find_by_id(params[:id])
    send_file @file.event_doc.path, filename: @file.display_name, type: @file.event_doc_content_type
  end

  private

  def event_params
    params.require(:event).permit(
      :title, :location, :event_date, :event_start_time, :event_end_time, :link, :description, :image,
      behaviours_events_attributes: [:id, :behaviour_id], event_files_attributes: [:id, :event_doc, :display_name]
    )
  end

  def find_set_event
    @event = Event.find_by_id(params[:id])
    @event_file = @event.event_files
    @event_files = @event.event_files.new
  end

  def remove_files
    @event_files.destroy
  end

  def enhance_error_msg(instence)
    if instence.errors[:image_file_size].present?
      instence.errors.delete(:image_file_size)
      instence.errors.delete(:image)
      instence.errors.add('error:', 'File size too large, please choose a different file.')
    end
  end
end
