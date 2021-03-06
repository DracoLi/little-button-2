class SettingsController < ApplicationController
  layout "settings"

  include Devise::Models::DatabaseAuthenticatable

  before_filter :authenticate_user_is_admin, only: [:admin,
                                                    :update_company_name,
                                                    :update_collect_answers_schedule,
                                                    :update_collect_questions_schedule,
                                                    :update_email_answers_schedule]

  def index
    redirect_to settings_account_path
  end

  def settings_update_name
    if current_user.update_attributes(user_name_params)
      flash[:sucess] = 'Your name is updated'
    else
      flash[:error] = 'Unable to update your name'
    end
    redirect_to settings_account_path
  end

  def settings_update_password
    if current_user.update_with_password(password_params)
      if password_params[:password].length <= 0
        current_user.errors.add(:password, 'Please provide a new password')
        render 'account'
      else
        sign_in current_user, :bypass => true
        flash[:sucess] = 'Your password is changed'
        redirect_to settings_account_path
      end
    else
      render 'account'
    end
  end

  def update_company
    target_key = company_params.keys.first
    if target_key == 'name'
      key_name = 'name'
    elsif target_key == 'botname'
      key_name = 'bot name'
    elsif target_key == 'timezone'
      key_name = 'timezone'
    elsif target_key == 'email_domain'
      key_name = 'domain'
    end

    if company_params[target_key].length == 0
      flash[:error] = "You must provide a #{key_name}."
    elsif current_user.company.update_attributes(company_params)
      flash[:sucess] = "Company #{key_name} updated."
    else
      flash[:error] = "Unable to update #{key_name}."
    end

    redirect_to settings_admin_path
  end

  def update_collect_answers_schedule
    schedule = current_user.company.collect_answers_schedule
    if schedule.update_attributes(schedule_params)
      flash[:sucess] = 'Schedule for collect answer emails updated.'
      redirect_to settings_admin_path
    else
      render 'admin'
    end
  end

  def update_collect_questions_schedule
    schedule = current_user.company.collect_questions_schedule
    if schedule.update_attributes(schedule_params)
      flash[:sucess] = 'Schedule for collect question emails updated.'
      redirect_to settings_admin_path
    else
      render 'admin'
    end
  end

  def update_email_answers_schedule
    schedule = current_user.company.email_answers_schedule
    if schedule.update_attributes(schedule_params)
      flash[:sucess] = 'Schedule for question answer emails updated.'
      redirect_to settings_admin_path
    else
      render 'admin'
    end
  end

  private

    def schedule_params
      adjusted_params = params.require(:scheduled_time).permit(:frequency, :day, :time, :ampm)

      # Adjust time for saving into database
      hour, min = adjusted_params[:time].split(':').map(&:to_i)
      hour += 12 if adjusted_params[:ampm] == 'PM'
      begin
        adjusted_params[:time] = Time.utc(2000, 01, 1, hour, min)
      rescue
        adjusted_params[:time] = Time.utc(2000, 01, 1, 12, 0)
      end

      adjusted_params.delete(:ampm)
      adjusted_params
    end

    def company_params
      params.require(:company).permit(:name, :botname, :timezone, :email_domain)
    end

    def user_name_params
      params.require(:user).permit(:name)
    end

    def password_params
      params.require(:user).permit(:password, :password_confirmation,
                                   :current_password)
    end
end
