class VotesController < ApplicationController
    before_action :set_product, only: [:create]
    before_action :set_comment, only: [:create]

    before_action :set_votable, only: [:create]

    def create
        Vote.create votable:@votable
        redirect_to @product, notice: 'Gracias por tu voto.'
    end

    private
    
    def set_votable
        if @comment
            @votable = @comment
        else
            @votable = @product
        end
    end

    def set_comment
        @comment = Comment.find params[:comment_id] if params.has_key? :comment_id
    end

    def set_product
        @product = Product.find_by slug:params[:product_id]
    end

end