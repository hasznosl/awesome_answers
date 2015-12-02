ActiveAdmin.register Campaign do

  permit_params do
    [:title, :description, :goal, :end_date]
  end

end
