class MicropostsController < ApplicationController
    def index()
        @posts = Micropost.all()
    end

    def show()
        @post = Micropost.find(params[:id])
    end

    def new()
        @post = Micropost.new()
    end

    def create()
        @post = Micropost.new(verify_user_params())

        if @post.save()
            redirect_to(microposts_path())
        else
            render(:new, status: :unprocessable_entity)
        end
    end

    def edit()
        @post = Micropost.find(params[:id])
    end

    def update()
        @post = Micropost.find(params[:id])

        if @post.update(verify_user_params())
            redirect_to(@post)
        else
            render(:edit, status: :unprocessable_entity)
        end
    end

    def destroy()
        @post = Micropost.find(params[:id])
        @post.destroy()

        redirect_to(microposts_path(), status: :see_other)
    end

    private def verify_user_params()
        return params.require(:micropost).permit(:content, :user_id)
    end
end
