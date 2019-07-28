class AddDateAndDayToWeather < ActiveRecord::Migration[5.1]
  def change
    add_column :weathers, :date, :string
    add_column :weathers, :day, :string
  end
end
