class UsersController < ApplicationController
    def index()
        @users = User.all()
    end

    def show()
        @user = User.find(params[:id])
    end

    def new()
        @user = User.new()
    end

    def create()
        @user = User.new(verify_user_params())

        if @user.save()
            redirect_to(users_path())
        else
            render(:new, status: :unprocessable_entity)
        end
    end

    def edit()
        @user = User.find(params[:id])
    end

    def update()
        @user = User.find(params[:id])

        if @user.update(verify_user_params())
            redirect_to(@user)
        else
            render(:edit, status: :unprocessable_entity)
        end
    end

    def destroy()
        @user = User.find(params[:id])
        @user.destroy()

        redirect_to(users_path(), status: :see_other)
    end

    private def verify_user_params()
        return params.require(:user).permit(:name, :email)
    end
end
