Rails.application.routes.draw do

  controller :display do
    get 'pics' => 'display#allPhotos'
    get 'pics/users' => 'display#allUsers'
    get 'pics/user/:id' => 'display#showUser'
    get 'pics/comment/:id' => 'display#newComment'
    post 'pics/comment/:id' => 'display#createComment'
    get 'pics/photo' => 'display#newPhoto'
    post 'pics/post_photo' => 'display#uploadPhoto'
    get 'pics/user/:id/newTag' => 'display#goToTag'
    post 'pics/user/:id/newTag' => 'display#createTag'
    get 'pics/:id' => 'display#showPhoto'
    get 'pics/show_thumbnails/:str' => 'display#show_thumb'
  end

  controller :user do
    get 'user/login' => 'user#login'
    post 'user/login' => 'user#create'
    post 'user/logout' => 'user#destroy'
    get 'user/logout' => 'user#logout'
  end

  controller :register do 
    get 'user/register' => 'register#reg'
    post 'user/register' => 'register#handle_registering'
    post 'user/post_register' => 'register#registered'
  end


  
  
end
