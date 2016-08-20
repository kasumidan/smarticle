module Smarticle::SmarticleHelper
  def self.change_order(items, column_name, theOrder, oldIndex, newIndex)
    return if oldIndex == newIndex

    sort_items = items.order(column_name)
    arr = sort_items.pluck(:id)

    arr.insert(newIndex, arr.delete_at(oldIndex))

    arr.each_with_index do |id, idx|
      item = items.find(id)
      item[column_name] = idx
      item.save
    end

  end

  def self.check_auth
    if Smarticle.owner_class.present?
      auth_method_name = "authenticate_" +Smarticle.owner_class.to_s.downcase + "!"
      send(auth_method_name)
    end
  end

end
