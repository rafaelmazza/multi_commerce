RailsAdmin.config do |config|
  config.model User do
    object_label_method do
      :email
    end
  end
  
  config.model Franchise do
    object_label_method do
      :name
    end
  end
  
  config.model Product do
    exclude_fields :line_items
    object_label_method do
      :name
    end
  end
end