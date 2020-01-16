class DisplayController < ApplicationController
    def allPhotos
      @phs = Photo.all
    end
  
    def allUsers
      @users = User.all
    end
  
    def allComments
    end
  
    def showUser
      if params[:id] and User.exists?(params[:id])
        @user = User.find(params[:id])
      end
      @logged_in = current_user
    end

    def newComment
      u = current_user
      if u
        @photo = Photo.find(params[:photo_id])
        @user = u
      else
        redirect_to("/user/login")
      end
    end
  
    def createComment
      #TODO to be improve
      cm = params[:comment]
      if cm.nil? or cm.empty?
        flash[:alert] = "comment must not be empty!"
        redirect_to :action => :newComment, :photo_id => params[:photo_id]
        return
      end
      
      comment = Comment.new(:date_time => DateTime.current,
          :comment => params[:comment])
      comment.user_id = params[:user_id]
      comment.photo_id = params[:photo_id]
      respond_to do |fm|
        if comment.save
          fm.html{redirect_to :action => :showUser}
        else
          fm.html{redirect_to :action => :newComment}
        end
      end
    end

    def showPhoto
      if current_user
        @logged_in = true
        @new_comment = Comment.new()
        @new_comment.user = User.find(current_user.id)
      end
  
      if params[:id] and Photo.exists?(params[:id])
        @photo = Photo.find(params[:id])
        @tagged_users = []
        @photo.tags.each { |t| @tagged_users << (t.user.first_name + t.user.last_name) }
        @tagged_users = @tagged_users.uniq.sort
      else
        add_alert(false, :alert_error, "That photo does not exist, or you did not provide a photo id.")
      end
    end
  
    def newPhoto
      u = current_user
      if u
        @user = u
      else
        redirect_to("/user/login")
      end
    end
  
    def getFileName(filename)  
      if !filename.nil?  
        Time.now.strftime("%Y_%m_%d_%H_%M_%S") + '_' + filename  
      end  
    end 
  
    def uploadFile(file)  
      if !file.original_filename.empty?  
        filename=getFileName(file.original_filename)   
        File.open("#{Rails.root}/public/images/#{filename}", "wb") do |f|  
          f.write(file.read)  
        end  
        return filename  
      end  
    end
  
    def uploadPhoto
      file = params[:file]
      if file
        puts params[:user_id]
        filename = uploadFile(file)
        if filename
          photo = Photo.new(:date_time => DateTime.current,
                            :file_name => filename)
          photo.user_id = params[:user_id]
  
          respond_to do |fm|
            if photo.save
              #fm.html{redirect_to :action => :showUser}
              fm.html{redirect_to "/pics/user/" + photo.user_id.to_s}
            else
              fm.html{redirect_to :action => :newPhoto}
            end
          end
        end
      else
        flash[:alert] = "please select the a file"
        redirect_to :action => :newPhoto
      end
    end


    def goToTag
      u = current_user
      if u
        @photo = Photo.find(params[:photo_id])
        @user = u
      else
        redirect_to("/user/login")
      end
    end

    def createTag
      #@photo = Photo.find(params[:photo_id])
      #@tagUser = User.find(params[:user_id])
      tag = Tag.new(:photo_id => params[:photo_id],
                    :user_id => params[:tag][:user_id], 
                    :x_coord => params[:x_coord],
                    :y_coord => params[:y_coord],
                    :width => params[:width],
                    :height => params[:height],)
      tag.save!
  
      redirect_to :controller => 'display', :action => 'showPhoto', :id => tag.photo.id
    end
  
    def deleteTag
      tag = Tag.find(params[:tag_id])
      tag_user = tag.photo.user
      tag.destroy!
      redirect_to :controller => 'photos', :action => 'show', :user_id => tag_user
    end

    def show_thumb
      @searchStr = params[:str]
  
      comments = Comment.where('comment LIKE ?', "%#{@searchStr}%").all
      firstUsers = User.where('first_name LIKE ?', "%#{@searchStr}%").all
      lastUsers = User.where('last_name LIKE ?', "%#{@searchStr}%").all
      users = firstUsers | lastUsers
  
      @photos = comments.map{ |c| c.photo } | users.flat_map{ |u| u.photos }
      #render layout: false
    end
   
end