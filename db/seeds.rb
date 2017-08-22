channel_list = [
  ["channel01", "TRANS7"],
  ["channel02", "RCTI"],
  ["channel03", "SCTV"],
  ["channel04", "TRANS"],
  ["channel05", "GTV"],
  ["channel06", "IVM"],
  ["channel07", "MNCTV"],
  ["channel08", "METRO"],
  ["channel09", "TVONE"],
  ["channel10", "ANTV"],
  ["channel11", "TVRI"],
  ["channel12", "RTV"],
  ["channel13", "INEWSTV"],
  ["channel14", "OCHNL"],
  ["channel15", "NET"],
  ["channel16", "KOMPASTV"]
]

channel_list.each.with_index do |list, index|
  id = index + 1
  Channel.find_or_create_by(id: id, channel_id: list[0], name: list[1])
end

# creating first account for admin
admin_exists = User.find_by_admin(true)
unless admin_exists
  u = User.new(email: "admin@vislog.com", username: "admin", password: "admin123", password_confirmation: "admin123", admin: true, name: "Admin")
  u.save!
end
