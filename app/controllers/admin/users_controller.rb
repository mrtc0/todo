class Admin::UsersController < ApplicationController
  before_action :require_admin!, only: [:index, :new, :edit, :update, :destory]

  def index
    @users = User.all
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
