# encoding: UTF-8
class ApplicationController < ActionController::Base
  def index
    render :text => 'ok'
  end
end
