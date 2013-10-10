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
      flash[:sucess] = 'Your name is updated.'
    else
      flash[:error] = 'Unable to update your name.'
    end
    redirect_to settings_account_path
  end

  def settings_update_password
    if current_user.update_with_password(password_params)
      if password_params[:password].length <= 0
        current_user.errors.add(:password, 'Please provide a new password.')
        render 'account'
      else
        sign_in current_user, :bypass => true
        flash[:sucess] = 'Your password is changed.'
        redirect_to settings_account_path
      end
    else
      render 'account'
    end
  end

  def update_company_name
    if current_user.company.update_attributes(company_name_params)
      flash[:sucess] = 'Company name is updated.'
    else
      flash[:error] = 'Unable to update company name.'
    end
    redirect_to settings_admin_path
  end

  def update_collect_answers_schedule
    schedule = current_user.company.collect_answers_schedule
    if schedule.update_attributes(schedule_params)
      flash[:sucess] = 'Schedule for collect answer emails are updated.'
      redirect_to settings_admin_path
    else
      render 'admin'
    end
  end

  def update_collect_questions_schedule
    schedule = current_user.company.collect_questions_schedule
    if schedule.update_attributes(schedule_params)
      flash[:sucess] = 'Schedule for collect question emails are updated.'
      redirect_to settings_admin_path
    else
      render 'admin'
    end
  end

  def update_email_answers_schedule
    schedule = current_user.company.email_answers_schedule
    if schedule.update_attributes(schedule_params)
      flash[:sucess] = 'Schedule for question answer emails are updated.'
      redirect_to settings_admin_path
    else
      render 'admin'
    end
  end

  private

    def schedule_params
      adjusted_params = params.require(:scheduled_time).permit(:frequency, :day, :time, :ampm)
      adjusted_params[:time] = Time.parse("#{adjusted_params[:time]} #{adjusted_params[:ampm]}", Time.now)
      adjusted_params.delete(:ampm)
      adjusted_params
    end

    def company_name_params
      params.require(:company).permit(:name)
    end

    def user_name_params
      params.require(:user).permit(:name)
    end

    def password_params
      params.require(:user).permit(:password, :password_confirmation,
                                   :current_password)
    end
end
