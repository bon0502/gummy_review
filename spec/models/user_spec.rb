require 'rails_helper'

RSpec.describe User, type: :model do
  # subject を定義して、テスト対象のユーザーを明示的に作成
  subject { create(:user) }

  # バリデーションのテスト
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).case_insensitive }

  # アソシエーションのテスト
  it { should have_many(:reviews).dependent(:destroy) }
  it { should have_many(:likes).dependent(:destroy) }
  it { should have_many(:comments).dependent(:destroy) }
end
