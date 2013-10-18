require 'csv'
module Parsers
  module OldGoogleForm

    GENERAL_COLUMNS = [
      'Timestamp',
      'First Name',
      'Last Name',
      'Username'
    ]

    def self.parse_data(csv,  company)
      CSV.open(csv, encoding: "UTF-8", headers: true).each do |row|

        # Create this user if not exists without confirmation
        name = "%s %s" % [row['First Name'], row['Last Name']]
        if User.where(name: name, company: company).exists?
          user = User.where(name: name, company: company).first
        else
          user = User.new({
            company: company,
            name: name,
            email: row['First Name'][0].downcase + row['Last Name'].downcase + \
                   '@' + company.email_domain,
            password: 'password'
          })
          user.skip_confirmation!
          user.save!
          user.no_welcome_email = true
          user.confirm!
        end

        # Add answers and questions
        row.each do |k, v|
          unless  GENERAL_COLUMNS.include? k
            question = k.strip
            response = v

            # Get/create question
            ques_data = {
              company: company,
              content: question
            }
            ques = Question.where(ques_data).first_or_create({
              added_source: 'csv'
            })

            # Get/create and update response
            ans = Answer.where({
              user: user,
              question: ques
            }).first_or_create
            ans.content = response
            ans.save
          end
        end
      end
    end

  end
end
