FactoryGirl.define do
  factory :trip do
    user nil
    destination 'MyString'
    comment 'MyText'
    start_date '2017-04-27'
    end_date '2017-04-27'
  end
end
