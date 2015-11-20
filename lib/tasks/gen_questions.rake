namespace :gen_questions do

  desc "Generate a 100 questions with 10 answers each"
  task gen_questions_and_answers: :environment do
    users = Userr.all
    100.times do
        q = Question.create(title: Faker::Company.catch_phrase,
                            body: Faker::Lorem.paragraph)
        q.user = users.sample
        q.save
        10.times do
          q.answers.create(body: Faker::Company.bs)
        end

    end
  end

end
