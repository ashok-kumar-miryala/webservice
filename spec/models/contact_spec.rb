require 'rails_helper'

RSpec.describe Contact, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
end
