class EmailsAnswersWorker
  include Sidekiq::Worker

  def perform(question, company)

  end
end
