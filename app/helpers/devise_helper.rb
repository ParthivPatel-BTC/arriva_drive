module DeviseHelper
 def devise_error_messages!
  return '' if resource.errors.empty?

   messages = resource.errors.full_messages.map { |msg| content_tag(:span, msg) }.join
   sentence = I18n.t('admin.captions.forgot_password',
   count: resource.errors.count,
   resource: resource.class.model_name.human.downcase)

   html = <<-HTML
   <div class="row-fluid flash_msg">
    <div class="text-center alert alert-danger">
      <button type="button" class="close" data-dismiss="alert">x</button>
      <i class="icon-remove"></i>
        #{messages}
    </div>
   </div>
   HTML

   html.html_safe
 end
end

