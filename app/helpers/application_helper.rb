module ApplicationHelper
  def self.date_params_to_date_object(params)
    return unless params['date(1i)']

    Date.new(params['date(1i)'].to_i,
             params['date(2i)'].to_i,
             params['date(3i)'].to_i)
  end
end
