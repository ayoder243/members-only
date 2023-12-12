class PostsController < ApplicationController
    before_action :restricted_access, only: [:new, :create]

    def new
        @post = current_user.posts.build
    end

    def create
        @post = current_user.posts.build(post_params)

        if @post.save
            redirect_to root_path
        else
            render :new, status: :unprocessable_entity
        end
    end

    def index
        @posts = Post.all
    end

    private

    def restricted_access
        unless user_signed_in?
            flash[:error] = "You must be logged in to access the author"
            redirect_to new_user_registration_path
        end
    end

    def post_params
        params.require(:post).permit(:title, :article, :user_id)
    end
end
