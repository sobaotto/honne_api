class QuestionsController < ApplicationController
  def index
    @users = [{id:1,name:'hoge',email: 'hoge@hoge.hoge'}]
  end

  def show
  end

  def create
  end
end
