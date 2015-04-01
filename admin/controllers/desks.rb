Aspectserver::Admin.controllers :desks do
  get :index do
    @title = "Desks"
    @desks = Desk.all
    render 'desks/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'desk')
    @desk = Desk.new
    render 'desks/new'
  end

  post :create do
    @desk = Desk.new(params[:desk])
    if @desk.save
      @title = pat(:create_title, :model => "desk #{@desk.id}")
      flash[:success] = pat(:create_success, :model => 'Desk')
      params[:save_and_continue] ? redirect(url(:desks, :index)) : redirect(url(:desks, :edit, :id => @desk.id))
    else
      @title = pat(:create_title, :model => 'desk')
      flash.now[:error] = pat(:create_error, :model => 'desk')
      render 'desks/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "desk #{params[:id]}")
    @desk = Desk.get(params[:id])
    if @desk
      render 'desks/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'desk', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "desk #{params[:id]}")
    @desk = Desk.get(params[:id])
    if @desk
      if @desk.update(params[:desk])
        flash[:success] = pat(:update_success, :model => 'Desk', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:desks, :index)) :
          redirect(url(:desks, :edit, :id => @desk.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'desk')
        render 'desks/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'desk', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Desks"
    desk = Desk.get(params[:id])
    if desk
      if desk.destroy
        flash[:success] = pat(:delete_success, :model => 'Desk', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'desk')
      end
      redirect url(:desks, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'desk', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Desks"
    unless params[:desk_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'desk')
      redirect(url(:desks, :index))
    end
    ids = params[:desk_ids].split(',').map(&:strip)
    desks = Desk.all(:id => ids)
    
    if desks.destroy
    
      flash[:success] = pat(:destroy_many_success, :model => 'Desks', :ids => "#{ids.to_sentence}")
    end
    redirect url(:desks, :index)
  end
end
