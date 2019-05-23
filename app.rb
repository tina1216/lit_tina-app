require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require 'open-uri'
require 'sinatra/json'
require './models.rb'
require './models/contribution.rb'
require './image_uploader.rb'

enable :sessions

get '/signin' do
  erb :sign_in
end

get '/signup' do
  erb :sign_up
end

get '/signout' do
  session[:user] = nil
  redirect '/'
end

get '/' do
  @contents = Contribution.all.order("id desc")
  session[:url_now] = request.path_info
  erb :index
end

get '/post/:id' do
  @content = Contribution.find(params[:id])
  erb :post
end

post '/post/:id' do
  @content = Contribution.find(params[:id])
  erb :post
end

get '/search' do
  keyword = params[:keyword]
  unless keyword.blank?
    @contents = Contribution.where('shopname like ? OR coffee_taste like ? OR food_variation like ? OR for_working like ? OR text like ? OR image like ? OR wifi like ? OR laidback like ? OR dark like ? OR light like ? OR lively like ? OR quiet like ? OR station like? OR bitwalk like ? OR farsta like ? OR hidden like ? OR town like ?', "%#{keyword.to_i}%", "%#{keyword}%","%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword]}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%")
  else
    @contents = Contribution.all.order("id desc")
  end
  erb :index
end

get '/user_contributions' do
  @contributions = User.find(:user_id).contributions.all
  erb :user
end

get '/new' do
  erb :new
end

get '/mypage' do
  @user = User.find(session[:user])
  @contents = @user.contributions.all.order("id desc")
  session[:url_now] = request.path_info
  erb :mypage
end

get '/good_page' do
  @goods = Good.where(user_id: session[:user])
  session[:url_now] = request.path_info
  erb :good_page
end

post '/signin' do
  @user = User.find_by(mail: params[:mail], user_name: params[:user_name])
  if @user && @user.authenticate(params[:password])
    session[:user] = @user.id
  end
  redirect '/'
end

post '/signup' do
  if params[:file]
    img = params[:file]
    tempfile = img[:tempfile]
    upload = Cloudinary::Uploader.upload(tempfile.path)
    profile_img = upload['url']
  end

  @user= User.create(mail: params[:mail], user_name: params[:user_name], password: params[:password],
  password_confirmation: params[:password_confirmation], profile_img: params[:file])
  if @user.persisted?
    session[:user] = @user.id
  end

  redirect '/'
end

post '/new' do
  @user = User.find(session[:user])

   if params[:laidback]
    laidback = true
    else
    laidback = false
  end

  if params[:dark]
    dark = true
    else
    dark = false
  end

  if params[:light]
    light = true
    else
    light = false
  end

  if params[:quiet]
    quiet = true
    else
    quiet = false
  end

  if params[:lively]
    lively = true
    else
    lively = false
  end

  if params[:station]
    station = true
    else
    station = false
  end

  if params[:bitwalk]
    bitwalk = true
    else
    bitwalk = false
  end

  if params[:farsta]
    farsta = true
    else
    farsta = false
  end

  if params[:hidden]
    hidden = true
    else
    hidden = false
  end

  if params[:town]
    town = true
    else
    town = false
  end
  # pry.binding
  @user.contributions.create({
    shopname: params[:shopname],
    charger: params[:charger],
    wifi: params[:wifi],
    laidback: laidback,
    dark: dark,
    light: light,
    lively: lively,
    quiet: quiet,
    coffee_taste: params[:coffee_taste],
    food_variation: params[:food_variation],
    for_working: params[:for_working],
    station: station,
    bitwalk: bitwalk,
    farsta: farsta,
    hidden: hidden,
    town: town,
    text: params[:text],
    image: ""
  })

  if params[:file]
    image_upload(params[:file])
  end

  redirect "/"
end

post '/post/:id' do
  @content = Contribution.find(params[:id])
  redirect "/"
end

post '/goods/:id' do
  user = User.find(session[:user])
  user.goods.create({
    contribution_id: params[:id]
  })
  redirect "/"
end

post "/mypage" do
  @user = User.find(session[:user])
  @contents = user.contributions.all
end

post '/goods/delete/:id' do
  g = Good.find_by(contribution_id: params[:id], user_id: session[:user]).destroy

  redirect '/'
end

get '/delete/:id' do
  Contribution.find(params[:id]).destroy
  notgoods = Good.where(contribution_id: params[:id])
  notgoods.each do |notgood|
    notgood.destroy
  end

  redirect '/mypage'
end

get "/edit/:id" do
  @content = Contribution.find(params[:id])
  erb :mypage
end

post '/renew/:id' do
  content = Contribution.find(params[:id])

  if params[:laidback]
    laidback = true
    else
    laidback = false
  end

  if params[:dark]
    dark = true
    else
    dark = false
  end

  if params[:light]
    light = true
    else
    light = false
  end

  if params[:quiet]
    quiet = true
    else
    quiet = false
  end

  if params[:lively]
    lively = true
    else
    lively = false
  end

  if params[:station]
    station = true
    else
    station = false
  end

  if params[:bitwalk]
    bitwalk = true
    else
    bitwalk = false
  end

  if params[:farsta]
    farsta = true
    else
    farsta = false
  end

  if params[:hidden]
    hidden = true
    else
    hidden = false
  end

  if params[:town]
    town = true
    else
    town = false
  end

  if params[:file]
    img = params[:file]
    tempfile = img[:tempfile]
    upload = Cloudinary::Uploader.upload(tempfile.path)
    file = upload['url']
  else
    file = content.image
  end

  @content.update({
    shopname: params[:shopname],
    charger: params[:charger],
    wifi: params[:wifi],
    laidback: laidback,
    dark: dark,
    light: light,
    lively: lively,
    quiet: quiet,
    coffee_taste: params[:coffee_taste],
    food_variation: params[:food_variation],
    for_working: params[:for_working],
    station: station,
    bitwalk: bitwalk,
    farsta: farsta,
    hidden: hidden,
    town: town,
    text: params[:text],
    image: file
  })

  redirect '/mypage'
end

get '/mypage/:id' do

end
