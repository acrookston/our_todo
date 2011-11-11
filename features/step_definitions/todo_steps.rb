Given /^the following todos exist:$/ do |table|
  table.hashes.each do |row|
    ::Todo.create!(row_to_attributes(row))
  end
end
