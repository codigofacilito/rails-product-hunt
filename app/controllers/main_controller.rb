class MainController < ApplicationController

    def welcome
        redirect_to products_path
    end

end
